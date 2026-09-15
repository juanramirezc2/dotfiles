# Agent Instructions

## Repository Model

This is a personal GNU Stow dotfiles repository. Each normal top-level
directory is a package whose contents mirror paths below `$HOME`. GNU Stow is
the canonical linker. The root `dot-link.sh` script is a compatible pure-Bash
fallback that also creates relative symlinks back into these packages.

The package name is organizational and is removed from the destination path:

- `zsh/.zshrc` -> `~/.zshrc`
- `git/.gitconfig` -> `~/.gitconfig`
- `ghostty/.config/ghostty/config` -> `~/.config/ghostty/config`
- `binaries/.local/bin/update.sh` -> `~/.local/bin/update.sh`
- `neovim/.config/nvim/` -> `~/.config/nvim/`

For a requested home path `~/<path>`, put the tracked file at
`<package>/<path>`. For example, a new `~/.config/example/config.toml` belongs
at `example/.config/example/config.toml`.

## Making Changes

- Inspect the existing package before editing and preserve its conventions.
- Add user configuration inside a package, never directly at the repository
  root. Root files are repository tooling or documentation unless an existing
  root-level convention explicitly applies.
- Prefer an existing package when the target belongs to it. Create a new
  top-level package only for a distinct tool or independently linkable group.
- Keep the entire path below `$HOME` in the package, including hidden path
  components such as `.config` and `.local`.
- Edit files through their repository paths. A path under `$HOME` may already
  be a symlink into this repository, so writing there can silently modify the
  working tree.
- Preserve executable bits on scripts intended for `~/.local/bin` or invoked
  directly.
- Do not add generated caches, runtime state, machine-specific files, editor
  swap files, or application data that does not belong in portable config.
- Do not modify unrelated dirty worktree changes.

## Linking Safety

Use GNU Stow rather than manually creating home-directory symlinks:

```sh
stow --target="$HOME" <package> [<package>...]
```

Preview package links and conflicts before applying them:

```sh
stow --no --verbose --target="$HOME" <package> [<package>...]
```

Do not run a real link operation that changes `$HOME` unless the user asks for
it. A Stow simulation is safe and should be the default validation for package
layout. Use `dot-link.sh --dry-run` only when validating the fallback linker.

Stow's `--adopt` and `dot-link.sh --adopt` move existing destination files from
`$HOME` into the package before linking them. This can overwrite package
contents and capture private or machine-specific data. Never use either form of
`--adopt` without explicit user approval, and review the resulting diff for
secrets immediately afterward.

Stow and the fallback linker have ignore rules for repository metadata and
common backup files. Confirm the simulation output instead of assuming a file
will be ignored.

## New-Machine Setup and Dependencies

- On macOS, treat `brew.zsh` as the persistent Homebrew bootstrap manifest.
  When the user asks to keep a Homebrew installation, add the formula or cask
  there as well as installing it on the current machine if requested.
- Keep Homebrew entries one command per line and preserve requested variants
  such as `--HEAD`. Distinguish formulae from casks and check for package-manager
  conflicts before adding both.
- Treat "add to the list", "install", and "link" as separate actions. Do not
  infer permission to install software or modify `$HOME` from a request that
  only asks to update the repository.
- Verify command-line installations with both the package manager and the
  executable/version when practical. A GUI cask may be correctly installed
  without exposing a command on `PATH`.
- Validate version managers from the same login-shell sequence the user will
  run after linking. Variables set in `.zshenv` or `.zprofile` can change where
  runtimes are stored, so a manual `source` check alone may use the wrong home.
- A top-level package may be optional, historical, or platform-specific. Do not
  infer that every configured application should be installed; trace whether
  the selected shell/editor workflow actually references it and present
  optional alternatives separately.
- For a fresh Mac, use this order when the user requests the full setup: verify
  Xcode Command Line Tools and Homebrew, run `brew.zsh`, preview selected
  packages with `stow --no --verbose --target="$HOME"`, link only the approved
  packages with Stow, then run tool-specific bootstrap steps. Applying `.macos`
  remains a separate, explicit action because it changes system and application
  preferences.

