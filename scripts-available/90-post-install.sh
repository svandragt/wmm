#!/usr/bin/env bash

require_caddy
sudo systemctl restart caddy

echo ''
echo "    Site: https://$WMM_DOMAIN"
echo "    User: admin"
echo "    Password: ${PASSWD}"
