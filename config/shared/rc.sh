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
export PATH="$HOME/bin:$PATH"

# Aliases
alias cb=clipboard
alias sap='source ~/.agent-profile'

# Functions
mann () { man $1 | less -p "^       $2 " } # Locate directly to a subsection in man page

[ -f ~/.rc.local ] && source ~/.rc.local
