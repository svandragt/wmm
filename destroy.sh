#!/usr/bin/env bash
multipass delete wmm; multipass purge
rm scripts-enabled/*.sh
cp scripts-available/*.sh scripts-enabled/