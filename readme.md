# wmm

Setup a simple local environment in a few minutes, using Multipass and shell scripting.

Features:
* Provision a server using a list of scripts, ran in alphabetical order.
* Example: sets up WordPress from scratch, with permalinks and object-cache. Accommodating a WordPress setup, but is flexible for other projects, just replace the scripts with your own.


## Requirements

- https://multipass.run/
- A working knowledge of bash scripting.

You do not need to know Docker or Ansible, Terraform or Chef, because this project keeps it simple.

## Installation

1. Run `./reset.sh` then follow instructions to add the guest host to your `/etc/hosts` file. It deletes the current guest and then reprovisions it.
2. load up https://wmm.local


## What's with the name wmm?

[VVV](https://varyingvagrantvagrants.org/) minus minus. I guess if you squint with your eyes multiple Vs look like a W?
