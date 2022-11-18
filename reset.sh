#!/usr/bin/env bash

echo "Delete and purge the VM..."
multipass delete wmm; multipass purge

# Replace all the scripts
rm scripts-enabled/*.sh
cp scripts-available/*.sh scripts-enabled/
./host.sh