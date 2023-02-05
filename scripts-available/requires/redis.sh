#!/usr/bin/env bash
function require_redis {
  if ! command -v redis-cli &> /dev/null
	then
	  sudo apt-get -y install redis-server redis-tools
  fi
}
