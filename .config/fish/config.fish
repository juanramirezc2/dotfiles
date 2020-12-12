#!/usr/bin/fish
fish_vi_key_bindings
set -x PATH $PATH /sbin/

function ll
  ls -lh $argv
end

abbr p "sudo pacman"
abbr ka "killall"
abbr g "git"
abbr -a -g gco git checkout
#alias
# This needs to have the spaces escaped or "Chrome.app..." will be seen as an argument to "/Applications/Google":
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome banana'
alias caracol="mplayer http://15363.live.streamtheworld.com/CARACOL_RADIOAAC_SC"

set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/ruby/bin" $fish_user_paths
