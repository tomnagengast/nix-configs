# Override default commands
alias cat="bat --plain"
alias ls="lsd"
# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias l='ls -1A --group-directories-first'
alias ll='ls -1Al --header --group-directories-first'
alias h="history | tail -n 50"

# Editors
alias c="code"
alias s="subl"
alias v="nvim"

# dbt
# alias dl="uv run dbt ls -s state:modified --resource-type model"
# alias dr="uv run dbt run -s state:modified"
# alias drm="uv run dbt run -s"
alias db="uv run dbt build -s state:modified"
alias dbm="uv run dbt build -s"
# alias dt="uv run dbt test -m state:modified"
# alias dtm="uv run dbt test"

alias tf="terraform"

# GitHub
alias npr="gh pr create --web"
alias cpb="git branch | sed -n -e 's/^\* \(.*\)/\1/p' | pbcopy"
alias lpr="cat ~/code/replicatedhq/__templates/dbt_pr.md | pbcopy"
alias runs="gh run watch -R \$(git remote get-url origin | sed -E 's|.*github\.com[:/](.+/[^/]+)\.git|\1|') .git)"

# Laravel
alias art="php artisan"
alias a="php artisan"
alias fresh="php artisan migrate:fresh --seed"

# Git
alias clean-local-branches='git branch | grep -v "main" | xargs git branch -D'
alias amend="git add -A && git commit --amend --no-edit"
alias ga="git add -A && git commit -m"
alias nah="git clean -df && git reset --hard"
alias oops="git reset --soft HEAD~1"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias unstage="git restore --staged ."
alias wip="ga wip"
alias wipp="wip && push"
alias aye="git checkout"
alias gl="glo"
alias gs="gss"
alias gr="git recent -n 5"
alias ggo="g go"

# GCP
alias impersonate="gcloud config set auth/impersonate_service_account" # $SERVICE_ACCOUNT_EMAIL
alias unimpersonate="gcloud config unset auth/impersonate_service_account"

# Utilities
alias cleanpy="find . -type d -name '__pycache__' -exec rm -r {} +"
alias cleands="find . -type f -name '*.DS_Store' -ls -delete"
alias cleanbak="find . -type f -name '*.bak' -ls -delete"
alias cleanup="cleanpy && cleands && cleanbak"
alias week='date +%V'
alias localip="ipconfig getifaddr en0"
alias publicip="curl -s https://ipv4.icanhazip.com"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias path='echo -e ${PATH//:/\\n}'
