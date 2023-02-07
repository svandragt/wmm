#!/usr/bin/env bash
function require_mariadb {
  if ! command -v mysql &> /dev/null
  then
    echo 'Installing MariaDB ...'
    sudo apt-get -y install mariadb-client mariadb-server
  fi
}
