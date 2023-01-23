#!/usr/bin/env bash
# Prevent Ubuntu 22.04 asking the user which service should be restarted
sudo sed -i "/#\$nrconf{restart} = 'i';/a \$nrconf{restart} = 'a';" /etc/needrestart/needrestart.conf

sudo cp /multipass/etc/apt/sources.list /etc/apt/sources.list
sudo apt-get -y update

if ! command -v avahi-daemon &> /dev/null
then
	# Enable hostname.local and apt caching
	echo 'Installing Bonjour ...'
	sudo apt-get install -y avahi-daemon avahi-autoipd
fi

sudo mkdir -p /var/www/logs
sudo chown ubuntu:www-data /var/www/logs -R
sudo chmod g+w /var/www/logs -R
