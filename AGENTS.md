# Agent context

## What this repo is

This is a personal dotfiles repository. Each top-level folder is a "package" that mirrors the layout of `$HOME` and is meant to be symlinked into the home directory using the `dot-link.sh` script (a pure-bash GNU-stow replacement) at the root of the repo.

Layout convention: a file at `<package>/<path>` is linked to `~/<path>`. Examples:

- `zsh/.zshrc` → `~/.zshrc`
- `git/.gitconfig` → `~/.gitconfig`
- `neovim/.config/nvim/` → `~/.config/nvim/`

When adding a new config file, place it inside the package folder at the same relative path it should occupy in `$HOME`. Do not put real config files at the repo root.

## Public repository — no secrets

This repo is **tracked on GitHub as a public repository**. Anything committed here is world-readable, forever, even if later deleted (Git history + GitHub forks/caches).

**NEVER include sensitive information in any file in this repo.** That includes, but is not limited to:

- API keys, tokens, OAuth credentials, personal access tokens
- Passwords, passphrases, SSH private keys, GPG private keys
- `.env` files with real values, service account JSON, cloud credentials
- Internal hostnames, private IPs, or company-internal URLs that aren't already public
- Email addresses or identifiers beyond what the user has already chosen to publish here

If a config file needs a secret, reference it from an environment variable or an untracked local file (e.g. `~/.zshrc.local`, `~/.config/<tool>/secrets`) that lives outside this repo. When in doubt, ask before committing.

## Common operations

- Link packages: `./dot-link.sh <pkg> [<pkg>...]`
- Preview without changing anything: `./dot-link.sh --dry-run <pkg>`
- Absorb existing files in `$HOME` into the repo: `./dot-link.sh --adopt <pkg>`
