#!/usr/bin/env bash
pushd "/var/www/html" || return
	wp rewrite structure '/%postname%'
popd || return

# TODO move to post
sudo systemctl restart caddy

IPADDR=$(hostname -I | cut -d' ' -f1)
echo ''
echo "Done! Update /etc/hosts with:"
echo "${IPADDR} wp.test "
