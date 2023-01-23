#!/usr/bin/env bash

echo ''
echo "    Site: https://$WMM_HOSTNAME.local"
echo "    User: admin"
if [[ -v PASSWD ]]; then
  echo "Password: ${PASSWD}"
fi
