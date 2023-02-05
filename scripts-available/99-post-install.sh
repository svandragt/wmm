#!/usr/bin/env bash

require_caddy
sudo systemctl restart caddy

echo ''
echo "    Site: https://$WMM_HOSTNAME.local"
echo "    User: admin"
if [[ -v PASSWD ]]; then
  echo "Password: ${PASSWD}"
fi
