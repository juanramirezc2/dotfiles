# save bash history
HISTFILE=~/.bash_history
HISTSIZE=10000
HISTFILESIZE=1000
shopt -s histappend
# Don't add commands starting with ":" to history
HISTIGNORE=':*'
# Share history across sessions, same idea as zsh SHARE_HISTORY
__dotfiles_share_history() {
  history -a
  history -n
}
PROMPT_COMMAND=__dotfiles_share_history

# Standard XDG base directory.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

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

    index_state="${line:0:1}"
    worktree_state="${line:1:1}"

    if [[ "$index_state" != " " && "$git_state" != *+* ]]; then
      git_state+="+"
    fi
    if [[ "$worktree_state" != " " && "$git_state" != *\!* ]]; then
      git_state+="!"
    fi
  done <<< "$git_status"

  printf ' \[\e[38;5;240m\]on\[\e[0m\] \[\e[1;38;5;24m\]%s\[\e[0m\]' "$branch"
  [[ -n "$git_state" ]] && printf ' \[\e[38;5;96m\][%s]\[\e[0m\]' "$git_state"
}

__dotfiles_git_worktree_prompt() {
  local worktree
  worktree="$(git rev-parse --show-toplevel 2>/dev/null)" || return
  worktree="${worktree##*/}"

  printf ' \[\e[38;5;240m\]worktree\[\e[0m\] \[\e[1;38;5;24m\]%s\[\e[0m\]' "${worktree//%/%%}"
}

# user at host in directory, then git branch. Bash has no right prompt, so the
# worktree sits at the end of the first line.
PS1='\[\e[1;38;5;130m\]\u\[\e[0m\] \[\e[38;5;240m\]at\[\e[0m\] \[\e[1;38;5;136m\]\h\[\e[0m\] \[\e[38;5;240m\]in\[\e[0m\] \[\e[1;38;5;64m\]\w\[\e[0m\]$(__dotfiles_git_prompt)$(__dotfiles_git_worktree_prompt)\n\[\e[38;5;240m\]$\[\e[0m\] '
shopt -s autocd		# Automatically cd into typed directory.

# ------------- Basic auto/tab complete: {{{
if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  # shellcheck disable=SC1091
  . /usr/share/bash-completion/bash_completion
fi
# }}}

# vi line editing, the bash stand-in for zsh bindkey -v.
# Bash has no zsh menuselect keymap, so the hjkl menu binds are not carried over.
set -o vi

# aliases
alias zshconfig="nvim ~/.zshrc"
alias bashconfig="nvim ~/.bashrc"
alias record="asciinema rec"
alias tmux="tmux -u"
alias ag='ag --path-to-ignore ~/.ignore'
alias gs='git status'
alias gl='git log --graph --oneline --all'
alias ls='ls -FH --color=auto'
alias n='nvim'
alias luamake="$HOME/.code/lua-language-server/3rd/luamake/luamake"
export VISUAL=/usr/local/bin/nvim
# todo.sh alias
export TODOTXT_DEFAULT_ACTION=ls
alias lg='lazygit'
alias lazy='lazygit'
# NVM for managing node versions
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# FZF key bindings and completions
[[ -t 1 ]] && source <(fzf --bash)
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
eval "$(pyenv init - bash)"
export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim
export SEMAPHORE_API_TOKEN=xj4pWnTqmn-mi8lB93II

# >>> forge initialize >>>
# Bash has no oh-my-zsh plugin list, so the zsh autosuggestions and
# syntax-highlighting entries are not carried over. Forge itself is not
# started here, matching the current zshrc.
export FORGE_EDITOR="nvim"
# <<< forge initialize <<<

alias diff='revdiff --theme=auto'
