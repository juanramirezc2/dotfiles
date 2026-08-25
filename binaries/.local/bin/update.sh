#!/usr/bin/env bash

# Daily update: Homebrew formulae/casks and global npm packages.
# Runs fully non-interactive: prompts (passwords, Y/N confirmations) fail
# fast and that update is skipped instead of blocking the script.

set -u

export NONINTERACTIVE=1
export HOMEBREW_NO_ASK=1
export HOMEBREW_NO_AUTO_UPDATE=1
# Make Homebrew's sudo calls fail immediately instead of prompting.
export SUDO_ASKPASS=/usr/bin/false
exec </dev/null

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
    homebrew_update_failed=0

    print_header "Homebrew: update"
    if ! brew update; then
        print_error "Homebrew metadata update failed"
        homebrew_update_failed=1
    fi

    print_header "Homebrew: upgrade formulae"
    if ! brew upgrade --formula --fetch-HEAD --no-ask; then
        print_error "Some formulae failed to update"
        homebrew_update_failed=1
    fi

    print_header "Homebrew: upgrade casks without password prompts"
    casks=$(brew outdated --cask --greedy --quiet 2>/dev/null || true)
    if [ -n "$casks" ]; then
        while IFS= read -r cask; do
            [ -n "$cask" ] || continue
            if brew upgrade --cask --greedy --no-ask "$cask" </dev/null; then
                print_success "$cask updated"
            else
                print_error "$cask skipped (upgrade failed or needs administrator access)"
                homebrew_update_failed=1
            fi
        done <<< "$casks"
    fi

    print_header "Homebrew: cleanup"
    brew cleanup -s
    brew autoremove

    print_header "Homebrew: doctor"
    brew doctor || true

    if [ "$homebrew_update_failed" -eq 0 ]; then
        print_success "Homebrew up to date"
    else
        print_error "Homebrew finished with skipped or failed updates"
    fi
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
