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
	popd || return
fi
