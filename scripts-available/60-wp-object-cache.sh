#!/usr/bin/env bash
	echo "Installing Object Cache ..."
  require_redis
  require_wpcli
  pushd "wordpress/" || return
    wp plugin install redis-cache --activate
    wp redis update-dropin
    wp cache flush
  popd || return
