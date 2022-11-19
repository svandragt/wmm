#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

echo "Start the VM..."

multipass launch -n wmm
# Mount the current folder as /multipass
multipass mount "$SCRIPT_DIR" wmm:/multipass
mkdir -p "$SCRIPT_DIR/content/mu-plugins"
mkdir -p "$SCRIPT_DIR/content/plugins"
mkdir -p "$SCRIPT_DIR/content/themes"
multipass mount "$SCRIPT_DIR/content/mu-plugins" wmm:/var/www/html/wp-content/mu-plugins
multipass mount "$SCRIPT_DIR/content/plugins" wmm:/var/www/html/wp-content/plugins
multipass mount "$SCRIPT_DIR/content/themes" wmm:/var/www/html/wp-content/themes

# Install the required packages
multipass exec wmm -- ./guest.sh
