#!/usr/bin/env bash

# Load configuration from git

source /opt/bin/.zshrc

# Activate conveniences and helpers

eval "$( mise activate zsh )"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Correctly bind navigation control keys in zsh

bindkey "^H" backward-delete-word
