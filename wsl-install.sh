#!/usr/bin/env bash

sudo apt-get update \
    && sudo apt-get upgrade \
    && sudo apt-get -y install \
        build-essential \
        curl \
        wget \
        zsh \
        \
    \
;

for cmd in curl wget zsh; do
    [[ ! -e $( which ${cmd} ) ]] && echo "failed to install ${cmd}" && exit 127
done

source /opt/bin/install.sh
