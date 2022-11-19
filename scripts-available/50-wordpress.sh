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
    	echo "Set admin/database password:" && read -r PASSWD
	fi

	sudo mkdir -p /var/www/html
	sudo chown ubuntu:www-data /var/www -R

	pushd /var/www/html || return
		wp core download
		wp config create --dbname=wp --dbuser=wp --dbpass="$PASSWD"
		wp core install --url=wp.test --title=Example --admin_user=admin --admin_password="$PASSWD" --admin_email=admin@example.com --skip-email
		sed -i "/<?php/a define('FS_METHOD','direct');" wp-config.php
		sed -i "/<?php/a define('WP_CACHE', true);" wp-config.php

		wp rewrite structure '/%postname%'

		wp theme install --activate https://github.com/jacklenox/susty/archive/refs/heads/master.zip

		wp plugin install query-monitor --activate
		wp plugin install surge --activate
		wp plugin install user-switching --activate
		wp plugin install wp-crontrol --activate

		wp surge flush --delete

		sudo chown www-data:www-data wp-content -R
	popd || return
fi
