export NODE_PENDING_DEPRECATION=1
export NODE_OPTIONS=" --trace-warnings "

# run tests from last PR
alias ngt='tools/test.py -J `git show --name-only --pretty="" | grep 'test/'`'

# compile and test
alias mtv="make test -j8 V="

alias gnv8="git node v8 --v8-dir ~/git/chromium/v8/v8"

# branch-diff for staging
function nbd {
  BRANCH=$1
  echo "Running branch-diff for $BRANCH"
  branch-diff ${BRANCH}-staging upstream/master --exclude-label=semver-major,dont-land-on-${BRANCH},backport-requested-${BRANCH},backported-to-${BRANCH},backport-blocked-${BRANCH},backport-open-${BRANCH} --filter-release --format=simple
}

# branch-diff and apply
function nbda {
  BRANCH=$1
  echo "Running branch-diff and cherry-picking for $BRANCH"
  branch-diff ${BRANCH}-staging upstream/master --exclude-label=semver-major,dont-land-on-${BRANCH},backport-requested-${BRANCH},backported-to-${BRANCH},backport-blocked-${BRANCH},backport-open-${BRANCH} --filter-release --format=sha --reverse | xargs git cherry-pick
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
  git reset --hard upstream/master
  gnv8 major
  git cherry-pick `git log upstream/canary-base -1 --format=format:%H --grep "src: update NODE_MODULE_VERSION"`...upstream/canary-base
}

# Apply a patch from GitHub URL
# usage: nac <url>
function nac {
  curl -L "$1.patch" | git am -3
}
