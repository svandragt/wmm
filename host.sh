#!/usr/bin/env bash

#{{{ Bash settings
# abort on nonzero exitstatus
set -o errexit
# abort on unbound variable
set -o nounset
# don't hide errors within pipes
set -o pipefail
#}}}
#{{{ Variables
IFS=$'\t\n'   # Split on newlines and tabs (but not on spaces)
SCRIPT_NAME=$(basename "${0}")
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
readonly SCRIPT_NAME script_dir
#}}}

# Accept envronment variable, or fallback to the script's directory
WMM_HOSTNAME=${WMM_HOSTNAME:-$(basename $PWD)}
echo "Start VM named $WMM_HOSTNAME..."
multipass launch -n $WMM_HOSTNAME
# Mount the current folder as /multipass
multipass mount "$SCRIPT_DIR" $WMM_HOSTNAME:/multipass
mkdir -p "$SCRIPT_DIR/content/mu-plugins"
mkdir -p "$SCRIPT_DIR/content/plugins"
mkdir -p "$SCRIPT_DIR/content/themes"
mkdir -p "$SCRIPT_DIR/content/logs"
multipass mount "$SCRIPT_DIR/content/mu-plugins" $WMM_HOSTNAME:/var/www/html/wp-content/mu-plugins
multipass mount "$SCRIPT_DIR/content/plugins" $WMM_HOSTNAME:/var/www/html/wp-content/plugins
multipass mount "$SCRIPT_DIR/content/themes" $WMM_HOSTNAME:/var/www/html/wp-content/themes
multipass mount "$SCRIPT_DIR/content/logs" $WMM_HOSTNAME:/var/www/logs

# Install the required packages
multipass exec $WMM_HOSTNAME -- ./guest.sh $WMM_HOSTNAME
