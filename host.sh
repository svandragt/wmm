#!/usr/bin/env bash
multipass launch -n vmm
multipass mount . vmm:/multipass

echo  "Run: . /multipass/guest.sh"
multipass shell vmm
