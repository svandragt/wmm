if ! command -v php &> /dev/null
then
	echo 'Installing PHP 7.4 ...'
	sudo apt-get -y install php-fpm php-mysql php-curl php-gd php-mbstring php-common php-xml php-xmlrpc php-cli php-pear php-dev php-zip php-intl php-imagick
	sudo pecl channel-update pecl.php.net
fi