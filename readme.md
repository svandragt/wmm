# wmm
As a developer<br>
I want to work on WP plugins/themes<br>
Without overcomplicated local environment.

As a developer<br>
I want to script my particular edge cases<br>
So that my local environment can accommodate them.

## Summary

Setup a simple WordPress local environment in a few minutes, using Multipass and shell scripting. It's currently suitable for bundle-less WordPress plugin and theme development that doesn't require a task queue and content search.

Provisioner features:
* Provision a server using a list of scripts, ran in alphabetical order.
* Allows multiple instances with dynamic hostnames
* All tooling is installed in the guest.

WordPress Features:
* All supported PHP versions (8.0-8.2) and latest WordPress
* Object cache using Redis
* Full page caching using Surge
* Self signed HTTPS using Caddy
* Minimal default theme using Susty
* Pretty permalinks
* Bonjour zero hostname and domain configuration



## Requirements

- https://multipass.run/
- A working knowledge of bash scripting.

You do not need to know Docker or Ansible, Terraform or Chef, because this project keeps it simple.

## Installation

1. Run `./host.sh` then provide the admin/database password when asked.
2. Reset your environment by running the `reset.sh` script.


## What's with the name wmm?

I'm [looking for a new name](https://github.com/svandragt/wmm/issues/11).


## Advanced use

### Use a different hostname

The hostname is based on the directory the scripts are running in. To provide a custom hostname prefix `host.sh` or `reset.sh` with `WMM_HOSTNAME=myhostname` eg: `$ WMM_HOSTNAME=dolly ./host.sh`

