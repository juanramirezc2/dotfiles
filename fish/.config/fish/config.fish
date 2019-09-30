#!/usr/bin/fish
fish_vi_key_bindings
set -x PATH $PATH /sbin/

function ll
  ls -lh $argv
end

abbr p "sudo pacman"
abbr ka "killall"
abbr g "git"
