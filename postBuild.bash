#!/bin/bash
# Runs AFTER package installation. Passwordless sudo available.
set -e

echo "=== PostBuild ==="

# Install Node.js 22 binary to userspace
NODE_VERSION=22.13.1
NODE_DIR="$HOME/.local/node"
if [ ! -f "$NODE_DIR/bin/node" ]; then
    echo "Installing Node.js $NODE_VERSION..."
    mkdir -p "$NODE_DIR"
    curl -fsSL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz" \
        | tar -xz --strip-components=1 -C "$NODE_DIR"
fi

# Add node to PATH permanently
export PATH="$NODE_DIR/bin:$PATH"
if ! grep -q "$NODE_DIR/bin" "$HOME/.bashrc" 2>/dev/null; then
    echo "export PATH=\"$NODE_DIR/bin:\$PATH\"" >> "$HOME/.bashrc"
fi

echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"

# Install pnpm globally (to user prefix)
npm config set prefix "$HOME/.local"
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    npm install -g pnpm
fi

# Initialize Git LFS
git lfs install

echo "=== PostBuild Complete ==="
