#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

brew install ripgrep
brew install stow
brew install mise
brew install nvm
brew install opencode
brew install openjdk@21
brew install pi-coding-agent
brew install pyenv
brew install --HEAD neovim
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install tree-sitter --HEAD
brew install tree-sitter-cli
brew install --cask 1password
brew install --cask brave-browser
brew install --cask claude
brew install --cask claude-code@latest
brew install --cask ghostty
brew install --cask google-chrome
brew install --cask karabiner-elements
brew install --cask obsidian
brew install --cask orbstack
brew install --cask rectangle
brew install --cask slack
brew install --cask steam
brew install --cask visual-studio-code
brew install --cask zoom
brew install fd
brew install fzf
brew install gh
brew install bat
brew install git-delta
brew install git-lfs
brew install lazygit
brew install ranger
brew install the_silver_searcher
brew install tmux
brew install tmuxinator


# Remove outdated versions from the cellar.
brew cleanup
