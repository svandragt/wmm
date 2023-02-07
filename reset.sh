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

# Accept environment variable, or fallback to the script's directory
WMM_HOSTNAME=${WMM_HOSTNAME:-$(basename $PWD)}

if multipass list --format csv | grep -q "$WMM_HOSTNAME,"
then
  read -p "Purge the existing VM $WMM_HOSTNAME? (y/N) " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "Delete and purge the VM..."
    multipass delete $WMM_HOSTNAME; multipass purge
  fi
fi

read -p "Replace enabled scripts and launch? (y/N) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# Replace all the scripts
	rm -rf scripts-enabled/*
	cp -r scripts-available/* scripts-enabled/
  ./host.sh
fi
