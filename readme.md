# wmm

Setup a simple local environment in a few minutes. Accommodating a WordPress setup, but is flexible for other projects.

Features:
* Provision a server using a list of scripts, renamed in order of execution.
* Example: sets up WordPress from scratch, with permalinks and object-cache.


## Requirements

- https://multipass.run/
- A working knowledge of bash scripting, because all the configuration and extensions will use them.

## Installation

1. Run `./reset.sh` then follow instructions to add the guest host to your `/etc/hosts` file. It deletes the current guest and then reprovisions it.
2. load up https://wp.test


## What's with the name wmm?

[VVV](https://varyingvagrantvagrants.org/) minus minus. I guess if you squint with your eyes multiple Vs look like a W?
