# benjamindburke/.zsh

Scripts I wrote to do things.

## Pre-reqs

1. **`asdf`**
1. **`brew`**
1. **`direnv`**
1. **`nvim`**
1. **`oh-my-zsh`**
1. **`python3`**
1. **`zsh`**
1. **`jq`**

## Usage

1. Install prereqs
1. Clone repository to `/opt/bin`.
1. Add `source /opt/bin/.zshrc` to `~/.zshrc`.

## `scripts/`

### Exposed to `PATH`? - YES
### Git tracked? - YES

Place scripts that should be accessible and tracked in `scripts/`.

## `ssh_scripts/`

### Exposed to `PATH`? - NO
### Git tracked? - YES

These scripts and config files are uploaded to a remote host via `sshcp`.
Contents of `ssh_scripts/` are not sourced/accessible in `PATH` on the client - only on the remote.

## `priv/`

### Exposed to `PATH`? - NO
### Git tracked? - NO

Place scripts that shouldn't leak to Git in `priv/`.
