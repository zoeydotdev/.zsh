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
1. Replace home dir config files with symlinks to this repository:
    ```
    rm ~/.zprofile; ln -s /opt/bin/.zprofile ~/.zprofile;
    rm ~/.editorconfig; ln -s /opt/bin/.editorconfig ~/.editorconfig;
    rm ~/.gitconfig/; ln -s /opt/bin/.gitconfig ~/.gitconfig;
    rm ~/.gitignore_global; ln -s /opt/bin/.gitignore_global ~/.gitignore_global;
    rm ~/.iex.exs; ln -s /opt/bin/.iex.exs ~/.iex.exs;
    rm ~/.tool-versions; ln -s /opt/bin/.tool-versions ~/.tool-versions;
    ```
1. Configure any unset variables from `./.zshrc` in `~/.zshrc` to keep them private!

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

### Exposed to `PATH`? - YES
### Git tracked? - NO

Place scripts that shouldn't leak to Git in `priv/`.
