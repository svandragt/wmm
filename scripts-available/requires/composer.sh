#!/usr/bin/env bash
function require_composer {
  if ! command -v composer &> /dev/null
  then
    echo 'Installing Composer ...'
    sudo apt-get -y install composer
  fi
}
