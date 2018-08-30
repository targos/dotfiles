#export NODE_PENDING_DEPRECATION=1

# run tests from last PR
alias ngt='tools/test.py -J `git show --name-only --pretty="" | grep 'test/'`'

# compile and test
alias mtv="make test -j8 V="

alias ntw="NODE_OPTIONS='--trace-warnings'"

# branch-diff for staging
function nbd {
  BRANCH=$1
  echo "Running branch-diff for $BRANCH"
  branch-diff ${BRANCH}-staging upstream/master --exclude-label=semver-major,dont-land-on-${BRANCH},backport-requested-${BRANCH},backported-to-${BRANCH} --filter-release --format=simple
}

# branch-diff and apply
function nbda {
  BRANCH=$1
  echo "Running branch-diff and cherry-picking for $BRANCH"
  branch-diff ${BRANCH}-staging upstream/master --exclude-label=semver-major,dont-land-on-${BRANCH},backport-requested-${BRANCH},backported-to-${BRANCH} --filter-release --format=sha --reverse | xargs git cherry-pick
}

# update canary branch
function nuc {
  git remote update -p
  git reset --hard upstream/master
  git node v8 major
  git cherry-pick `git log upstream/canary-base -1 --format=format:%H --grep "src: update NODE_MODULE_VERSION"`...upstream/canary-base
}
