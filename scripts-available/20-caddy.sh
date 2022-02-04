#!/usr/bin/env bash
if ! command -v caddy &> /dev/null
then
	echo 'Installing Caddy ...'
	sudo apt install -y apt-transport-https
	curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo tee /etc/apt/trusted.gpg.d/caddy-stable.asc
	curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
	sudo apt-get -y update
	sudo apt-get -y install caddy
fi

sudo cp /multipass/etc/caddy/Caddyfile /etc/caddy/Caddyfile

#TODO register post actions
