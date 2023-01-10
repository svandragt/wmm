#!/usr/bin/env bash

sudo apt-get -y install php-pear software-properties-common apt-transport-https -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update

install_php $PHP_VERSION
switch_php $PHP_VERSION

# Allow install_php and switch_php from bash
echo "source /multipass/scripts-enabled/10-php-lib.sh" >> /home/ubuntu/.profile

sudo pecl channel-update pecl.php.net
