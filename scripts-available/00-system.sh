#!/usr/bin/env bash
# Prevent Ubuntu 22.04 asking the user which service should be restarted
sudo sed -i "/#\$nrconf{restart} = 'i';/a \$nrconf{restart} = 'a';" /etc/needrestart/needrestart.conf
if ! command -v avahi-daemon &> /dev/null
then
	# Enable hostname.local
	echo 'Installing Bonjour ...'
	sudo apt-get install -y avahi-daemon 
fi

sudo mkdir -p /var/www/logs
sudo chown ubuntu:www-data /var/www/logs -R
sudo chmod g+w /var/www/logs -R

cat /multipass/etc/logrotate.d/wmm.tmpl | sed "s/PHP_VERSION/$PHP_VERSION/g" | sudo tee /etc/logrotate.d/wmm
