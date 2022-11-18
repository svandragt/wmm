#!/usr/bin/env bash

echo "Start the VM..."
multipass launch -n wmm
# Mount the current folder as /multipass
multipass mount . wmm:/multipass

# Install the required packages
multipass exec wmm -- ./guest.sh
