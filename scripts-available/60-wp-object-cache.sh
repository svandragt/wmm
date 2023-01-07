#!/usr/bin/env bash
	echo "Installing Object Cache ..."

	sudo apt-get -y install redis-server redis-tools

	if command -v wp &> /dev/null
	then
		pushd /var/www/html || return
			wp plugin install redis-cache --activate
			wp redis update-dropin
			wp cache flush
		popd || return
	fi
