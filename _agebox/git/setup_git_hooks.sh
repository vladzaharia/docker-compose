#!/bin/sh

BASEDIR=$(dirname "$0")

cp -f $BASEDIR/pre-commit $BASEDIR/../../.git/hooks/pre-commit
cp -f $BASEDIR/pre-push $BASEDIR/../../.git/hooks/pre-push
cp -f $BASEDIR/post-checkout-merge $BASEDIR/../../.git/hooks/post-checkout
cp -f $BASEDIR/post-checkout-merge $BASEDIR/../../.git/hooks/post-merge

chmod +x $BASEDIR/../../.git/hooks/pre-commit
chmod +x $BASEDIR/../../.git/hooks/pre-push
chmod +x $BASEDIR/../../.git/hooks/post-checkout
chmod +x $BASEDIR/../../.git/hooks/post-merge