#!/usr/bin/env bash
function require_wpcli {
  if ! command -v wp &> /dev/null
  then
    echo 'Installing WP-CLI ...'
    requires_php "$PHP_VERSION"
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    php wp-cli.phar --info
    chmod +x wp-cli.phar
    sudo mv wp-cli.phar /usr/local/bin/wp
    wp --info
  fi
}
