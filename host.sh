#!/usr/bin/env bash
multipass launch -n wmm
multipass mount . wmm:/multipass

echo ''
echo  "Run: . /multipass/guest.sh"
multipass shell wmm
