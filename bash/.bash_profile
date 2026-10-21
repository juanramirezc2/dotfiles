# If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && exec sway

# Login shells read this file, then the interactive config.
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"
