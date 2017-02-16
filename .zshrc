# Path to the oh-my-zsh installation.
export ZSH=/home/mzasso/.oh-my-zsh

# Name of the theme to load.
ZSH_THEME="ys"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Plugins to load
plugins=(git github npm nvm web-search dnf encode64 gpg-agent httpie docker docker-compose node yarn)

# User configuration

export EDITOR=vim
export PATH="./node_modules/.bin:/home/mzasso/git/depot_tools:/usr/lib64/ccache:/usr/lib64/qt-3.3/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/home/mzasso/bin:/usr/local/go/bin"
#export LLVM="/home/mzasso/git/forks/emscripten-fastcomp/build/bin"
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export NVM_DIR="/home/mzasso/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Software aliases
alias chrome-file='google-chrome --allow-file-access-from-files'
alias telegram=~/Telegram/Telegram
alias yum=dnf
alias more=less
alias ssh='ssh -l root'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# Private stuff
source /home/mzasso/.zshrc_private

# z.sh (https://github.com/rupa/z)
source /home/mzasso/z.sh

source $ZSH/oh-my-zsh.sh

# added by travis gem
[ -f /home/mzasso/.travis/travis.sh ] && source /home/mzasso/.travis/travis.sh

### ZNT's installer added snippet ###
znt_list_instant_select=1
fpath=( "$fpath[@]" "$HOME/.config/znt/zsh-navigation-tools" )
autoload n-aliases n-cd n-env n-functions n-history n-kill n-list n-list-draw n-list-input n-options n-panelize n-help
autoload znt-usetty-wrapper znt-history-widget znt-cd-widget znt-kill-widget
alias naliases=n-aliases ncd=n-cd nenv=n-env nfunctions=n-functions nhistory=n-history
alias nkill=n-kill noptions=n-options npanelize=n-panelize nhelp=n-help
zle -N znt-history-widget
bindkey '^R' znt-history-widget
setopt AUTO_PUSHD HIST_IGNORE_DUPS PUSHD_IGNORE_DUPS
zstyle ':completion::complete:n-kill::bits' matcher 'r:|=** l:|=*'
### END ###
