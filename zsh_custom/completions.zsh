# append ASDF completions to fpath
fpath=(
    ${ASDF_DIR}/completions
    ${HOMEBREW_PREFIX}/completions
    $fpath
)

# Configure Kubernetes if installed
[[ -f $( which kubectl ) ]] \
    && source <(kubectl completion zsh)

# Configure Terraform if installed
[[ -f $( brew --prefix terraform )/bin/terraform ]] \
    && complete -o nospace -C $( brew --prefix terraform )/bin/terraform terraform

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
