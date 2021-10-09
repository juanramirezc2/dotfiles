# Load version control information
autoload -Uz vcs_info
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git*' formats "%F{011} %b %m%u%c "
precmd() { vcs_info }
# Enable colors and change prompt:
autoload -U colors && colors
setopt PROMPT_SUBST
#PROMPT="%n in ${PWD/#$HOME/~} ${vcs_info_msg_0_} > "
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{magenta}%2~%f%b %# ❯'
RPROMPT=\$vcs_info_msg_0_
#PROMPT="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%3~%{$fg[red]%}]%{$reset_color%}$%b ${vcs_info_msg_0_}"
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

# ------------- Basic auto/tab complete: {{{
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
# }}}

#--------------- vi mode {{{
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

 #Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
    echo -ne '\e[5 q' # Use beam shape cursor on startup.
    preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
#}}}

#------------------- Plugins {{{
#installed with git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^e' autosuggest-accept
#installed with git clone https://github.com/rupa/z ~/.zsh/z
source ~/.zsh/z/z.sh
# installed with git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
#source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#}}}
export EDITOR=$(which nvim)
# aliases
alias zshconfig="nvim ~/.zshrc"
alias record="asciinema rec"
alias canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --ignore-certificate-errors &> /dev/null &"
alias tmux="tmux -u"
alias caracol="mplayer http://15363.live.streamtheworld.com/CARACOL_RADIOAAC_SC"
alias caracolp="mplayer http://17973.live.streamtheworld.com/CR_PEREIRA.mp3"
alias tx="tmuxinator start"
alias t='todo.sh'
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias ag='ag --path-to-ignore ~/.ignore'
alias gs='git status'
alias gl='git log --graph --oneline --all'
alias gc='git commit -m'
alias ga='git add'
alias gp='git push'
alias ls='ls -FHG'
alias n='nvim'
# change cwd on ranger exit
export RANGER_LOAD_DEFAULT_RC=false
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export VISUAL=/usr/local/bin/nvim
# todo.sh alias
export TODOTXT_DEFAULT_ACTION=ls
funcname lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--no-mouse --height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# suppose you have installed fzf to ~/.fzf, change it to what suits you
export FZF_BASE="$HOME/.fzf"
e() {fzf | xargs -I % $EDITOR % ;}
 zle -N e{,}
 bindkey "^h" e
 # pyenv added to the path
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

eval "$(pyenv init -)"
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"

# NVM for managing node versions
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/ruby/bin:$PATH"

export PHP_ID=php7_3; export PATH="/Applications/DevDesktop/php7_3_x64/bin:/Applications/DevDesktop/mysql/bin:/Applications/DevDesktop/tools:$PATH"

alias luamake= "$HOME/.code/lua-language-server/3rd/luamake/luamake" 
