#!/usr/bin/env bash

# Install command-line tools on Debian.
# Uses apt, bun, and npm. Counterpart to brew.zsh. Apt names were checked against Debian 13.

# Make sure the package index is current.
sudo apt-get update

# Upgrade any already-installed packages.
sudo apt-get upgrade -y

# CLI tools with a Debian package.
sudo apt-get install -y ripgrep          # brew: ripgrep
sudo apt-get install -y stow             # brew: stow
sudo apt-get install -y openjdk-21-jdk   # brew: openjdk@21
sudo apt-get install -y pyenv            # brew: pyenv
sudo apt-get install -y neovim           # brew: neovim (--HEAD has no apt equivalent)
sudo apt-get install -y universal-ctags  # brew: universal-ctags (--HEAD)
sudo apt-get install -y libtree-sitter-dev  # brew: tree-sitter (--HEAD); library, not a CLI
sudo apt-get install -y fd-find          # brew: fd; the binary is fdfind, not fd
sudo apt-get install -y fzf              # brew: fzf
sudo apt-get install -y gh               # brew: gh
sudo apt-get install -y bat              # brew: bat
sudo apt-get install -y git-delta        # brew: git-delta
sudo apt-get install -y git-lfs          # brew: git-lfs
sudo apt-get install -y lazygit          # brew: lazygit
sudo apt-get install -y ranger           # brew: ranger
sudo apt-get install -y silversearcher-ag  # brew: the_silver_searcher
sudo apt-get install -y tmux             # brew: tmux
sudo apt-get install -y tmuxinator       # brew: tmuxinator

# App sandbox. Not in brew.zsh. Noninteractive so an existing /etc/fuse.conf does not stop the script.
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::=--force-confold flatpak

# In the Debian archive, but not the same tool.
sudo apt-get install -y nodejs           # closest to brew: nvm; this is the distro runtime, not a version manager
sudo apt-get install -y google-chrome-stable  # brew cask: google-chrome (needs Google's apt repo)

# Official npm packages. Bun is already on this machine.
bun install -g mise                              # brew: mise; npm: mise
bun install -g tree-sitter-cli                   # brew: tree-sitter-cli; npm: tree-sitter-cli
npm install -g --ignore-scripts @earendil-works/pi-coding-agent   # brew: pi-coding-agent; npm: @earendil-works/pi-coding-agent
bun install -g --trust @opencode/cli               # brew: opencode; npm: @opencode/cli
npm install -g @anthropic-ai/claude-code           # brew cask: claude-code; npm: @anthropic-ai/claude-code

# No Debian package and no real Bun package. Left out on purpose.
# brew install nvm
# brew install --cask 1password
# brew install --cask brave-browser
# brew install --cask claude
# brew install --cask ghostty
# brew install --cask karabiner-elements
# brew install --cask obsidian
# brew install --cask orbstack
# brew install --cask rectangle
# brew install --cask slack
# brew install --cask steam
# brew install --cask visual-studio-code
# brew install --cask zoom

# Remove packages that were installed only as dependencies and are no longer needed.
sudo apt-get autoremove -y
