#!/usr/bin/env bash

#TODO enable script via symlink

# shellcheck disable=SC1091
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

pushd "$SCRIPT_DIR" || exit 1
    sudo apt-get -y update

    for s in ./scripts-enabled/*.sh ; do
        echo ''
        . "$s"
    done
popd || exit 1
