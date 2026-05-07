# Juan's dotfiles

Personal dotfiles managed with the local `dot-link.sh` script.

Each top-level folder is a package that symlinks files into `$HOME`.

Examples:

- `zsh/.zshrc` -> `~/.zshrc`
- `git/.gitconfig` -> `~/.gitconfig`
- `neovim/.config/nvim` -> `~/.config/nvim`

The Neovim setup is a local [LazyVim](https://github.com/LazyVim/LazyVim) config, not because I'm lazy, but because I take doing absolutely nothing very seriously.

![Dotfiles screenshot](./zsh.png)

## Installation

Warning: these are personal dotfiles. If you want to try them, fork the repository, review the code, and remove anything you do not want or need. Do not blindly run someone else's shell configuration unless you know what it changes.

### Using the installer

The installer clones or updates the repository, then opens an interactive picker so you can choose which packages to link:

```sh
curl -fsSL https://raw.githubusercontent.com/juanramirezc2/dotfiles/master/install.sh | bash
```

To skip the picker, provide a comma-separated package list:

```sh
curl -fsSL https://raw.githubusercontent.com/juanramirezc2/dotfiles/master/install.sh \
  | DOTFILES_PACKAGES=zsh,git,neovim,tmux bash
```

Optional environment variables:

- `DOTFILES_DIR`: where to clone the repo; defaults to `~/dotfiles`
- `DOTFILES_REPO`: repository URL
- `DOTFILES_BRANCH`: branch to clone
- `DOTFILES_PACKAGES`: packages to link without the interactive picker
- `DOTFILES_ADOPT=1`: use `dot-link.sh --adopt` to absorb existing files

### Manual install

Clone the repository wherever you want. I usually keep it at `~/dotfiles`:

```sh
git clone git@github.com:juanramirezc2/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Then link the packages you want:

```sh
./dot-link.sh zsh git neovim tmux
```

### Updating

To update, pull the latest changes and rerun the installer or link command:

```sh
cd ~/dotfiles
git pull --ff-only
./install.sh
```

Or link specific packages directly:

```sh
./dot-link.sh zsh git neovim tmux
```

## Linking packages

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

## Customize locally

This repo does not currently source a private override file. Keep machine-specific changes in untracked local files, or fork and edit the packages intentionally.

## Sensible macOS defaults

When setting up a new Mac, you may want to apply the macOS defaults:

```sh
./.macos
```

Review the script before running it. It changes system and application preferences.

## Install Homebrew formulae

After installing [Homebrew](https://brew.sh/), install common command-line tools and apps:

```sh
./brew.zsh
```

Some shell and editor features assume these tools are installed, so review `brew.zsh` if you prefer to install dependencies manually.

## Feedback

Suggestions and improvements are welcome.

## Author

Juan Ramirez
