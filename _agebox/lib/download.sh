#!/bin/sh
BASE_DIR=$(dirname "$0")

# Determine latest version
GITHUB_BASE_URL="https://github.com/slok/agebox/releases"
LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' $GITHUB_BASE_URL/latest)
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
ARTIFACT_BASE_URL="$GITHUB_BASE_URL/download/$LATEST_VERSION"

if [ "$1" = "-f" ]; then
    rm -rf $BASE_DIR/agebox-*
fi

# Download executables
if [ ! -f "$BASE_DIR/agebox-darwin-amd64" ]; then
    wget -O $BASE_DIR/agebox-darwin-amd64 $ARTIFACT_BASE_URL/agebox-darwin-amd64
fi

if [ ! -f "$BASE_DIR/agebox-darwin-arm64" ]; then
    wget -O $BASE_DIR/agebox-darwin-arm64 $ARTIFACT_BASE_URL/agebox-darwin-arm64
fi

if [ ! -f "$BASE_DIR/agebox-linux-amd64" ]; then
    wget -O $BASE_DIR/agebox-linux-amd64 $ARTIFACT_BASE_URL/agebox-linux-amd64
fi

if [ ! -f "$BASE_DIR/agebox-linux-arm64" ]; then
    wget -O $BASE_DIR/agebox-linux-arm64 $ARTIFACT_BASE_URL/agebox-linux-arm64
fi

if [ ! -f "$BASE_DIR/agebox-linux-arm-v7" ]; then
    wget -O $BASE_DIR/agebox-linux-arm-v7 $ARTIFACT_BASE_URL/agebox-linux-arm-v7
fi

if [ ! -f "$BASE_DIR/agebox-windows-amd64.exe" ]; then
    wget -O $BASE_DIR/agebox-windows-amd64.exe $ARTIFACT_BASE_URL/agebox-windows-amd64.exe
fi

chmod +x $BASE_DIR/agebox*

# Print out latest version
echo $LATEST_VERSION > $BASE_DIR/_VERSION