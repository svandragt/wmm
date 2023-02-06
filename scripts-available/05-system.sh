#!/usr/bin/env bash

sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1

# Prevent Ubuntu 22.04 asking the user which service should be restarted
sudo sed -i "/#\$nrconf{restart} = 'i';/a \$nrconf{restart} = 'a';" /etc/needrestart/needrestart.conf

sudo cp /multipass/etc/apt/sources.list /etc/apt/sources.list
sudo apt-get -y update


require_avahi

sudo mkdir -p /var/www/logs
sudo chown ubuntu:www-data /var/www/logs -R
sudo chmod g+w /var/www/logs -R
