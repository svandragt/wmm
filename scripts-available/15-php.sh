#!/usr/bin/env bash
export PHP_VERSION="8.0"

require_php "$PHP_VERSION"
switch_php "$PHP_VERSION"

# Allow install_php and switch_php from login shell
echo "source /multipass/scripts-enabled/requires/php.sh" >> /home/ubuntu/.profile
