# Standard XDG base directory. Set explicitly because macOS Go/TUI tools
# (lazygit, etc.) otherwise default to ~/Library/Application Support.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
