#!/usr/bin/env bash
if command -v caddy &> /dev/null
then
	sudo systemctl restart php$PHP_VERSION-fpm
	sudo systemctl restart caddy
fi

