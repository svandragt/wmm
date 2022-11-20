#!/usr/bin/env bash
if command -v caddy &> /dev/null
then
	sudo systemctl restart caddy
fi

