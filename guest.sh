#!/usr/bin/env bash

echo "Set password:" && read PASSWD

sudo apt install -y apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo tee /etc/apt/trusted.gpg.d/caddy-stable.asc
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt-get -y update

sudo apt-get -y install php-fpm php-mysql php-curl php-gd php-mbstring php-common php-xml php-xmlrpc \
caddy mariadb-client mariadb-server net-tools

#mariadb
echo "CREATE DATABASE wp; GRANT ALL ON wp.* TO wp@localhost IDENTIFIED BY '${PASSWD}';FLUSH privileges;" | sudo mysql -u root

# wp cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
wp --info

# wordpress
sudo mkdir -p /var/www/html
sudo chown ubuntu:www-data /var/www -R
cd /var/www/html
wp core download
wp config create --dbname=wp --dbuser=wp --dbpass=$PASSWD
wp core install --url=wp.test --title=Example --admin_user=admin --admin_password=$PASSWD --admin_email=admin@example.com --skip-email

sudo cp /multipass/etc/caddy/Caddyfile /etc/caddy/Caddyfile
sudo systemctl restart caddy

IPADDR=$(hostname -I | cut -d' ' -f1)
echo "Done! Add the following line to your /etc/hosts"
echo "${IPADDR} wp.test "