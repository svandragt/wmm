#!/usr/bin/env bash
if ! command -v mysql &> /dev/null
then
	if [[ -z "$PASSWD" ]]; then
    	echo "Set password:" && read -r PASSWD
	fi
	echo 'Installing MariaDB ...'
	sudo apt-get -y install mariadb-client mariadb-server
	echo "CREATE DATABASE wp; GRANT ALL ON wp.* TO wp@localhost IDENTIFIED BY '${PASSWD}';FLUSH privileges;" | sudo mysql -u root
fi
