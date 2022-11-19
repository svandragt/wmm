# wmm

Setup a simple WordPress local environment in a few minutes, using Multipass and shell scripting. Provision a server using a list of scripts, ran in alphabetical order.

WordPress Features:
* PHP 8.0 and latest WordPress
* Object cache using Redis
* Full page caching using Surge
* Self signed HTTPS using Caddy
* Minimal default theme using Susty
* Pretty permalinks
* Bonjour zero hostname configuration



## Requirements

- https://multipass.run/
- A working knowledge of bash scripting.

You do not need to know Docker or Ansible, Terraform or Chef, because this project keeps it simple.

## Installation

1. Run `./reset.sh` then follow instructions to add the guest host to your `/etc/hosts` file. It deletes the current guest and then reprovisions it.
2. load up https://wmm.local


## What's with the name wmm?

[VVV](https://varyingvagrantvagrants.org/) minus minus. I guess if you squint with your eyes multiple Vs look like a W?
