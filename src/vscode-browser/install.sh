#!/bin/sh
set -e

error() {
  echo "$1" >&2
  echo "Exiting..." >&2
  exit 1
}

arch_detect() {
  if [ "$(uname -m)" = "x86_64" ]; then
    ARCH="amd64"
  elif [ "$(uname -m)" = "aarch64" || "$(uname -m)" = "arm64" ]; then
    ARCH="arm64"
  else
    error "Unsupported architecture: $(uname -m)"
  fi
}

arch_detect

INSTALL_PATH="/opt/gitpod/vscode-browser/vscode-browser-agent"
BINARY_URL="https://gitpod-flex-releases.s3.amazonaws.com/vscode-browser/latest/vscode-browser-agent-$ARCH"
install() {
    mkdir -p "$(dirname $INSTALL_PATH)"
    curl -fsSL "$BINARY_URL" -o "$INSTALL_PATH"
    chmod +x "$INSTALL_PATH"
}

echo "Istalling VS Code Browser feature..."

install
