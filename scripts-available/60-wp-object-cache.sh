#!/usr/bin/env bash
if ! command -v redis-cli &> /dev/null
then
	echo "Installing Object Cache ..."

	sudo apt-get -y install redis-server redis-tools

	if command -v php &> /dev/null
	then
		yes no | sudo pecl install redis
		sudo cp /multipass/etc/php/7.4/mods-available/redis.ini /etc/php/7.4/mods-available/redis.ini
		sudo phpenmod redis
		sudo service php7.4-fpm restart
	fi

	if command -v wp &> /dev/null
	then
		wp plugin install redis-cache --activate
		wp redis update-dropin
	fi
fi
