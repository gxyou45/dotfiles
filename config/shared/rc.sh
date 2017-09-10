export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR='vim'

# Use xterm-256color when not in tmux
[[ $TMUX == '' ]] && export TERM='xterm-256color'

# PATH
export PATH="/usr/bin/core_perl:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"
if [[ $OSTYPE == 'linux-gnu' ]]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
  export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"
fi
which python2 &> /dev/null && export PATH="$(python2 -m site --user-base)/bin:$PATH"
which python3 &> /dev/null && export PATH="$(python3 -m site --user-base)/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Aliases
alias cb=clipboard

[ -f ~/.rc.custom ] && source ~/.rc.custom
