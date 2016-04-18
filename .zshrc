# Path to the oh-my-zsh installation.
export ZSH=/home/mzasso/.oh-my-zsh

# Name of the theme to load.
ZSH_THEME="kolo"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Plugins to load
plugins=(git github npm nvm web-search thefuck)

# User configuration

export PATH="/home/mzasso/emsdk_portable:/home/mzasso/emsdk_portable/clang/fastcomp/build_master_64/bin:/home/mzasso/emsdk_portable/emscripten/master:/home/mzasso/git/chromium/depot_tools:/usr/lib64/qt-3.3/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/home/mzasso/bin:/usr/local/go/bin:./node_modules/.bin"

export NVM_DIR="/home/mzasso/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Software aliases
alias chrome-file='google-chrome --allow-file-access-from-files'
alias telegram=~/Telegram/Telegram
alias yum=dnf
alias more=less

# Private stuff
source /home/mzasso/.zshrc_private

# z.sh (https://github.com/rupa/z)
source /home/mzasso/z.sh

source $ZSH/oh-my-zsh.sh

# added by travis gem
[ -f /home/mzasso/.travis/travis.sh ] && source /home/mzasso/.travis/travis.sh
