#!/usr/bin/env bash
## Top-level profile script that imports all rest

PARENTDIR=$(dirname "$0")

source "$PARENTDIR"/docker.sh
source "$PARENTDIR"/github.sh
source "$PARENTDIR"/go.sh
source "$PARENTDIR"/projects.sh
source "$PARENTDIR"/python.sh
source "$PARENTDIR"/tools.sh

# PROJECTS and Environment variables
DEV_SETTINGS="$ENGINEERING/dev"
ZSH_PROFILE_PATH=""$HOME/.zshrc""

# Shortcuts
alias h='history'
alias c='clear'
alias q='exit'
alias cs='clear;ls'
alias chrome='open -a \"Google Chrome\"'
alias mkdir='mkdir -pv'
alias ll='ls -lhA'
alias wget='wget -c'  # Continue the download in case of a problem
alias psg='ps | grep -v grep | grep -i -e VSZ -e'
alias null='/dev/null'
alias bashrc='vim $HOME/.bash_profile'
alias zshrc='vim $HOME/.zshrc'
alias term_size='echo "Rows=$(tput lines) Cols=$(tput cols)"'
alias src='clear;source $ZSH_PROFILE_PATH'

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

alias netscan="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s"

# Solana
alias sol-set-devnet='solana config set --url https://api.devnet.solana.com'
alias sol-get='solana config get'
alias sol-airdrop='solana airdrop'


function reload() {
    source $DEV_SETTINGS/profile.sh;
}
