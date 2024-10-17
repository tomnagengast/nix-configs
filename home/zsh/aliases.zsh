# Override default commands
alias cat="bat --plain"
alias ls="lsd"

# SSH
alias gogogo="ssh -i ~/.ssh/replit -p 22 5dbe8df1-a623-4cc2-a30e-c954e2114be0@5dbe8df1-a623-4cc2-a30e-c954e2114be0-00-20lqwhdcc1630.kirk.replit.dev"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias df="vim $HOME/dotfiles"
alias dfa="vim $HOME/dotfiles/aliases.zsh"
alias dfz="vim $HOME/dotfiles/zshrc.zsh"


alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias l='ls -1A --group-directories-first'
alias ll='ls -1Al --header --group-directories-first'
alias s="subl"
alias vim="nvim"
alias h="history | tail -n 50"

# Directories
alias work="cd $HOME/code/replicatedhq/data"
alias me="cd $HOME/code/tomnagengast"

# dbt
alias dl="uv run dbt ls -s state:modified --resource-type model"
alias dr="uv run dbt run -s state:modified"
alias drm="uv run dbt run -s"
alias db="uv run dbt build -s state:modified"
alias dbm="uv run dbt build -s"
alias dt="uv run dbt test -m state:modified"
alias dtm="uv run dbt test"

alias sf="sqlfmt && sqlfluff fix"
alias ss="sqlfmt && sqlfluff lint"
alias tf="terraform"

# Airflow
alias comd="composer-dev"

# GitHub
alias npr="gh pr create --web"
alias cpb="git branch | sed -n -e 's/^\* \(.*\)/\1/p' | pbcopy"
alias lpr="cat ~/code/replicatedhq/__templates/dbt_pr.md | pbcopy"
alias runs="gh run watch -R \$(git remote get-url origin | sed -E 's|.*github\.com[:/](.+/[^/]+)\.git|\1|') .git)"

# Snowflake
alias snowsql=/Applications/SnowSQL.app/Contents/MacOS/snowsql
alias snf=snowsql

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

# Housekeeping
# Enable aliases to be sudo’ed
alias sudo='sudo '

# Utilities
alias cleanpy="find . -type d -name '__pycache__' -exec rm -r {} +"
alias cleands="find . -type f -name '*.DS_Store' -ls -delete"
alias cleanbak="find . -type f -name '*.bak' -ls -delete"
alias cleanup="cleanpy && cleands && cleanbak"
alias week='date +%V'
alias localip="ipconfig getifaddr en0"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias path='echo -e ${PATH//:/\\n}'
