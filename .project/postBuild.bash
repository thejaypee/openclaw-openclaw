#!/bin/bash
set -e

echo "=== AI Workbench Project Setup ==="

# Install system packages from apt.txt
if [ -f /project/.project/apt.txt ]; then
    echo "Installing system packages..."
    apt-get update -qq
    xargs -a /project/.project/apt.txt apt-get install -y -qq
fi

# Install Node.js LTS via NodeSource
if ! command -v node &> /dev/null; then
    echo "Installing Node.js LTS..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt-get install -y -qq nodejs
fi

# Install pnpm
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    npm install -g pnpm
fi

# Install Node.js dependencies
echo "Installing Node.js dependencies with pnpm..."
cd /project && pnpm install

# Install Python dependencies
if [ -f /project/.project/requirements.txt ]; then
    echo "Installing Python requirements..."
    pip install --upgrade pip
    pip install -r /project/.project/requirements.txt
fi

# Also install from repo root requirements.txt if present
if [ -f /project/requirements.txt ]; then
    echo "Installing project requirements..."
    pip install -r /project/requirements.txt
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

echo "=== Setup Complete ==="
