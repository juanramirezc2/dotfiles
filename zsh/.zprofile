# If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && exec sway

eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
