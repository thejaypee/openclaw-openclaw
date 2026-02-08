#!/bin/bash
# This file runs BEFORE packages are installed during the container build.
# Has passwordless sudo access but CANNOT access /project/ files.
set -e

echo "=== PreBuild: No custom setup needed ==="
