if status is-interactive
  # Commands to run in interactive sessions can go here
end

# Setup env

set -g fish_greeting # Remove the greeting message
set -gx EDITOR nvim
set -gx LANG en_US.UTF-8
set -gx LC_CTYPE en_US.UTF-8
set -gx GPG_TTY (tty)
set -gx CCACHE_NAMESPACE default
set -gx CCACHE_MAX_SIZE 25GiB

fish_add_path $HOME/git/chromium/depot_tools

# Disable various spywares.
# https://github.com/scarf-sh/scarf-js
set -gx SCARF_ANALYTICS false
# https://storybook.js.org/docs/configure/telemetry#how-to-opt-out
set -gx STORYBOOK_DISABLE_TELEMETRY 1
# https://nextjs.org/telemetry#how-do-i-opt-out
set -gx NEXT_TELEMETRY_DISABLED 1

if test -d /opt/homebrew
  /opt/homebrew/bin/brew shellenv | source
  fish_add_path $HOMEBREW_PREFIX/opt/ccache/libexec
  fish_add_path $HOMEBREW_PREFIX/opt/python/libexec/bin
  fish_add_path "/Applications/Sublime Text.app/Contents/SharedSupport/bin"
  set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/temurin-25.jdk/Contents/Home"
end

# Haskell
if test -d $HOME/.ghcup/bin
  fish_add_path $HOME/.ghcup/bin
end
if test -d $HOME/.cabal/bin
  fish_add_path $HOME/.cabal/bin
end

if test -d $HOME/.jetbrains
  fish_add_path $HOME/.jetbrains
end

# Must be after homebrew to have precedence over node installed from there.
set -gx VOLTA_HOME $HOME/.volta
fish_add_path $VOLTA_HOME/bin
#end Setup env

# Command aliases
abbr vi nvim
abbr vim nvim
abbr cat bat
abbr top htop
abbr df duf
abbr find fd
abbr grep rg
abbr make gmake
abbr more less
abbr ghcs gh copilot suggest
