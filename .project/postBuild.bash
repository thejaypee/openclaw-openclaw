#!/bin/bash
# This file runs AFTER system and language packages are installed.
# It has passwordless sudo access but CANNOT access /project/ files.
# System packages (apt) and Python packages (pip) are managed via spec.yaml and configpacks.
set -e

echo "=== PostBuild: Project Setup ==="

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
