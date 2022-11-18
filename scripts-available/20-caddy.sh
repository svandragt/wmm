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
fi

echo "Applying configuration..."
sudo cp /multipass/etc/caddy/Caddyfile /etc/caddy/Caddyfile
sudo systemctl restart caddy

#TODO register post actions
