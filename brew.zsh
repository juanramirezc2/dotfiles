#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

brew install ripgrep
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install tree-sitter --HEAD


# Remove outdated versions from the cellar.
brew cleanup
