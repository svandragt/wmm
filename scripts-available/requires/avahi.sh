#!/usr/bin/env bash
function require_avahi {
  if ! command -v avahi-daemon &> /dev/null
  then
    # Enable hostname.local and apt caching
    echo 'Installing Avahi ...'
    sudo apt-get install -y avahi-daemon avahi-autoipd
  fi
}
