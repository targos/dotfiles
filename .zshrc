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
  dnf
  git
  gh
  node
  npm
  macos
  z
)

source "${ZSH}/oh-my-zsh.sh"
#end Load ZSH

# Setup env
export EDITOR="vim"
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export PATH="${HOME}/git/chromium/depot_tools:${PATH}"
export GPG_TTY=$(tty)
# https://github.com/scarf-sh/scarf-js
export SCARF_ANALYTICS=false
# https://nextjs.org/telemetry#how-do-i-opt-out
export NEXT_TELEMETRY_DISABLED=1
export CCACHE_NAMESPACE=default

if [[ $PLATFORM = "linux" ]]; then
  export PATH="/usr/lib64/ccache:/usr/lib/ccache:${PATH}"
else
  eval $(/opt/homebrew/bin/brew shellenv)
  export PATH="/opt/homebrew/opt/ccache/libexec:${PATH}"
  export PATH="/opt/homebrew/opt/python/libexec/bin:${PATH}"
  export PATH="/opt/homebrew/opt/openjdk/bin:${PATH}"
fi

# Must be after homebrew to have precedence over node installed from there.
export VOLTA_HOME="${HOME}/.volta"
export PATH="${VOLTA_HOME}/bin:${PATH}"
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
maybe-alias make gmake
alias gm="${HOME}/git/chromium/v8/v8/tools/dev/gm.py"
alias more=less

if [[ $PLATFORM = "linux" ]]; then
  alias gpg=gpg2
fi
#end Command aliases

# Directory shortcuts
hash -d -- node="${HOME}/git/nodejs/node"
hash -d -- v8="${HOME}/git/chromium/v8/v8"
hash -d -- test="${HOME}/test"
#end Directory shortcuts

function mkcd {
  mkdir -p $1 && cd $1
}

ulimit -u unlimited

source "${DOTFILES_DIR}/zsh/node.sh"

eval "$(github-copilot-cli alias -- "$0")"

# Optionally run local script
test -e "${HOME}/.zshrc_local" && source "${HOME}/.zshrc_local"

# Setup iTerm2 Shell Integration if installed
# If `hostname -f` doesn't return the right host name, add `export iterm2_hostname=hostname` to `~/.zshrc_local`
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/completion.zsh.inc"; fi
