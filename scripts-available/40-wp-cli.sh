#!/usr/bin/env bash
if ! command -v wp &> /dev/null
then
	echo 'Installing WP-CLI ...'

	if ! command -v php &> /dev/null
	then
		echo 'ERROR: requires PHP!'
		exit 1
	fi

	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	php wp-cli.phar --info
	chmod +x wp-cli.phar
	sudo mv wp-cli.phar /usr/local/bin/wp
	wp --info
fi

