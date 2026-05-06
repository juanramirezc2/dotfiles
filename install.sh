#!/usr/bin/env bash
# Bootstrap installer for https://github.com/juanramirezc2/dotfiles
#
#   curl -fsSL https://raw.githubusercontent.com/juanramirezc2/dotfiles/local-lazy/install.sh | bash
#
# Env-var overrides (all optional):
#   DOTFILES_DIR=$HOME/dotfiles            where to clone the repo
#   DOTFILES_REPO=https://github.com/juanramirezc2/dotfiles.git
#   DOTFILES_BRANCH=                       defaults to repo default branch
#   DOTFILES_PACKAGES=zsh,git,neovim       skip the interactive menu
#   DOTFILES_ADOPT=1                       use `dot-link.sh --adopt` (absorbs existing files)

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/juanramirezc2/dotfiles.git}"
DOTFILES_BRANCH="${DOTFILES_BRANCH:-}"
DOTFILES_PACKAGES="${DOTFILES_PACKAGES:-}"
DOTFILES_ADOPT="${DOTFILES_ADOPT:-}"

# Packages excluded from the menu — not normal link targets, or unused.
EXCLUDED_PACKAGES=(fonts tmuxinator wakatime)

# ---------------------------------------------------------------------------
# Output helpers
# ---------------------------------------------------------------------------

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
  C_BOLD=$'\033[1m'; C_DIM=$'\033[2m'; C_RED=$'\033[31m'
  C_GREEN=$'\033[32m'; C_YELLOW=$'\033[33m'; C_BLUE=$'\033[34m'; C_RESET=$'\033[0m'
else
  C_BOLD=""; C_DIM=""; C_RED=""; C_GREEN=""; C_YELLOW=""; C_BLUE=""; C_RESET=""
fi

info()  { printf '%s==>%s %s\n' "$C_BLUE"   "$C_RESET" "$*"; }
ok()    { printf '%s✓%s   %s\n' "$C_GREEN"  "$C_RESET" "$*"; }
warn()  { printf '%s!%s   %s\n' "$C_YELLOW" "$C_RESET" "$*" >&2; }
err()   { printf '%s✗%s   %s\n' "$C_RED"    "$C_RESET" "$*" >&2; }
die()   { err "$*"; exit 1; }

# ---------------------------------------------------------------------------
# Reopen /dev/tty so prompts work under `curl ... | bash`
# ---------------------------------------------------------------------------

INTERACTIVE=1
if [ ! -t 0 ]; then
  # Try to attach /dev/tty to stdin so prompts work under `curl ... | bash`.
  # Probe in a subshell first: if that fails, there's no controlling tty
  # (CI / container) and we fall back to non-interactive mode without
  # leaking a "Device not configured" message to the user.
  if ( exec </dev/tty ) 2>/dev/null; then
    exec </dev/tty
  else
    INTERACTIVE=0
  fi
fi

confirm() {
  # confirm "Question?" [default Y|n]; returns 0 for yes, 1 for no.
  local prompt="$1" default="${2:-Y}" reply
  if [ "$INTERACTIVE" -eq 0 ]; then
    [ "$default" = "Y" ]
    return
  fi
  local hint
  case "$default" in
    Y|y) hint="[Y/n]" ;;
    *)   hint="[y/N]" ;;
  esac
  printf '%s %s ' "$prompt" "$hint"
  read -r reply || reply=""
  reply="${reply:-$default}"
  case "$reply" in
    Y|y|YES|yes) return 0 ;;
    *)           return 1 ;;
  esac
}

# ---------------------------------------------------------------------------
# Dependency checks
# ---------------------------------------------------------------------------

require_git() {
  if command -v git >/dev/null 2>&1; then return; fi
  err "git is not installed."
  case "$(uname -s)" in
    Darwin) err "On macOS, run: xcode-select --install" ;;
    Linux)  err "Install git via your package manager (apt/dnf/pacman)." ;;
  esac
  exit 1
}

# ---------------------------------------------------------------------------
# Clone / sync the repo
# ---------------------------------------------------------------------------

