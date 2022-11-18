
if ! command -v avahi-daemon &> /dev/null
then
	echo 'Installing Bonjour ...'
	sudo apt-get install -y avahi-daemon 
fi