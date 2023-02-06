#!/usr/bin/env bash
require_mariadb
require_wpcli
require_composer

if [ ! -f "/multipass/wordpress/wp-config.php" ]
then
	echo "Installing WordPress ..."
	# A password is required to setup the database user
	if [[ ! -v PASSWD ]]; then
    	echo "Set admin/database password:" && read -r PASSWD
	fi
	echo "CREATE DATABASE IF NOT EXISTS wp; GRANT ALL ON wp.* TO wp@localhost IDENTIFIED BY '${PASSWD}';FLUSH privileges;" | sudo mysql -u root
	sudo chown ubuntu:www-data /var/www -R

  # Composer support for empty projects
  if [[ ! -f 'composer.json' ]]; then
    cp composer.dist.json composer.json
  fi
	composer install

  set -x
  pushd "$(find . -name "wp-includes")/.." || return
    wp config create --dbname=wp --dbuser=wp --dbpass="$PASSWD"
    wp core install --url=https://$WMM_HOSTNAME.local --title=Example --admin_user=admin --admin_password="$PASSWD" --admin_email=admin@example.com --skip-email
    sed -i "/<?php/a define('FS_METHOD','direct');" wp-config.php
    sed -i "/<?php/a define('WP_CACHE', true);" wp-config.php
    sed -i "/<?php/a define( 'WP_DEBUG_DISPLAY', true );" wp-config.php
    sed -i "/<?php/a define( 'WP_DEBUG', true );" wp-config.php
    # logs
    sed -i "/<?php/a define( 'WP_DEBUG_LOG', '/var/www/logs/debug.log' );" wp-config.php
    # delete the default plugins
    wp plugin uninstall --all --deactivate
    # Install an opinionated set of defaults
    if [ ! -f "/multipass/wp-content/themes/susty/index.php" ]; then
      wp theme install --activate https://github.com/jacklenox/susty/archive/refs/heads/master.zip
    fi
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
