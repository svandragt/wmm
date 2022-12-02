#!/usr/bin/env bash
if ! command -v redis-cli &> /dev/null
then
	echo "Installing Object Cache ..."

	sudo apt-get -y install redis-server redis-tools

	if command -v php &> /dev/null
	then
		yes no | sudo pecl install redis || true
		sudo cp /multipass/etc/php/$PHP_VERSION/mods-available/redis.ini /etc/php/$PHP_VERSION/mods-available/redis.ini
		sudo phpenmod redis
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
fi
