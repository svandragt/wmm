#!/usr/bin/env bash

#TODO enable script via symlink
#TODO enable script requirements

# shellcheck disable=SC1091
. ./scripts-enabled/php74.sh
. ./scripts-enabled/caddy.sh
. ./scripts-enabled/mariadb.sh
. ./scripts-enabled/wp-cli.sh
. ./scripts-enabled/wordpress.sh

# TODO move to post
sudo systemctl restart caddy

sudo apt-get -y install net-tools
IPADDR=$(hostname -I | cut -d' ' -f1)
echo "Done! Add the following line to your /etc/hosts"
echo "${IPADDR} wp.test "