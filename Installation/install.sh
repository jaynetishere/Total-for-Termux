#!/data/data/com.termux/files/usr/bin/bash

set -e

REPO_URL="https://github.com/jaynetishere/Total-for-Termux"
BINARY_NAME="total"
INSTALL_DIR="$PREFIX/bin"

echo "==> Installing Total (Termux)"

# Check dependencies
command -v git >/dev/null 2>&1 || { echo "Error: git not installed"; exit 1; }
command -v go  >/dev/null 2>&1 || { echo "Error: go not installed"; exit 1; }

# Go environment safety
export GOTOOLCHAIN=local
export CGO_ENABLED=0

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

echo "==> Cloning repository"
git clone "$REPO_URL" "$TMP_DIR/Total"

cd "$TMP_DIR/Total"

echo "==> Building binary"
go build -v -o "$BINARY_NAME" ./Main

echo "==> Installing to $INSTALL_DIR"
install -m 0755 "$BINARY_NAME" "$INSTALL_DIR/$BINARY_NAME"

echo ""
echo "==> Installation complete "
echo "Run: total"
