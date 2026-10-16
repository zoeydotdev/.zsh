# Configure Kubernetes if installed
[[ -f $( which kubectl ) ]] \
    && source <(kubectl completion zsh)

# The next line enables shell command completion for gcloud.
[[ -f "$GCLOUD_INSTALL_PATH/completion.zsh.inc" ]] \
    && source "$GCLOUD_INSTALL_PATH/completion.zsh.inc"

# Configure fzf key bindings and fuzzy completion
[[ -f $( brew --prefix fzf )/bin/fzf ]] \
    && source <(fzf --zsh)

# Bash completion
autoload -U +X bashcompinit && bashcompinit

# initialize completions with ZSH's compinit
autoload -Uz compinit && compinit