sync_repo() {
  if [ -d "$DOTFILES_DIR" ]; then
    if [ ! -d "$DOTFILES_DIR/.git" ]; then
      die "$DOTFILES_DIR exists but is not a git repository. Move it aside or set DOTFILES_DIR=…"
    fi
    local remote
    remote="$(git -C "$DOTFILES_DIR" config --get remote.origin.url 2>/dev/null || echo "")"
    case "$remote" in
      *juanramirezc2/dotfiles*) ;;
      *) die "$DOTFILES_DIR is a git repo, but origin is '$remote' (expected juanramirezc2/dotfiles). Aborting." ;;
    esac
    info "Found existing dotfiles repo at $DOTFILES_DIR"
    if confirm "Pull latest changes?" Y; then
      git -C "$DOTFILES_DIR" pull --ff-only || warn "git pull failed; continuing with current checkout."
    fi
  else
    info "Cloning $DOTFILES_REPO into $DOTFILES_DIR"
    if [ -n "$DOTFILES_BRANCH" ]; then
      git clone --branch "$DOTFILES_BRANCH" "$DOTFILES_REPO" "$DOTFILES_DIR"
    else
      git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    fi
  fi
}

# ---------------------------------------------------------------------------
# Discover available packages
# ---------------------------------------------------------------------------

is_excluded() {
  local pkg="$1" ex
  for ex in "${EXCLUDED_PACKAGES[@]}"; do
    [ "$pkg" = "$ex" ] && return 0
  done
  return 1
}

