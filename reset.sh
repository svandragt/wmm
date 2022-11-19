#!/usr/bin/env bash

read -p "Purge the current VM? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Delete and purge the VM..."
	multipass delete wmm; multipass purge
fi


read -p "Replace the scripts? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# Replace all the scripts
	rm scripts-enabled/*.sh
	cp scripts-available/*.sh scripts-enabled/
	./host.sh
fi


