# benjamindburke/.zsh

Scripts I wrote to do things.

# Pre-requisites

1. [WezTerm](https://wezfurlong.org/wezterm/index.html)

## MacOS Installation

1. Execute in terminal
    ```sh
    git clone git@github.com:benjamindburke/.zsh /opt/bin;
    source /opt/bin/install.sh;
    ```
1. Configure .gitconfig files in ~/repos and ~/repos-personal
1. [Configure SSH keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
1. [Configure GPG signing keys](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key)
1. Add SSH and GPG keys to [GitHub settings](https://github.com/settings/keys)
1. Configure any unset variables in `~/.zshrc` to keep them private!

## Windows WSL Installation

1. Execute in **Powershell as Administrator**
    ```ps1
    New-Item -ItemType SymbolicLink -Path "$Env:Home\.wezterm.lua" -Target "\\wsl.localhost\Debian\opt\bin\.wezterm.lua"
    ```
1. Execute in WSL after opening WezTerm (by default, should open to the WSL home configured inside [./confs/wezterm.lua](../confs/.wezterm.lua))
    ```sh
    sudo apt-get install git;
    sudo git clone git@github.com:benjamindburke/.zsh /opt/bin;
    sudo chown -hR $USER /opt/bin;
    source /opt/bin/win-install.sh;
    ```
1. Update .gitconfig files in ~/repos and ~/repos-personal
1. [Create SSH public/private keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
2. [Create GPG signing keys](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key)
3. [Add SSH and GPG keys to GitHub settings](https://github.com/settings/keys)
4. Configure any unset variables in `~/.zshrc` to keep them private!

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
