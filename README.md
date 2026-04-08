# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

Each top-level folder is a Stow package that symlinks files into `$HOME`.

Examples:

- `zsh/.zshrc` -> `~/.zshrc`
- `git/.gitconfig` -> `~/.gitconfig`
- `neovim/.config/nvim` -> `~/.config/nvim`

The Neovim setup is a local [LazyVim](https://github.com/LazyVim/LazyVim) config, not because I'm lazy, but because I take doing absolutely nothing very seriously.

![Dotfiles screenshot](./zsh.png)

## Install

```sh
git clone git@github.com:juanramirezc2/dotfiles.git ~/dotfiles
brew install stow
cd ~/dotfiles
```

## Usage

Stow the packages you want:

```sh
stow --target="$HOME" zsh git neovim tmux
```

Stow a single package:

```sh
stow --target="$HOME" ghostty
```

Remove a package:

```sh
stow -D --target="$HOME" neovim
```
