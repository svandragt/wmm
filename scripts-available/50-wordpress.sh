#!/usr/bin/env bash
require_mariadb
require_wpcli
require_composer

PASSWD=wordpress

# Composer support for empty projects
if [[ ! -f 'composer.json' ]]; then
  cp composer.dist.json composer.json
fi
composer install

pushd "$(find . -name "wp-includes")/.." || return
  if [ ! -f "wp-config.php" ]
  then
    echo "Installing WordPress ..."
    # A password is required to setup the database user
    echo "DROP DATABASE IF EXISTS wp; CREATE DATABASE wp; GRANT ALL ON wp.* TO wp@localhost IDENTIFIED BY '${PASSWD}';FLUSH privileges;" | sudo mysql -u root
    wp config create --dbname=wp --dbuser=wp --dbpass="$PASSWD"
    wp core install --url="https://$WMM_DOMAIN" --title=Example --admin_user=admin --admin_password="$PASSWD" --admin_email=admin@$WMM_DOMAIN --skip-email

    sed -i "/<?php/a define('FS_METHOD','direct');" wp-config.php
    sed -i "/<?php/a define('WP_CACHE', true);" wp-config.php
    sed -i "/<?php/a define( 'WP_DEBUG_DISPLAY', true );" wp-config.php
    sed -i "/<?php/a define( 'WP_DEBUG', true );" wp-config.php
    # logs
    sed -i "/<?php/a define( 'WP_DEBUG_LOG', '/var/www/logs/debug.log' );" wp-config.php
    # delete the default plugins
    wp plugin uninstall --all --deactivate
    # Install an opinionated set of defaults
    if [ ! -f "wp-content/themes/susty/index.php" ]; then
      wp theme install https://github.com/jacklenox/susty/archive/refs/heads/master.zip
    fi
    wp theme activate susty
    wp plugin install query-monitor --activate
    wp plugin install surge --activate
    wp plugin install user-switching --activate
    wp plugin install wp-crontrol --activate
    wp rewrite structure '/%postname%'
    wp surge flush --delete
  fi
  sudo chown ubuntu:www-data wp-content -R
  sudo chmod g+w wp-content -R
popd || return
