#!/usr/bin/env bash

function install_php {
  PV=$1
  echo "Installing PHP ${PV}..."
  sudo apt-get -y install php${PV}-cli php${PV}-fpm php${PV}-mysql php${PV}-curl php${PV}-gd php${PV}-mbstring php${PV}-common php${PV}-xml php${PV}-xmlrpc php${PV}-cli php${PV}-dev php${PV}-zip php${PV}-intl php${PV}-imagick php${PV}-redis
  sudo cp /multipass/etc/php/fpm/php.ini /etc/php/${PV}/fpm/php.ini
  sudo systemctl restart php${PV}-fpm
}

sudo apt-get -y install php-pear software-properties-common apt-transport-https -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update
install_php "8.0"
install_php "8.1"
install_php "8.2"

export PHP_VERSION="8.0"
sudo update-alternatives --set php /usr/bin/php$PHP_VERSION
sudo update-alternatives --set php-fpm.sock /run/php/php$PHP_VERSION-fpm.sock

# Pear is required should the user want to install any additional extensions
sudo pecl channel-update pecl.php.net
# Install modules for the currently active php version
# sudo pear config-set php_ini $(php --ini | grep /php.ini | cut -d ' ' -f 12)
# sudo pecl config-set bin_dir /usr/bin/
