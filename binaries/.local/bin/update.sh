#!/usr/bin/env bash

# Daily update: Homebrew formulae/casks and global npm packages.

set -u

print_header() {
    printf "\n\033[1;34m==> %s\033[0m\n" "$1"
}

print_success() {
    printf "\033[1;32m✓ %s\033[0m\n" "$1"
}

print_error() {
    printf "\033[1;31m✗ %s\033[0m\n" "$1"
}

if command -v brew >/dev/null 2>&1; then
    print_header "Homebrew: update"
    brew update

    print_header "Homebrew: upgrade formulae"
    brew upgrade

    print_header "Homebrew: upgrade casks"
    brew upgrade --cask --greedy

    print_header "Homebrew: cleanup"
    brew cleanup -s
    brew autoremove

    print_header "Homebrew: doctor"
    brew doctor || true

    print_success "Homebrew up to date"
else
    print_error "Homebrew not installed, skipping"
fi

if command -v npm >/dev/null 2>&1; then
    print_header "npm: self-update"
    npm install -g npm

    print_header "npm: outdated global packages"
    npm outdated -g --depth=0 || true

    print_header "npm: update global packages"
    npm update -g

    print_success "npm globals up to date"
else
    print_error "npm not installed, skipping"
fi

print_header "Done"
