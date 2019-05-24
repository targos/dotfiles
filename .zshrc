export ZSH=/home/mzasso/.oh-my-zsh
export UPDATE_ZSH_DAYS=7

ZSH_THEME="ys"

plugins=(
  dnf
  git
  node
  npm
  nvm
  z
)

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR=vim
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export PATH="/home/mzasso/git/chromium/depot_tools:${PATH}"
export PATH="/usr/lib64/ccache:/usr/lib/ccache:${PATH}"
export GPG_TTY=$(tty)

alias gpg=gpg2
alias more=less
alias gcud="git commit -m'chore: update dependencies'"
alias grup="git remote update -p"
alias gm="~/git/chromium/v8/v8/tools/dev/gm.py"
alias esm-on="export NODE_OPTIONS=\"--experimental-modules\""
alias esm-off="export NODE_OPTIONS="

hash -d -- node=~/git/nodejs/node
hash -d -- v8=~/git/chromium/v8/v8
hash -d -- test=~/test

ulimit -u unlimited

function mkcd {
  mkdir -p $1 && cd $1
}

function npmU {
  rm -rf node_modules && rm package-lock.json && npm i
}

source ~/git/targos/dot-files/zsh/node.sh

# Auto-added configuration

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/mzasso/.sdkman"
[[ -s "/home/mzasso/.sdkman/bin/sdkman-init.sh" ]] && source "/home/mzasso/.sdkman/bin/sdkman-init.sh"