## Platform and Managed Configuration

- The shell configuration contains both macOS and Linux/Wayland settings. Guard
  new platform-specific behavior instead of assuming every line applies to the
  current machine.
- Do not add hard-coded usernames, home paths, work directories, or application
  data paths. Use `$HOME`, XDG variables, or an untracked machine-local file.
- The block marked `forge initialize` in `zsh/.zshrc` is generated by Forge; do
  not edit inside it unless the user explicitly asks to change Forge-managed
  output.
- Do not assume `~/.zshrc.local` is loaded: the tracked shell config does not
  currently source it. If local overrides are requested, add an explicit,
  guarded source line before relying on that file.

## Git Diff Tooling (delta)

- `git/.gitconfig` sets `core.pager` and `interactive.diffFilter` to `delta`,
  and `lazygit/.config/lazygit/config.yml` uses `delta --paging=never`. Changing
  diff appearance means editing the delta feature blocks, not Git color
  settings.
- Delta themes live in `git/.config/delta/*.gitconfig` and are pulled in via
  `[include]` in `.gitconfig`. The active theme is the `features` key in the
  `[delta]` block.
- The catppuccin syntax themes ship inside delta and need nothing installed.
  The tokyonight themes do not: their `syntax-theme` names a custom bat
  `.tmTheme` that must exist under `~/.config/bat/themes` and be registered
  with `bat cache --build`. `bat` is therefore a hard dependency for the
  tokyonight features and is listed in `brew.zsh`.
- The tracked `.tmTheme` under `git/.config/bat/themes/` is a copy of
  `extras/sublime/` from the tokyonight.nvim plugin. When switching variants
  (day, night, storm, moon) copy the matching file from the plugin and keep
  the `syntax-theme` value equal to the name `bat --list-themes` reports.
- Delta only engages when stdout is a TTY, so `git diff | head` shows plain
  output. To inspect the rendered result non-interactively, pipe explicitly:
  `git diff <file> | delta`.
- A missing or unregistered syntax theme does not fail loudly. Delta prints
  `[bat warning]: Unknown theme ... using default` and falls back to Monokai
  Extended, which renders white text on the light tokyonight-day background.
  Treat that warning as a broken configuration.
- After linking a package, confirm with `ls -la` that the destination is a
  symlink into the repository. Plain copies under `~/.config` mean edits to the
  tracked file will not take effect until the package is re-linked.

## Validation

- Run `stow --no --verbose --target="$HOME" <package>` after changing a
  package's layout. Run `./dot-link.sh --dry-run <package>` as an additional
  check only when fallback-linker compatibility matters.
- Run the narrowest tool-specific syntax or configuration check available for
  edited config files.
- After touching delta or bat theme files, run `delta --show-config` and check
  for a `[bat warning]` line and that `syntax-theme` resolves to the intended
  theme, then run `delta --list-syntax-themes` to confirm the theme is
  registered.
- Run `bash -n <script>` for changed Bash scripts, plus any existing relevant
  tests.
- Inspect `git diff` to confirm the repository path maps to the intended path
  below `$HOME` and no generated or sensitive content was added.

## Public Repository: No Secrets

This repository is public. Anything committed is world-readable and can remain
available through Git history, forks, or caches even after deletion.

Never add sensitive information, including:

- API keys, tokens, OAuth credentials, or personal access tokens
- Passwords, passphrases, SSH private keys, or GPG private keys
- `.env` files with real values, service-account JSON, or cloud credentials
- Private hostnames, private IP addresses, or company-internal URLs
- Personal identifiers that the user has not already chosen to publish

Reference secrets through environment variables or untracked local files
outside this repository, such as `~/.zshrc.local` or
`~/.config/<tool>/secrets`. If a value may be sensitive, stop and ask before
adding it.

If an existing tracked credential is discovered, do not repeat its value in
output. Alert the user, recommend immediate revocation or rotation, and explain
that removing it from the current file does not remove it from Git history.
