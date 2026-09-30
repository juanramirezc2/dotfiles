# If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && exec sway

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
[ -f "$HOME/.orbstack/shell/init.bash" ] && source "$HOME/.orbstack/shell/init.bash"

# Added by Obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

# Login shells read this file, then the interactive config.
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"
