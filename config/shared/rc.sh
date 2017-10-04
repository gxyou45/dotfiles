export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR='vim'

# Use xterm-256color when not in tmux
[[ $TMUX == '' ]] && export TERM='xterm-256color'

# PATH
export PATH="/usr/bin/core_perl:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
if [[ $OSTYPE == 'linux-gnu' ]]; then
  export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi
which python2 &> /dev/null && export PATH="$(python2 -m site --user-base)/bin:$PATH"
which python3 &> /dev/null && export PATH="$(python3 -m site --user-base)/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Aliases
alias cb=clipboard
alias sap='source ~/.agent-profile'

# Create per-user instance of ssh-agent
ps -u $(whoami) | grep '[ ]ssh-agent' &> /dev/null
if [ $? -ne 0 ]; then
  eval $(ssh-agent)
  ssh-add
  echo "export SSH_AGENT_PID=$SSH_AGENT_PID" > ~/.agent-profile
  echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >> ~/.agent-profile
else
  source ~/.agent-profile
fi
trap 'ssh-agent -k; exit' 0

[ -f ~/.rc.local ] && source ~/.rc.local
