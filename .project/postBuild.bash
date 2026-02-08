#!/bin/bash
# Runs AFTER package installation. Has passwordless sudo. CANNOT access /project/.
# nodejs is already installed from apt.txt (via NodeSource repo added in preBuild).
set -e

echo "=== PostBuild ==="

echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"

# Install pnpm globally
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    sudo npm install -g pnpm
fi

# Initialize Git LFS
git lfs install

echo "=== PostBuild Complete ==="
