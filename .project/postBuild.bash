#!/bin/bash
# Runs AFTER package installation. CANNOT access /project/. No sudo available.
set -e

echo "=== PostBuild ==="

# Install nvm (Node Version Manager) to userspace
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

# Load nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Install Node.js 22
echo "Installing Node.js 22..."
nvm install 22
nvm alias default 22

echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"

# Install pnpm globally
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    npm install -g pnpm
fi

# Initialize Git LFS
git lfs install

echo "=== PostBuild Complete ==="
