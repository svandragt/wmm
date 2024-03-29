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
readonly SCRIPT_NAME SCRIPT_DIR
#}}}

if [ ! -d "/multipass" ]; then
    echo "Aborted: The script must be run on the guest."
    exit 1
fi

if (( $# != 2 )); then
    >&2 echo "Illegal number of parameters, two expected."
fi



export WMM_HOSTNAME=$1
export WMM_DOMAIN=$2

echo "Bootstrapping $WMM_HOSTNAME..."
pushd "$SCRIPT_DIR" || exit 1
    for s in ./scripts-enabled/requires/*.sh ; do
        echo ">>>>>> $s"
        source "$s"
    done
    for s in ./scripts-enabled/*.sh ; do
        echo ''; echo ''
        echo ">>>>>> $s"
        source "$s"
    done
popd || exit 1
