if status is-interactive
  # Commands to run in interactive sessions can go here
end

# Remove the default greeting message
set -U fish_greeting

if test -d /home
  set is_linux true
else
  set is_mac true
end

# Setup env
set -gx EDITOR nvim
set -gx GPG_TTY $(tty)
set -gx CCACHE_NAMESPACE default
set -gx CCACHE_MAX_SIZE 25GiB
set -gx CC 'ccache clang'
set -gx CXX 'ccache clang++'

if test -n $is_linux
  set -gx LANG en_GB.UTF-8
  set -gx LC_CTYPE en_GB.UTF-8
  set -gx XDG_CURRENT_DESKTOP sway
  set -gx MOZ_ENABLE_WAYLAND 1
  set -gx QT_QPA_PLATFORM wayland
  set -gx GDK_BACKEND 'wayland,x11'
  fish_add_path $HOME/bin
  keychain --eval --quiet id_ed25519 | source
  # set -gx PW_TEST_CONNECT_WS_ENDPOINT 'ws://127.0.0.1:3999/'
else
  set -gx LANG en_US.UTF-8
  set -gx LC_CTYPE en_US.UTF-8
end

# Disable various spywares.
# https://github.com/scarf-sh/scarf-js
set -gx SCARF_ANALYTICS false
# https://storybook.js.org/docs/configure/telemetry#how-to-opt-out
set -gx STORYBOOK_DISABLE_TELEMETRY 1
# https://nextjs.org/telemetry#how-do-i-opt-out
set -gx NEXT_TELEMETRY_DISABLED 1

fish_add_path $HOME/git/chromium/depot_tools

if test -d /opt/homebrew
  /opt/homebrew/bin/brew shellenv | source
  fish_add_path $HOMEBREW_PREFIX/opt/ccache/libexec
  fish_add_path $HOMEBREW_PREFIX/opt/python/libexec/bin
  set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/temurin-25.jdk/Contents/Home"
end

if test -n $is_mac
  fish_add_path "/Applications/Sublime Text.app/Contents/SharedSupport/bin"
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
abbr df duf
abbr find fd
abbr grep rg
abbr more less
abbr ghcs gh copilot suggest

if test -n $is_mac
  abbr top htop
  abbr make gmake
else
  abbr top btop
end
