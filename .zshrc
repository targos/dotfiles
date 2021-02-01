export ZSH=$HOME/.oh-my-zsh
export UPDATE_ZSH_DAYS=7

ZSH_THEME="ys"

plugins=(
  dnf
  git
  node
  npm
  z
)

source $ZSH/oh-my-zsh.sh

# User configuration

eval $(/opt/homebrew/bin/brew shellenv)
export EDITOR=vim
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$HOME/git/chromium/depot_tools:${PATH}"
export PATH="/usr/lib64/ccache:/usr/lib/ccache:${PATH}"
export PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
export GPG_TTY=$(tty)
# https://github.com/scarf-sh/scarf-js
export SCARF_ANALYTICS=false

alias cat=bat
alias gpg=gpg2
alias more=less
alias gm="~/git/chromium/v8/v8/tools/dev/gm.py"

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

source ~/git/targos/dotfiles/zsh/node.sh
