#!/usr/bin/env bash
## Top-level profile script that imports all rest

PARENTDIR=$(dirname "$0")
source "$PARENTDIR"/projects.sh
source "$PARENTDIR"/github.sh
source "$PARENTDIR"/python.sh


# PROJECTS and Environment variables
SETTINGS="$ENGINEERING/bashrc_design"
AUTOCOMPLETION_SETTINGS="$SETTINGS/autocompletion_scripts"
NOTES="$SETTINGS/notes"
ZSH_PROFILE_PATH=""$HOME/.zshrc""
TRELLO_VARS_FILE="$SETTINGS/.trello_vars"

# Shortcuts
alias h='history'
alias c='clear'
alias q='exit'
alias cs='clear;ls'
alias chrome='open -a \"Google Chrome\"'
alias gr='grep'
alias p='cat'
alias lsa='ls -la'
alias mkdir='mkdir -pv'
alias ll='ls -lhA'
alias t='time'
alias k='kill'
alias o='open'
alias wget='wget -c'  # Continue the download in case of a problem
alias psg='ps | grep -v grep | grep -i -e VSZ -e'
alias null='/dev/null'
alias bashrc='vim $HOME/.bash_profile'
alias zshrc='vim $HOME/.zshrc'
alias term_size='echo "Rows=$(tput lines) Cols=$(tput cols)"'
alias src='clear;source $ZSH_PROFILE_PATH'

# docker aliases

alias docker-clean-containers='docker rm $(docker ps -aq)'
alias docker-clean-images='docker rmi $(docker images -aq)'
alias dcdown='docker-compose down'
alias dcupd='docker-compose up -d'
alias dreset='dcdown && dcupd'

# Global function aliases
alias ping='ping -c 10'
alias bd='cd "$OLDPWD"'
alias treed='tree -CAFd'
alias tree='tree -CAhF --dirsfirst'
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'


# Go
export PATH=$PATH:$(go env GOPATH)/bin

# Local Function aliases
alias trello='trello_open'
alias proj='project_open'
alias projc='project_open_with_code'

# Solana
alias sol-set-devnet='solana config set --url https://api.devnet.solana.com'
alias sol-get='solana config get'
alias sol-airdrop='solana airdrop'

function trello_open () {
    
    projectName="$1"
    
    if ! [ "$projectName" ];then
        o $BOARDS_TRELLO
    fi

    if [ "$projectName" = "compilers" ] || [ "$projectName" = "cmp" ]; then
        o $COMPILERS_TRELLO
    fi

    if [ "$projectName" = "eng" ] || [ "$projectName" = "engineering" ]; then
        o  $ENGINEERING_TRELLO
    fi
}


function reload() {
    . $SETTINGS/profile.sh;
}


alias netscan="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s"
