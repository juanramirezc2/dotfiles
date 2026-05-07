# save zsh history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt SHARE_HISTORY
# Don't add commands starting with ":" to history
zshaddhistory() {
  [[ $1 != ':'* ]]
}
# Enable colors and change prompt:
autoload -U colors && colors
setopt PROMPT_SUBST

__dotfiles_git_prompt() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return

  local branch git_status line index_state worktree_state git_state
  branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)" || return
  git_status="$(git status --porcelain 2>/dev/null)"
  git_state=""

  while IFS= read -r line; do
    [[ -z "$line" ]] && continue

    if [[ "$line" == '?? '* ]]; then
      [[ "$git_state" != *\?* ]] && git_state+="?"
      continue
    fi

    index_state="${line[1,1]}"
    worktree_state="${line[2,2]}"

    if [[ "$index_state" != " " && "$git_state" != *+* ]]; then
      git_state+="+"
    fi
    if [[ "$worktree_state" != " " && "$git_state" != *\!* ]]; then
      git_state+="!"
    fi
  done <<< "$git_status"

  printf ' %%F{240}on%%f %%B%%F{24}%s%%f%%b' "$branch"
  [[ -n "$git_state" ]] && printf ' %%F{96}[%s]%%f' "$git_state"
}

PROMPT='%B%F{130}%n%f%b %F{240}at%f %B%F{136}%m%f%b %F{240}in%f %B%F{64}%~%f%b$(__dotfiles_git_prompt)
%F{240}$%f '
RPROMPT=''
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

# ------------- Basic auto/tab complete: {{{
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
# }}}

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

#}}}

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
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080,bold,underline"
#installed with git clone https://github.com/rupa/z ~/.zsh/z
source ~/.zsh/z/z.sh
# installed with git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#}}}
# aliases
alias zshconfig="nvim ~/.zshrc"
alias record="asciinema rec"
alias tmux="tmux -u"
alias ag='ag --path-to-ignore ~/.ignore'
alias gs='git status'
alias gl='git log --graph --oneline --all'
alias ls='ls -FHG'
alias n='nvim'
alias luamake= "$PATH:$HOME/.code/lua-language-server/3rd/luamake/luamake" 
export VISUAL=/usr/local/bin/nvim
# todo.sh alias
export TODOTXT_DEFAULT_ACTION=ls
alias lg='lazygit'
# NVM for managing node versions
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/ruby/bin:$PATH"
# FZF key bindings and completions
# source /usr/share/fzf/key-bindings.zsh
# source /usr/share/fzf/completion.zsh
source <(fzf --zsh)
# source RVM scripts
source "$HOME/.rvm/scripts/rvm" # $HOME installation
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
# Wayland variables
export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=wayland
export XDG_CURRENT_SESSION_TYPE=wayland
export GDK_BACKEND="wayland,x11"
export MOZ_ENABLE_WAYLAND=1
export ELECTRON_OZONE_PLATFORM_HINT=wayland
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
alias awsconfig="/Users/juanramirez/Work/nrdev/utility-scripts/awsconfig_wizard.rb"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim
export WIKI="/Users/juanramirez/Library/Mobile Documents/iCloud~md~obsidian/Documents/Wiki"
alias wiki='cd "$WIKI"'
alias farmer='cd "/Users/juanramirez/Library/Application Support/com.TheFarmerWasReplaced.TheFarmerWasReplaced/Saves/Save0"'
export SEMAPHORE_API_TOKEN=xj4pWnTqmn-mi8lB93II

# >>> forge initialize >>>
# !! Contents within this block are managed by 'forge zsh setup' !!
# !! Do not edit manually - changes will be overwritten !!

# Add required zsh plugins if not already present
if [[ ! " ${plugins[@]} " =~ " zsh-autosuggestions " ]]; then
    plugins+=(zsh-autosuggestions)
fi
if [[ ! " ${plugins[@]} " =~ " zsh-syntax-highlighting " ]]; then
    plugins+=(zsh-syntax-highlighting)
fi

# Load forge shell plugin (commands, completions, keybindings) if not already loaded
if [[ -z "$_FORGE_PLUGIN_LOADED" ]]; then
    eval "$(forge zsh plugin)"
fi

# Forge's theme overrides PROMPT. Keep the plugin loaded, but let this file own
# the prompt style.
# if [[ -z "$_FORGE_THEME_LOADED" ]]; then
#     eval "$(forge zsh theme)"
# fi

# Editor for editing prompts (set during setup)
# To change: update FORGE_EDITOR or remove to use $EDITOR
export FORGE_EDITOR="nvim"
# <<< forge initialize <<<
