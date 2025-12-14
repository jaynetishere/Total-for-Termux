#!/usr/bin/env bash

set -e

REPO_URL="https://github.com/jaynetblacemen/Total"
INSTALL_DIR="/usr/local/bin"
BINARY_NAME="total"

echo "==> Installing Total"

# Check dependencies
command -v git >/dev/null 2>&1 || { echo "Error: git not installed"; exit 1; }
command -v go  >/dev/null 2>&1 || { echo "Error: go not installed"; exit 1; }

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

echo "==> Cloning repository"
git clone "$REPO_URL" "$TMP_DIR/Total"

cd "$TMP_DIR/Total"

echo "==> Building binary"
go build -o "$BINARY_NAME" ./Main

echo "==> Installing to $INSTALL_DIR"
sudo install -m 0755 "$BINARY_NAME" "$INSTALL_DIR/$BINARY_NAME"

echo ""
echo "==> Installation complete"
echo "Run: total"
