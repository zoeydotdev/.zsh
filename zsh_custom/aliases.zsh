# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. For a full list of active aliases, run `alias`.

# set NeoVim aliases
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias v.='nvim .'

# Replace all git commit aliases from oh-my-zsh git plugin,
# prefer ~/global/git_commit_secure to protect credentials

# Git committing aliases
alias 'git commit'='git commit --gpg-sign'
alias gc='git_commit_secure --verbose'
alias gc!='git_commit_secure --verbose --amend'
alias gcn!='git_commit_secure --verbose --no-edit --amend'
alias gca='git_commit_secure --verbose --all'
alias gca!='git_commit_secure --verbose --all --amend'
alias gcan!='git_commit_secure --verbose --all --no-edit --amend'
alias gcans!='git_commit_secure --verbose --all --signoff --no-edit --amend'
alias gcam='git_commit_secure --all --message'
alias gcsm='git_commit_secure --signoff --message'
alias gcas='git_commit_secure --all --signoff'
alias gcasm='git_commit_secure --all --signoff --message'
alias gcmsg='git_commit_secure --message'
alias gcs='git_commit_secure'
alias gcss='git_commit_secure --signoff'
alias gcssm='git_commit_secure --signoff --message'
alias gcamm='git_commit_secure --amend --message "$(commitmsg)"'


## Other Git aliases
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; $(which git) commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gstall='git stash -a'
alias dfy='gitdf -y'

# PostgreSQL aliases
alias pgup='pg_ctl -D /opt/homebrew/var/postgresql@14 start > /dev/null'
alias pgdown='pg_ctl -D /opt/homebrew/var/postgresql@14 stop > /dev/null'

# Utility aliases

# Docker aliases

alias dcb='docker compose build'
alias dcu='docker compose up'
alias dbu='docker compose up --build'
alias dls='docker container ls'

# Alias software with inconvenient names
alias fly='flyctl'

# brewdeps will list all formulas that aren't dependents of any other formulas,
# and all of their dependencies
alias brewdeps='brew leaves | xargs brew deps --formula --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/"'

# Generate filetree with nesting levels
alias tree='tree -v --filesfirst --charset utf-8 -h --du'
