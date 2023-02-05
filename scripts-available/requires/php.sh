#!/usr/bin/env bash

function require_php {
  PV=$1
  if ! apt-cache policy | grep -q 'ondrej/php'
  then
    sudo apt-get -y install php-pear software-properties-common apt-transport-https -y
    sudo add-apt-repository ppa:ondrej/php -y
    sudo apt-get update
  fi

  if ! apt-cache search php${PV}
  then
    echo "Installing PHP ${PV}..."
    sudo apt-get -y install php${PV}-cli php${PV}-fpm php${PV}-mysql php${PV}-curl php${PV}-gd php${PV}-mbstring php${PV}-common php${PV}-xml php${PV}-xmlrpc php${PV}-cli php${PV}-dev php${PV}-zip php${PV}-intl php${PV}-imagick php${PV}-redis
    sudo cp /multipass/etc/php/fpm/php.ini /etc/php/${PV}/fpm/php.ini
    sudo systemctl restart php${PV}-fpm
    sudo pecl channel-update pecl.php.net
  fi
}

function switch_php {
  PV=$1
  echo "Switching to PHP ${PV}..."

  # Install if required
  require_php "$PV"

  sudo update-alternatives --set php /usr/bin/php${PV}
  sudo update-alternatives --set php-fpm.sock /run/php/php${PV}-fpm.sock
  # Rotate WMM logs
  cat /multipass/etc/logrotate.d/wmm.tmpl | sed "s/PHP_VERSION/$PHP_VERSION/g" | sudo tee /etc/logrotate.d/wmm

  # Reload services
  sudo systemctl reload php$PV-fpm
  if command -v caddy &>/dev/null; then
    sudo systemctl reload caddy
  fi
}
