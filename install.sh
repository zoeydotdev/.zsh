#!/usr/bin/env bash

# This script automatically configures the installation process.

# Step 0:
#   obtain which computer script is running on

APPLE=$(   echo $PATH | grep -io 'apple' )
WINDOWS=$( echo $PATH | grep -io 'system32' )
function only_if_apple()   { [[ ! -z "${APPLE}" ]]   && eval "$@"; }
function only_if_windows() { [[ ! -z "${WINDOWS}" ]] && eval "$@"; }

# Step 1:
#   install preferred package managers

bash -c "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh )"
[[ -z $(which brew) ]] \
    && echo "failed to install brew" \
    && exit 1

# Step 2:
#   ensure zsh is the default shell

# Apple-only: install zsh from brew
only_if_apple brew install coreutils openssl@3 tree zsh

[[ -z $( echo ${SHELL} | grep 'zsh' ) ]] && sudo chsh -s $( which zsh )

# Step 3:
#   install oh-my-zsh

bash -c "$( curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh )"
[[ ! -d ~/.oh-my-zsh ]] \
    && echo "failed to install oh-my-zsh" \
    && exit 2

# Step 4:
#   configure system config files in homedir
[[ -f ~/.zshrc ]] || touch ~/.zshrc
only_if_apple cat /opt/bin/mac-conf/.zshrc >> ~/.zshrc
only_if_windows cat /opt/bin/win-conf/.zshrc >> ~/.zshrc
chmod 755 ~/.zshrc

for config in $( ls -ap /opt/bin/confs/ | egrep -v '(/|.wezterm.lua|.md)' ); do
    homedir_conf=~/${config}
    [[ -f ${homedir_conf} ]] && mv ${homedir_conf} ${homedir_conf}-$( date -u '+%s' )
    ln -s /opt/bin/confs/${config} ${homedir_conf}
done

# Apple-only: symlink this repo's WezTerm conf file to $HOME and create alias
# Windows-only: this file is already symlinked via Powershell from outside WSL
only_if_apple \
    ln -s /opt/bin/confs/.wezterm.lua ~/.wezterm.lua

# Step 5:
#   create git dirs and location-specific gitconfig files

echo "creating typical git dirs"
for gitdir in ~/repos ~/repos-personal; do
    [[ ! -d ${gitdir} ]] \
        && mkdir ${gitdir} \
        || echo "skipping $gitdir creation"

    [[ ! -f ${gitdir}/.gitconfig ]] \
        && touch ${gitdir}/.gitconfig \
        || echo "${gitdir}/.gitconfig already exists"
done
echo "finished creating git dirs"

# Step 6:
#   install system utilities from preferred package managers

brew install \
    delve \
    direnv \
    flyctl \
    fzf \
    go \
    jq \
    lua \
    mise \
    nvm \
    neovim \
    postgresql@18 \
    pyenv \
    ripgrep \
    rust \
    spicetify-cli \
    thefuck \
    tmux \
    tree-sitter \
    wrk \
    yq \
;

# Step 7:
#   install mise-managed global software versions

mise install

# Step 8:
#   Git clone neovim config

[[ ! -d ~/.config ]] && mkdir ~/.config
git clone git@github.com:zoeydotdev/nvim-config.git ~/.config/nvim

# Step 9:
#   Symlink personal directories to repo roots

ln -s /opt/bin ${HOME}/repos-personal/zsh-config
ln -s ${HOME}/.config/nvim ${HOME}/repos-personal/nvim-config

# Step 10:
#   Configure global python versions and build nvim debugpy venv

PYTHON_VERSION=$( cat ~/.config/nvim/.python-version )
pyenv install --skip-existing $PYTHON_VERSION
pyenv global $PYTHON_VERSION

cd ~/.config/nvim
pyenv local $PYTHON_VERSION
$( which python ) -m venv venv/
chmod +x venv/bin/activate
. venv/bin/activate

pip install -r requirements.txt

# Step 11:
#   install global version of node

nvm install $( cat ~/.nvmrc )

# Step 12:
#    install global npm dependencies

npm install -g neovim

# Step 13:
#   configure spicetify-cli

mkdir -p ~/.config/spicetify/
only_if_apple \
    ln -s /opt/bin/mac-conf/config-xpui.ini ~/.config/spicetify/config-xpui.ini

spicetify backup apply enable-devtools

# Step 14:
#   configure VSCode's settings.json

# Apple-only: create a link in the VSCode 'Application' directory
# Windows-only: this file is already symlinked via Powershell from outside WSL
only_if_apple \
    ln -s /opt/bin/mac-conf/settings.json ~/Library/Application\ Support/Code/User/settings.json
