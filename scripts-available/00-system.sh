#!/usr/bin/env bash
echo '$nrconf{restart} = a;' | sudo te -a /etc/needrestart/needrestart.conf

if ! command -v avahi-daemon &> /dev/null
then
	echo 'Installing Bonjour ...'
	sudo apt-get install -y avahi-daemon 
fi