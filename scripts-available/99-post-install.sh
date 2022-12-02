#!/usr/bin/env bash

cat /multipass/etc/logrotate.d/wmm.tmpl | sed "s/PHP_VERSION/$PHP_VERSION/g" | sudo tee /etc/logrotate.d/wmm

echo ''
echo "    Site: https://$WMM_HOSTNAME.local"
echo "    User: admin"
if [[ -v PASSWD ]]; then
  echo "Password: ${PASSWD}"
fi
