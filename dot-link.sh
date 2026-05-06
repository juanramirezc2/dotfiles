#!/usr/bin/env bash
# Pure-bash GNU-stow replacement for dotfiles. No external deps beyond
# coreutils (find, ln, mv, mkdir, readlink). Mirrors stow's behavior:
#   * Tree-folding: empty target dir → single symlink to package dir
#   * Tree-unfolding: existing folded symlink + new package dir → split into a
#     real dir and recurse on both sides
#   * Relative symlinks (portable if both trees move together)
#   * --adopt: real files at target are absorbed into the package
#   * Default ignore list: VCS metadata, README/LICENSE, editor swap files
#
# Usage:
#   dot-link.sh [-n|--dry-run] [-a|--adopt] [-d|--dir DIR] [-t|--target DIR] PKG [PKG...]
#
# Defaults:
#   --dir    $DOTFILES_DIR    (or $HOME/dotfiles)
#   --target $HOME

set -euo pipefail
shopt -s nullglob dotglob

DRY_RUN=0
ADOPT=0
STOW_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
TARGET_DIR="${HOME}"
PACKAGES=()

while [ $# -gt 0 ]; do
  case "$1" in
  -n | --dry-run)
    DRY_RUN=1
    shift
    ;;
  -a | --adopt)
    ADOPT=1
    shift
    ;;
  -d | --dir)
    STOW_DIR="$2"
    shift 2
    ;;
  -t | --target)
    TARGET_DIR="$2"
    shift 2
    ;;
  -h | --help)
    sed -n '2,/^$/p' "$0" | sed 's/^# \?//'
    exit 0
    ;;
  --)
    shift
    PACKAGES+=("$@")
    break
    ;;
  -*)
    echo "unknown flag: $1" >&2
    exit 2
    ;;
  *)
    PACKAGES+=("$1")
    shift
    ;;
  esac
done

if [ ${#PACKAGES[@]} -eq 0 ]; then
  echo "usage: $0 [-n] [-a] [-d STOW_DIR] [-t TARGET_DIR] PKG [PKG...]" >&2
  exit 2
fi

# Resolve to absolute paths so relative-path computation is correct.
STOW_DIR="$(cd "$STOW_DIR" && pwd)"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

CONFLICTS=()

# -------------------------------------------------------------------
# Ignore matching. Stow's default list, simplified to bash globs.
# Patterns match basenames only.
# -------------------------------------------------------------------

is_ignored() {
  local name="$1"
  case "$name" in
  .git | .gitignore | .gitmodules | .gitattributes) return 0 ;;
  .hg | .hgignore | .bzr | .bzrignore | .svn | _darcs | CVS | RCS | SCCS) return 0 ;;
  .stow-local-ignore | .non-stow-local-ignore) return 0 ;;
  README | README.* | LICENSE | LICENSE.* | COPYING | AUTHORS | CHANGELOG*) return 0 ;;
  Makefile | Makefile.* | GNUmakefile | configure | autom4te.cache) return 0 ;;
  .DS_Store | Thumbs.db) return 0 ;;
  *.bak | *.orig | *.swp | *~) return 0 ;;
  esac
  return 1
}

# -------------------------------------------------------------------
# Compute relative path from $1 (a directory) to $2 (any path).
# Pure bash, no realpath / python / perl.
# -------------------------------------------------------------------

