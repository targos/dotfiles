# Detect whether we are on Mac or Linux
if [[ "$(uname -s)" = "Darwin" ]]; then
  PLATFORM=mac
else
  PLATFORM=linux
fi

DOTFILES_DIR=$(dirname $(readlink "${HOME}/.zshrc"))

# Load ZSH
export ZSH="${HOME}/.oh-my-zsh"
export UPDATE_ZSH_DAYS=7

ZSH_THEME="ys"

plugins=(
  git
  z
)

source "${ZSH}/oh-my-zsh.sh"
#end Load ZSH

# Setup env

function add-to-path {
  if [[ -d "$1" && ! ":$PATH:" == *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

export EDITOR="vim"
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
add-to-path "${HOME}/git/chromium/depot_tools"
export GPG_TTY=$(tty)
export CCACHE_NAMESPACE=default
export CCACHE_MAX_SIZE=25GiB

# Disable various spywares.
# https://github.com/scarf-sh/scarf-js
export SCARF_ANALYTICS=false
# https://storybook.js.org/docs/configure/telemetry#how-to-opt-out
export STORYBOOK_DISABLE_TELEMETRY=1
# https://nextjs.org/telemetry#how-do-i-opt-out
export NEXT_TELEMETRY_DISABLED=1

if [[ $PLATFORM = "linux" ]]; then
  add-to-path "/usr/lib64/ccache"
  add-to-path "/usr/lib/ccache"
else
  eval $(/opt/homebrew/bin/brew shellenv)
  add-to-path "/opt/homebrew/opt/ccache/libexec"
  add-to-path "/opt/homebrew/opt/python/libexec/bin"
  add-to-path "/Applications/Sublime Text.app/Contents/SharedSupport/bin"
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-23.jdk/Contents/Home"
fi

# Must be after homebrew to have precedence over node installed from there.
export VOLTA_HOME="${HOME}/.volta"
add-to-path "${VOLTA_HOME}/bin"
#end Setup env

# Command aliases
function maybe-alias {
  if ! command -v "$2" > /dev/null;
  then
    echo "Missing command $2. Cannot alias $1=$2"
  else
    alias "$1"="$2"
  fi
}
maybe-alias vi nvim
maybe-alias vim nvim
maybe-alias cat bat
maybe-alias top htop
maybe-alias df duf
maybe-alias find fd
maybe-alias grep rg
maybe-alias make gmake
alias gm="${HOME}/git/chromium/v8/v8/tools/dev/gm.py"
alias more=less

if [[ $PLATFORM = "linux" ]]; then
  alias gpg=gpg2
fi
#end Command aliases

# Directory shortcuts
hash -d -- git="${HOME}/git"
hash -d -- nodejs="${HOME}/git/nodejs"
hash -d -- v8="${HOME}/git/chromium/v8/v8"
hash -d -- test="${HOME}/test"
#end Directory shortcuts

function mkcd {
  mkdir -p $1 && cd $1
}

ulimit -u unlimited

source "${DOTFILES_DIR}/zsh/node.sh"

eval "$(gh copilot alias -- zsh)"
alias '??=ghcs'

# Optionally run local script
test -e "${HOME}/.zshrc_local" && source "${HOME}/.zshrc_local"

# Setup iTerm2 Shell Integration if installed
# If `hostname -f` doesn't return the right host name, add `export iterm2_hostname=hostname` to `~/.zshrc_local`
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/completion.zsh.inc"; fi

[ -f "${HOME}/.ghcup/env" ] && . "${HOME}/.ghcup/env" # ghcup-env
