#!/usr/bin/env bash

# Load configuration from git

source /opt/bin/.zshrc

# Activate conveniences and helpers

eval "$( mise activate zsh )"

# Correctly bind navigation control keys in zsh

bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[3;3~" delete-word
