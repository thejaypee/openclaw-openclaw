#!/bin/bash
# This file runs BEFORE packages are installed during the container build.
# It has passwordless sudo access but CANNOT access /project/ files.
set -e

echo "=== PreBuild: Adding Node.js repository ==="

# Add NodeSource repo for Node.js 22.x so apt configpack can install it
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -

echo "=== PreBuild Complete ==="
