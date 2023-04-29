#!/bin/sh

BASEDIR=$(dirname "$0")
PLATFORM=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
ARGS="$@"

if [ $ARCH = "x86_64" ]; then
    ARCH=amd64
elif [ $ARCH = "aarm64" ]; then
    ARCH=arm64
fi

PUBKEYARGS="--public-keys $BASEDIR/keys"

if [ "$1" = "encrypt-all" ]; then
    ARGS="encrypt . --filter .*\\.env$"
elif [ "$1" = "dry-run" ]; then
    ARGS="encrypt . --filter .*\\.env$ --dry-run"
elif [ "$1" = "decrypt-all" ]; then
    ARGS="decrypt . --filter .*\\.env$"
    PUBKEYARGS=""
fi

echo $BASEDIR/lib/agebox-$PLATFORM-$ARCH $ARGS 
$BASEDIR/lib/agebox-$PLATFORM-$ARCH $ARGS $PUBKEYARGS