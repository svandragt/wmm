#!/usr/bin/env bash
require_caddy

# Update any changes to the template, swapping placeholders
cat /multipass/etc/caddy/Caddyfile.tmpl | sed "s/PHP_VERSION/$PHP_VERSION/g" | sed "s/WMM_DOMAIN/$WMM_DOMAIN/g"  | sudo tee /etc/caddy/Caddyfile
