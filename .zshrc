export ZSH=/home/mzasso/.oh-my-zsh
export UPDATE_ZSH_DAYS=7

ZSH_THEME="ys"

plugins=(
  dnf
  git
  node
  npm
  nvm
)

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR=vim
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export PATH="/home/mzasso/git/chromium/depot_tools:${PATH}"

alias more=less
alias git=hub
alias gcud="git commit -m'chore: update dependencies'"

ulimit -u unlimited

function mkcd {
  mkdir -p $1 && cd $1
}

function npmU {
  rm -rf node_modules && rm package-lock.json && npm i
}

# z.sh (https://github.com/rupa/z)
source /home/mzasso/z.sh

# Auto-added configuration

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
