#!/usr/bin/env bash

# Accept envronment variable, or fallback to the script's directory
WMM_HOSTNAME=${WMM_HOSTNAME:-$(basename $PWD)}
read -p "Purge the current VM $WMM_HOSTNAME? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Delete and purge the VM..."
	multipass delete $WMM_HOSTNAME; multipass purge
fi


read -p "Replace the scripts and launch? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# Replace all the scripts
	rm scripts-enabled/*.sh
	cp scripts-available/*.sh scripts-enabled/
	./host.sh
fi


