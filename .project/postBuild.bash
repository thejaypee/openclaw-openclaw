#!/bin/bash
# This file runs AFTER system and language packages are installed.
# Has passwordless sudo access.
set -e

echo "=== PostBuild: Project Setup ==="

# Install Node.js 22.x via NodeSource
if ! command -v node &> /dev/null; then
    echo "Installing Node.js 22.x..."
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"

# Install pnpm globally
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    sudo npm install -g pnpm
fi

# Install Node.js dependencies
if [ -f /project/package.json ]; then
    echo "Installing Node.js dependencies with pnpm..."
    cd /project && pnpm install
fi

# Install Go dependencies
if [ -f /project/go.mod ]; then
    echo "Downloading Go modules..."
    cd /project && go mod download
fi

# Initialize Git LFS
git lfs install

# Create Workbench directories
mkdir -p /project/data /project/models /project/data/scratch

echo "=== PostBuild Complete ==="
