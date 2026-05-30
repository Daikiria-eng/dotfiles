alias ls="lsd"
alias grep="grep --color=auto"
alias clear="bash $HOME/.clear_screen.sh"

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

setopt histignorealldups sharehistory

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3;5~" kill-word
bindkey "^[[3~" delete-char

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
WORDCHARS=${WORDCHARS//-/}
WORDCHARS=${WORDCHARS//./}
WORDCHARS=${WORDCHARS//*/}

export EDITOR=nvim
export VISUAL=nvim
export PAGER=bat

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(oh-my-posh init zsh --config ~/.config/posh.conf/space.json)"
