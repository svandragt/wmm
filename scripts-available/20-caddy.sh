#!/usr/bin/env bash
if ! command -v caddy &> /dev/null
then
	echo 'Installing Caddy ...'
	sudo apt-get install -y debian-keyring debian-archive-keyring apt-transport-https
	curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
	curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
	sudo apt-get update
	sudo apt-get install caddy -y
	sudo systemctl enable --now caddy
	# Hack to fix permission issues
	sudo usermod -a -G ubuntu www-data
fi
# Update any changes to the template, swapping placeholders
cat /multipass/etc/caddy/Caddyfile.tmpl | sed "s/PHP_VERSION/$PHP_VERSION/g" | sudo tee /etc/caddy/Caddyfile
