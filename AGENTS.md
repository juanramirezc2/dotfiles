# Agent Instructions

## Repository Model

This is a personal dotfiles repository. Each normal top-level directory is a
package whose contents mirror paths below `$HOME`. The root `dot-link.sh`
script is a pure Bash GNU Stow replacement that creates relative symlinks from
the home directory back into these packages.

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

Use the repository linker rather than manually creating home-directory
symlinks:

```sh
./dot-link.sh <package> [<package>...]
```

Preview package links and conflicts before applying them:

```sh
./dot-link.sh --dry-run <package>
```

Do not run a real link operation that changes `$HOME` unless the user asks for
it. A dry run is safe and should be the default validation for package layout.

`--adopt` moves existing destination files from `$HOME` into the package before
linking them. This can overwrite package contents and capture private or
machine-specific data. Never use `--adopt` without explicit user approval, and
review the resulting diff for secrets immediately afterward.

The linker ignores common repository metadata and files such as `README*`,
`LICENSE*`, `.git`, and editor backup files. Do not rely on ignored files being
linked.

## Validation

- Run `./dot-link.sh --dry-run <package>` after changing a package's layout.
- Run the narrowest tool-specific syntax or configuration check available for
  edited config files.
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
