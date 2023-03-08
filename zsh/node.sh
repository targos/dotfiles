function node-deprecations {
  export NODE_PENDING_DEPRECATION=1
}

function node-no-deprecations {
  export NODE_PENDING_DEPRECATION=0
}

function node-options-print {
  echo "NODE_OPTIONS=\"${NODE_OPTIONS}\""
}

function node-options-clear {
  export NODE_OPTIONS=""
}

function node-options-reset {
  export NODE_OPTIONS="--trace-warnings"
}

function node-options-add {
  export NODE_OPTIONS="${NODE_OPTIONS} $1"
  node-options-print
}

node-options-reset

# run tests from last PR
alias ngt='tools/test.py -J `git show --name-only --pretty="" | grep 'test/'`'

# compile and test
alias mtv="make test -j8 V="

alias gnv8="git node v8 --v8-dir ~/git/chromium/v8/v8"

# branch-diff for staging
function nbd {
  BRANCH=$1
  echo "Running branch-diff for $BRANCH"
  branch-diff ${BRANCH}-staging upstream/main --exclude-label=semver-major,dont-land-on-${BRANCH},backport-requested-${BRANCH},backported-to-${BRANCH},backport-blocked-${BRANCH},backport-open-${BRANCH} --filter-release --format=simple
}

# branch-diff and apply
function nbda {
  BRANCH=$1
  echo "Running branch-diff and cherry-picking for $BRANCH"
  branch-diff ${BRANCH}-staging upstream/main --exclude-label=semver-major,dont-land-on-${BRANCH},backport-requested-${BRANCH},backported-to-${BRANCH},backport-blocked-${BRANCH},backport-open-${BRANCH} --filter-release --format=sha --reverse | xargs git cherry-pick
}

# branch-diff for staging LTS
function nbd-lts {
  BRANCH=$1
  REF=$2
  echo "Running branch-diff for $BRANCH"
  branch-diff ${BRANCH}-staging $REF --exclude-label=semver-major,semver-minor,dont-land-on-${BRANCH},backport-requested-${BRANCH},backported-to-${BRANCH},backport-blocked-${BRANCH},backport-open-${BRANCH},baking-for-lts --filter-release --format=simple
}

# branch-diff for staging LTS (minor)
function nbd-lts-minor {
  BRANCH=$1
  REF=$2
  echo "Running branch-diff for $BRANCH"
  branch-diff ${BRANCH}-staging $REF --exclude-label=semver-major,dont-land-on-${BRANCH},backport-requested-${BRANCH},backported-to-${BRANCH},backport-blocked-${BRANCH},backport-open-${BRANCH},baking-for-lts --filter-release --format=simple
}

# update canary branch
function nuc {
  git remote update upstream -p
  git reset --hard upstream/main
  gnv8 major
  git cherry-pick `git log upstream/canary-base -1 --format=format:%H --grep "src: update NODE_MODULE_VERSION"`...upstream/canary-base
}

# do a diff on V8's GN files from a commit
function gndiff {
  git diff $1..HEAD **/*.gn*
}

function gnlog {
  git log $1..HEAD **/*.gn*
}

# Apply a patch from GitHub URL
# usage: nac <url>
function nac {
  curl -L "$1.patch" | git am -3
}

# Apply a patch from GitHub URL in the deps/v8 directory
# usage: nac-v8 <url>
function nac-v8 {
  curl -L "$1.patch" | git am -3 --directory=deps/v8
}

function ncu-move {
  mv "${HOME}/.ncurc" "${HOME}/.ncurc_tmp"
}

function ncu-restore {
  mv "${HOME}/.ncurc_tmp" "${HOME}/.ncurc"
}
