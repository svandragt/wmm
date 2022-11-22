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

export WMM_HOSTNAME=$1

echo "Bootstrapping $WMM_HOSTNAME..."
pushd "$SCRIPT_DIR" || exit 1
    sudo apt-get -y update

    for s in ./scripts-enabled/*.sh ; do
        echo ''
        . "$s"
    done
popd || exit 1
