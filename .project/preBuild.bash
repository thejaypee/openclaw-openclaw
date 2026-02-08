#!/bin/bash
# Runs BEFORE package installation. Has passwordless sudo. CANNOT access /project/.
# Build order: base image → preBuild → apt.txt/requirements.txt → postBuild → runtime
set -e

echo "=== PreBuild: Adding Node.js 22.x repository ==="
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
