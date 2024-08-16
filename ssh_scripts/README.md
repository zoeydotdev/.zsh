# ssh_scripts/

If you place **executable** scripts in this folder and connect to a remote host using [`sshcp`](../scripts/sshcp),
then your scripts will be uploaded to the remote host and added to PATH before connecting via SSH.

Scripts **must** have at least one execution bit set to be uploaded by `sshcp`.

## ssh_scripts/.bashrc

Configure your remote host by modifying the provided .bashrc file [ssh_scripts/.bashrc](../ssh_scripts/.bashrc).  
`ssh_scripts/.bashrc` is also uploaded to a remote host when connecting to that host via [`sshcp`](../scripts/sshcp).
