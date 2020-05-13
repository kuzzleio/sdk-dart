#!/bin/bash

set -eu

DOC_VERSION=2
DOC_PATH=/sdk/dart/2
PWD=$(dirname $(readlink -f $0))
FMWKDIR="$PWD/framework"
FMWKTARGET="$FMWKDIR/src$DOC_PATH"
VUEPRESS="$FMWKDIR/node_modules/.bin/vuepress"

# Used by vuepress
export DOC_DIR="$PWD/${DOC_VERSION}"
export SITE_BASE=$DOC_PATH/

# Used to specify --no-cache for example
ARGS=${2:-""}

if [ ! -d "$DOC_DIR" ]
then
  echo "Cannot find documentation directory: $DOC_DIR"
  exit 1
fi

case $1 in
  prepare)
    echo "Clone documentation framework"
    rm -rf $FMWKDIR
    git clone --depth 10 --single-branch --branch master https://github.com/kuzzleio/documentation.git $FMWKDIR

    echo "Link local doc for dead links checking"
    rm $FMWKTARGET
    ln -s ${DOC_DIR} $FMWKTARGET

    echo "Install dependencies"
    npm --prefix $FMWKDIR ci
  ;;

  dev)
    $VUEPRESS dev $DOC_DIR/ $ARGS
  ;;

  build)
    $VUEPRESS build $DOC_DIR/ $ARGS
  ;;

  build-netlify)
    export SITE_BASE="/"
    $VUEPRESS build $DOC_DIR/ $ARGS
  ;;

  upload)
    aws s3 sync $DOC_DIR/.vuepress/dist s3://$S3_BUCKET$SITE_BASE
  ;;

  cloudfront)
    aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_DISTRIBUTION_ID --paths "$SITE_BASE*"
  ;;

  *)
    echo "Usage : $0 <prepare|dev|build|upload|cloudfront>"
    exit 1
  ;;
esac
