#!/usr/bin/env bash
	echo "Installing Object Cache ..."
  requies_redis
  requires_wpcli
  pushd /var/www/html || return
    wp plugin install redis-cache --activate
    wp redis update-dropin
    wp cache flush
  popd || return
