#!/usr/bin/env bash

IPADDR=$(hostname -I | cut -d' ' -f1)
echo ''
echo "Done! Update /etc/hosts with:"
echo "${IPADDR} wp.test "
