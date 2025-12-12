# Functions to help with Node.js development

function gnv8 -d "Update V8 in Node.js"
  git node v8 --v8-dir $HOME/git/chromium/v8/v8 $argv
end

function nuc -d "Update Node.js canary branch"
  git remote update upstream -p
  git reset --hard upstream/main
  gnv8 major
  git cherry-pick $(git log upstream/canary-base -1 --format=format:%H --grep "src: update NODE_MODULE_VERSION")...upstream/canary-base
end

function set-ccache-namespace
  if test (count $argv) -ne 1
    echo "Usage: set-ccache-namespace <namespace>"
    return 1
  end
  set -gx CCACHE_NAMESPACE $argv[1]
end

function node-configure-main
  set-ccache-namespace node-main
  python3 configure.py --ninja --debug --node-builtin-modules-path=$(pwd)
end

function node-configure-release
  set-ccache-namespace node-release
  python3 configure.py --ninja
end

function node-configure-canary
  set -gx CCACHE_DISABLE 1
  python3 configure.py --ninja --debug
end

function node-configure-v8-update
  set-ccache-namespace node-v8-update
  python3 configure.py --ninja --debug
end