relative_to() {
  local from="$1" to="$2"
  local -a from_parts to_parts
  IFS='/' read -ra from_parts <<<"$from"
  IFS='/' read -ra to_parts <<<"$to"

  local i=0 max=$((${#from_parts[@]} < ${#to_parts[@]} ? ${#from_parts[@]} : ${#to_parts[@]}))
  while [ "$i" -lt "$max" ] && [ "${from_parts[$i]}" = "${to_parts[$i]}" ]; do
    i=$((i + 1))
  done

  local result="" up=$((${#from_parts[@]} - i))
  while [ "$up" -gt 0 ]; do
    result+="../"
    up=$((up - 1))
  done

  local first=1
  while [ "$i" -lt "${#to_parts[@]}" ]; do
    if [ "$first" -eq 1 ]; then first=0; else result+="/"; fi
    result+="${to_parts[$i]}"
    i=$((i + 1))
  done

  [ -z "$result" ] && result="."
  printf '%s' "$result"
}

# -------------------------------------------------------------------
# Resolve an existing symlink to an absolute path.
# Stow stores relative links, so we resolve relative to the link's dir.
# -------------------------------------------------------------------

abs_link_target() {
  local link="$1" raw
  raw="$(readlink "$link")"
  case "$raw" in
  /*) printf '%s' "$raw" ;;
  *) printf '%s' "$(cd "$(dirname "$link")" && cd "$(dirname "$raw")" 2>/dev/null && pwd)/$(basename "$raw")" ;;
  esac
}

# -------------------------------------------------------------------
# Action runner. In dry-run, only prints; otherwise executes.
# -------------------------------------------------------------------

run() {
  local label="$1"
  shift
  if [ "$DRY_RUN" -eq 1 ]; then
    printf '  [dry] %s %s\n' "$label" "$*"
  else
    printf '  %s %s\n' "$label" "$*"
    "$@"
  fi
}

conflict() {
  CONFLICTS+=("$1")
  printf '  CONFLICT: %s\n' "$1" >&2
  # Stop the real run before we leave partial state behind.
  # In dry-run we keep collecting so the user sees the full list.
  if [ "$DRY_RUN" -eq 0 ]; then
    printf '\nAborting before partial changes are made. Re-run with --adopt to absorb existing files,\nor remove the conflicting target.\n' >&2
    exit 1
  fi
}

# -------------------------------------------------------------------
# Core: stow_node (single entry) and stow_contents (loop).
# Mutually recursive, mirrors stow's plan_stow().
# -------------------------------------------------------------------

stow_node() {
  local src="$1" tgt="$2" name
  name="$(basename "$src")"
  is_ignored "$name" && return 0

  if [ -L "$tgt" ]; then
    local existing_abs
    existing_abs="$(abs_link_target "$tgt")"
    if [ "$existing_abs" = "$src" ]; then
      return 0 # already linked correctly
    fi
    if [ -d "$existing_abs" ] && [ -d "$src" ]; then
      # Tree-unfolding: replace folded symlink with a real dir, then
      # re-link the previously-folded contents AND our new package's
      # contents into the now-real dir.
      #
      # Note: we recurse only after the unlink+mkdir have actually
      # happened, otherwise the recursive checks would see the still-
      # folded symlink and report spurious conflicts. In dry-run we
      # skip the recursion and just announce the unfold.
      if [ "$DRY_RUN" -eq 1 ]; then
        printf '  [dry] would unfold %s and re-stow contents from %s and %s\n' "$tgt" "$existing_abs" "$src"
        return 0
      fi
      run "unlink" rm "$tgt"
      run "mkdir" mkdir "$tgt"
      stow_contents "$existing_abs" "$tgt"
      stow_contents "$src" "$tgt"
      return 0
    fi
    conflict "symlink $tgt -> $existing_abs would be replaced by $src"
    return 0
  fi

  if [ -d "$tgt" ] && [ ! -L "$tgt" ]; then
    if [ -d "$src" ]; then
      stow_contents "$src" "$tgt"
      return 0
    fi
    conflict "cannot stow file $src over existing directory $tgt"
    return 0
  fi

  if [ -e "$tgt" ]; then
    if [ "$ADOPT" -eq 1 ]; then
      run "adopt(mv)" mv "$tgt" "$src"
      do_link "$src" "$tgt"
      return 0
    fi
    conflict "$tgt already exists (use --adopt to absorb into package)"
    return 0
  fi

  # Target doesn't exist — fold (link directory) or link file.
  do_link "$src" "$tgt"
}

stow_contents() {
  local src_dir="$1" tgt_dir="$2"
  local entry name
  for entry in "$src_dir"/*; do
    name="$(basename "$entry")"
    case "$name" in . | ..) continue ;; esac
    stow_node "$entry" "$tgt_dir/$name"
  done
}

do_link() {
  local src="$1" tgt="$2" rel parent
  parent="$(dirname "$tgt")"
  [ -d "$parent" ] || run "mkdir-p" mkdir -p "$parent"
  rel="$(relative_to "$parent" "$src")"
  run "link" ln -s "$rel" "$tgt"
}

# -------------------------------------------------------------------
# Main loop
# -------------------------------------------------------------------

for pkg in "${PACKAGES[@]}"; do
  src_root="$STOW_DIR/$pkg"
  if [ ! -d "$src_root" ]; then
    echo "package '$pkg' not found at $src_root" >&2
    exit 1
  fi
  printf '==> %s %s -> %s\n' "$pkg" "$src_root" "$TARGET_DIR"
  stow_contents "$src_root" "$TARGET_DIR"
done

if [ "${#CONFLICTS[@]}" -gt 0 ]; then
  printf '\n%d conflict(s) — see above.\n' "${#CONFLICTS[@]}" >&2
  exit 1
fi

if [ "$DRY_RUN" -eq 1 ]; then
  printf '\nDry run clean. Re-run without --dry-run to apply.\n'
fi