discover_packages() {
  # Echoes one package name per line, alphabetically.
  local entry name
  for entry in "$DOTFILES_DIR"/*/; do
    [ -d "$entry" ] || continue
    name="$(basename "$entry")"
    case "$name" in .*) continue ;; esac
    if is_excluded "$name"; then continue; fi
    printf '%s\n' "$name"
  done | sort
}

# ---------------------------------------------------------------------------
# Interactive multi-select menu
# ---------------------------------------------------------------------------

print_menu() {
  local -a pkgs=("$@")
  local cols rows i pad maxlen=0 name
  for name in "${pkgs[@]}"; do
    [ "${#name}" -gt "$maxlen" ] && maxlen=${#name}
  done
  pad=$((maxlen + 6))           # "NN) name" + spacing
  cols=$(( ${COLUMNS:-$(tput cols 2>/dev/null || echo 80)} / pad ))
  [ "$cols" -lt 1 ] && cols=1
  [ "$cols" -gt 3 ] && cols=3   # readability cap
  rows=$(( (${#pkgs[@]} + cols - 1) / cols ))

  printf '\n%sAvailable packages:%s\n' "$C_BOLD" "$C_RESET"
  for ((i=0; i<rows; i++)); do
    local c idx
    for ((c=0; c<cols; c++)); do
      idx=$((c * rows + i))
      if [ "$idx" -lt "${#pkgs[@]}" ]; then
        printf '  %s%2d)%s %-*s' "$C_DIM" "$((idx + 1))" "$C_RESET" "$maxlen" "${pkgs[$idx]}"
      fi
    done
    printf '\n'
  done
  printf '\n'
}

select_packages() {
  # Prints chosen package names (one per line) on stdout. All other output to stderr.
  local -a all=("$@") chosen=()

  # Non-interactive override.
  if [ -n "$DOTFILES_PACKAGES" ]; then
    local IFS=', '
    # shellcheck disable=SC2206
    local requested=($DOTFILES_PACKAGES)
    local req name found
    for req in "${requested[@]}"; do
      [ -z "$req" ] && continue
      found=0
      for name in "${all[@]}"; do
        if [ "$name" = "$req" ]; then chosen+=("$name"); found=1; break; fi
      done
      [ "$found" -eq 1 ] || { err "Unknown package in DOTFILES_PACKAGES: $req"; exit 1; }
    done
    printf '%s\n' "${chosen[@]}"
    return
  fi

  if [ "$INTERACTIVE" -eq 0 ]; then
    err "No TTY available and DOTFILES_PACKAGES is not set."
    err "Re-run interactively, or set e.g. DOTFILES_PACKAGES=zsh,git,neovim"
    exit 1
  fi

  print_menu "${all[@]}" >&2

  while :; do
    printf '%sSelect packages%s [e.g. 1,3,5  or  1 3 5  or  all  or  none]: ' "$C_BOLD" "$C_RESET" >&2
    local input
    read -r input || input=""
    input="${input## }"; input="${input%% }"

    case "$input" in
      ""|none|NONE) chosen=(); break ;;
      all|ALL)      chosen=("${all[@]}"); break ;;
      *)
        chosen=()
        local IFS=$' ,\t'
        # shellcheck disable=SC2206
        local tokens=($input)
        local bad=0 tok n
        for tok in "${tokens[@]}"; do
          [ -z "$tok" ] && continue
          if ! [[ "$tok" =~ ^[0-9]+$ ]]; then
            err "Not a number: '$tok'"; bad=1; break
          fi
          n=$((10#$tok))
          if [ "$n" -lt 1 ] || [ "$n" -gt "${#all[@]}" ]; then
            err "Out of range: $n (valid: 1..${#all[@]})"; bad=1; break
          fi
          chosen+=("${all[$((n - 1))]}")
        done
        [ "$bad" -eq 0 ] && break
        ;;
    esac
  done

  printf '%s\n' "${chosen[@]+"${chosen[@]}"}"
}

# ---------------------------------------------------------------------------
# dot-link: dry-run conflict check, then real run
# ---------------------------------------------------------------------------

link_packages() {
  local -a pkgs=("$@")
  if [ "${#pkgs[@]}" -eq 0 ]; then
    info "Nothing selected — skipping link step."
    return
  fi

  local linker="$DOTFILES_DIR/dot-link.sh"
  if [ ! -f "$linker" ]; then
    die "dot-link.sh not found at $linker"
  fi

  info "Selected: ${pkgs[*]}"
  if [ "$INTERACTIVE" -eq 1 ] && ! confirm "Link these packages into $HOME?" Y; then
    warn "Aborted by user."
    exit 0
  fi

  local link_args=(-d "$DOTFILES_DIR" -t "$HOME")
  if [ -n "$DOTFILES_ADOPT" ]; then
    warn "DOTFILES_ADOPT=1 — using '--adopt'. Existing files in \$HOME will be absorbed into $DOTFILES_DIR."
    link_args+=(--adopt)
  fi

  info "Checking for conflicts (dry-run)..."
  local dry
  if ! dry="$(bash "$linker" -n "${link_args[@]}" "${pkgs[@]}" 2>&1)"; then
    err "dot-link dry-run reported conflicts:"
    printf '%s\n' "$dry" >&2
    err ""
    err "Resolve the conflicts and re-run, or re-run with DOTFILES_ADOPT=1 to absorb"
    err "existing files into the dotfiles repo (review the result with 'git diff' afterward)."
    exit 1
  fi

  info "Linking for real..."
  bash "$linker" "${link_args[@]}" "${pkgs[@]}"

  ok "Done. Linked: ${pkgs[*]}"
  info "If you linked zsh, start a new shell (or run: exec \$SHELL -l) to pick up the changes."
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

main() {
  printf '%sDotfiles installer%s — %s\n' "$C_BOLD" "$C_RESET" "$DOTFILES_REPO"

  require_git
  sync_repo

  local -a available=()
  local line
  while IFS= read -r line; do
    available+=("$line")
  done < <(discover_packages)
  if [ "${#available[@]}" -eq 0 ]; then
    die "No packages found in $DOTFILES_DIR"
  fi

  # Capture via command substitution (not process substitution) so that an
  # `exit` inside select_packages — e.g. on an unknown DOTFILES_PACKAGES name —
  # propagates and aborts the install. `local` is split from the assignment so
  # `set -e` actually sees the failure (otherwise `local` masks the status).
  local raw
  raw="$(select_packages "${available[@]}")"
  local -a selected=()
  while IFS= read -r line; do
    [ -n "$line" ] && selected+=("$line")
  done <<< "$raw"

  link_packages "${selected[@]+"${selected[@]}"}"
}

main "$@"
