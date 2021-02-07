# Detect whether we are on Mac or Linux
if [[ -d "/Users" ]]
then
  SYSTEM=mac
  DOTFILES_DIR=$HOME/git/targos/dotfiles
else
  SYSTEM=linux
  DOTFILES_DIR=$(dirname $(readlink $HOME/.zshrc))
fi

# Load ZSH
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
#end Load ZSH

# Setup env
export EDITOR=vim
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="$HOME/git/chromium/depot_tools:${PATH}"
export GPG_TTY=$(tty)
# https://github.com/scarf-sh/scarf-js
export SCARF_ANALYTICS=false

if [[ $PLATFORM = "linux" ]]; then
  export PATH="/usr/lib64/ccache:/usr/lib/ccache:${PATH}"
else
  eval $(/opt/homebrew/bin/brew shellenv)
  export PATH="/opt/homebrew/Cellar/ccache/4.1/libexec:${PATH}"
fi
#end Setup env

# Command aliases
alias cat=bat
alias gm="$HOME/git/chromium/v8/v8/tools/dev/gm.py"
alias more=less
alias python=python3

if [[ $PLATFORM = "linux" ]]; then
  alias gpg=gpg2
fi
#end Command aliases

# Directory shortcuts
hash -d -- node=$HOME/git/nodejs/node
hash -d -- v8=$HOME/git/chromium/v8/v8
hash -d -- test=$HOME/test
#end Directory shortcuts

function mkcd {
  mkdir -p $1 && cd $1
}

ulimit -u unlimited

source $DOTFILES_DIR/zsh/node.sh

# Optionally run local script
if [[ -f "$HOME/.zshrc_local" ]]
then
  source $HOME/.zshrc_local
fi
