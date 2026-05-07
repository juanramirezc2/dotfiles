# Dotfiles

Personal dotfiles managed with the local `dot-link.sh` script.

Each top-level folder is a package that symlinks files into `$HOME`.

Examples:

- `zsh/.zshrc` -> `~/.zshrc`
- `git/.gitconfig` -> `~/.gitconfig`
- `neovim/.config/nvim` -> `~/.config/nvim`

The Neovim setup is a local [LazyVim](https://github.com/LazyVim/LazyVim) config, not because I'm lazy, but because I take doing absolutely nothing very seriously.

![Dotfiles screenshot](./zsh.png)

## Install

One-liner — clones the repo, then opens an interactive picker so you can choose which packages to link:

```sh
curl -fsSL https://raw.githubusercontent.com/juanramirezc2/dotfiles/master/install.sh | bash
```

Non-interactive (skip the picker):

```sh
curl -fsSL https://raw.githubusercontent.com/juanramirezc2/dotfiles/master/install.sh \
  | DOTFILES_PACKAGES=zsh,git,neovim,tmux bash
```

Env-var overrides: `DOTFILES_DIR` (default `~/dotfiles`), `DOTFILES_REPO`, `DOTFILES_BRANCH`, `DOTFILES_PACKAGES`, `DOTFILES_ADOPT=1` (use `dot-link.sh --adopt` to absorb existing files).

Manual install:

```sh
git clone git@github.com:juanramirezc2/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

## Usage

Link the packages you want:

```sh
./dot-link.sh zsh git neovim tmux
```

Link a single package:

```sh
./dot-link.sh ghostty
```

Preview changes before linking:

```sh
./dot-link.sh --dry-run zsh git neovim tmux
```

Absorb existing files into the repo before linking:

```sh
./dot-link.sh --adopt zsh git neovim tmux
```
