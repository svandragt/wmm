#!/usr/bin/env bash
export PHP_VERSION="8.0"
if ! command -v php &> /dev/null
then
	echo "Installing PHP ${PHP_VERSION}..."
	sudo apt-get install software-properties-common apt-transport-https -y
	sudo add-apt-repository ppa:ondrej/php -y
	sudo apt-get update
	sudo apt-get -y install php$PHP_VERSION-cli php$PHP_VERSION-fpm php$PHP_VERSION-mysql php$PHP_VERSION-curl php$PHP_VERSION-gd php$PHP_VERSION-mbstring php$PHP_VERSION-common php$PHP_VERSION-xml php$PHP_VERSION-xmlrpc php$PHP_VERSION-cli php$PHP_VERSION-dev php$PHP_VERSION-zip php$PHP_VERSION-intl php$PHP_VERSION-imagick
	# Pear is required should the user want to install any additional extensions
	sudo apt-get -y install php-pear
	sudo pecl channel-update pecl.php.net
fi