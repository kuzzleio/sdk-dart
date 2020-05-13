let version = 'local-build'

if (process.env.CI) {
  version = `${process.env.TRAVIS_REPO_SLUG}:${process.env.TRAVIS_BRANCH}@${process.env.TRAVIS_COMMIT}--job:${process.env.TRAVIS_JOB_WEB_URL}`;
}

module.exports = version;