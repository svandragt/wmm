#!/usr/bin/env bash
require_caddy

# Update any changes to the template, swapping placeholders
cat /multipass/etc/caddy/Caddyfile.tmpl | sed "s/PHP_VERSION/$PHP_VERSION/g" | sed "s/WMM_DOMAIN/$WMM_DOMAIN/g"  | sudo tee /etc/caddy/Caddyfile
# Caddy has to restart often enough until the log mount is ready.
sudo cp /multipass/lib/systemd/system/caddy.service /lib/systemd/system/caddy.service
sudo systemctl restart caddy
