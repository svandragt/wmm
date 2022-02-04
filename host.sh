#!/usr/bin/env bash
multipass launch -n wmm
multipass mount . wmm:/multipass

echo  "Run: . /multipass/guest.sh"
multipass shell wmm
