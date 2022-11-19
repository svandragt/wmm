#!/usr/bin/env bash
if [ ! -f "/var/www/html/wp-config.php" ]
then
	echo "Installing WordPress ..."

	if ! command -v wp &> /dev/null
	then
		echo "ERROR: requires wp-cli!"
		exit 1
	fi

	if [[ -z "$PASSWD" ]]; then
    	echo "Set password:" && read -r PASSWD
	fi

	sudo mkdir -p /var/www/html
	sudo chown ubuntu:www-data /var/www -R

	pushd /var/www/html || return
		wp core download
		wp config create --dbname=wp --dbuser=wp --dbpass="$PASSWD"
		wp core install --url=wp.test --title=Example --admin_user=admin --admin_password="$PASSWD" --admin_email=admin@example.com --skip-email
		sed -i "/<?php/i define('WP_CACHE', true);" wp-config.php
		

		# Install new default theme	
		pushd wp-content/themes || return
			git clone --depth 1 --single-branch https://github.com/jacklenox/susty
		popd || return
		wp theme activate susty

		wp plugin install query-monitor --activate
		wp plugin install surge --activate
		wp surge flush --delete
		wp plugin install user-switching --activate
		wp plugin install wp-crontrol --activate

	popd || return
fi
