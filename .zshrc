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

export PATH=$PATH:/opt/idea-IU-261.22158.277/bin:/opt/WebStorm-261.24374.125/bin
export PATH=/home/daiky/.nvm/versions/node/v24.15.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/idea-IU-261.22158.277/bin:/opt/WebStorm-261.24374.125/bin:/home/daiky/.local/bin
eval "$(oh-my-posh init zsh --config ~/.posh.conf/space.json)"
