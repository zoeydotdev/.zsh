#!/usr/bin/env bash

sudo \
    apt-get update \
    && apt-get upgrade \
    && apt-get -y install \
        build-essentials \
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
