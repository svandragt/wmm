#!/usr/bin/env bash
	echo "Installing Object Cache ..."

	sudo apt-get -y install redis-server redis-tools

	if command -v php &> /dev/null
	then
	  # Install for all versions of
		for d in "/etc/php/"*; do
		  echo "dir: $d"
		  PHP_SUFFIX=$(basename $d)
  		yes no | sudo pecl -d php_suffix=$PHP_SUFFIX install -f redis || true
  		sudo cp /multipass/etc/php/mods-available/redis.ini "$d/mods-available/redis.ini"
		done
		sudo phpenmod -v ALL redis
		sudo systemctl restart php$PHP_VERSION-fpm
	fi

	if command -v wp &> /dev/null
	then
		pushd /var/www/html || return
			wp plugin install redis-cache --activate
			wp redis update-dropin
			wp cache flush
		popd || return
	fi
