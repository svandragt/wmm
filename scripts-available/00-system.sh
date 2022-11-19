#!/usr/bin/env bash
sudo sed -i "/#\$nrconf{restart} = 'i';/a \$nrconf{restart} = 'a';" /etc/needrestart/needrestart.conf

if ! command -v avahi-daemon &> /dev/null
then
	echo 'Installing Bonjour ...'
	sudo apt-get install -y avahi-daemon 
fi