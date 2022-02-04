#!/usr/bin/env bash

#TODO enable script via symlink
#TODO enable script requirements

# shellcheck disable=SC1091
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

pushd "$SCRIPT_DIR" || exit 1
sudo apt-get -y update

for s in ./scripts-enabled/*.sh ; do
    echo ''
    . "$s"
done

# TODO move to post
sudo systemctl restart caddy

sudo apt-get -y install net-tools
IPADDR=$(hostname -I | cut -d' ' -f1)
echo ''
echo "Done! Add the following line to your /etc/hosts"
echo "${IPADDR} wp.test "

popd || exit 1
