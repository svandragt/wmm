#!/usr/bin/env bash


if [ ! -f "/var/www/html/wp-config.php" ]
then
	echo "Installing WordPress ..."


	if ! command -v mysql &> /dev/null
	then
		echo "ERROR: WP requires mariadb / mysql!"
		exit 1
	fi
	if ! command -v wp &> /dev/null
	then
		echo "ERROR: WP requires wp-cli!"
		exit 1
	fi

	# A password is required to setup the database user
	if [[ -z "$PASSWD" ]]; then
    	echo "Set admin/database password:" && read -r PASSWD
	fi
	echo "CREATE DATABASE wp; GRANT ALL ON wp.* TO wp@localhost IDENTIFIED BY '${PASSWD}';FLUSH privileges;" | sudo mysql -u root
	sudo mkdir -p /var/www/html
	sudo chown ubuntu:www-data /var/www -R
	pushd /var/www/html || return
		wp core download
		wp config create --dbname=wp --dbuser=wp --dbpass="$PASSWD"
		wp core install --url=https://wmm.local --title=Example --admin_user=admin --admin_password="$PASSWD" --admin_email=admin@example.com --skip-email
		sed -i "/<?php/a define('FS_METHOD','direct');" wp-config.php
		sed -i "/<?php/a define('WP_CACHE', true);" wp-config.php
		# delete the default plugins
		wp plugin uninstall --all --deactivate
		# Install an opinionated set of defaults
		wp theme install --activate https://github.com/jacklenox/susty/archive/refs/heads/master.zip
		wp plugin install query-monitor --activate
		wp plugin install surge --activate
		wp plugin install user-switching --activate
		wp plugin install wp-crontrol --activate
		wp rewrite structure '/%postname%'
		wp surge flush --delete
		sudo chown ubuntu:www-data wp-content -R
		sudo chmod g+w wp-content -R
	popd || return
fi
