#!/usr/bin/env bash

GITHUB_USERNAME="michael-karotsieris"
GITHUB_HOME="https://github.com/$GITHUB_USERNAME"

# Github aliases
alias g='git status'
alias ga='git add -u'
alias gaa='git add .'
alias gc='git commit -m'
alias gcp='git_commit_and_push'
alias gcepp=gcp
alias gcmain='git checkout main'
alias gm='git merge'
alias gmm='git merge master'
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
alias gpl='git pull'
alias gph='git push'
alias gbc='git checkout'
alias gbcn='git checkout -b'
alias gb='git branch'
alias gba='gb -av'
alias gbd='gb -d'
alias gbrnm='gb -m'
alias gl='git log'
alias gd='git diff'
alias clone='git clone'
alias merge='git merge'

# Heroku aliases
alias gphm='git push heroku master'


### Functions

function is_github_repo () {
    if git rev-parse --is-inside-work-tree 2>/dev/null  ; then
        return 0
    else
        return 1
    fi
}

get_branchname () {
    BRANCH_NAME=$(git symbolic-ref --short HEAD)
    return $?
}

get_reponame () {
    REPO_NAME=$(basename "$(git rev-parse --show-toplevel)")
    return $?
}

get_repo_root () {
    REPO_ROOT="$(git rev-parse --show-toplevel)"/.git
}

get_repo_user () {
    REPO_USER=$(echo "$(git remote get-url origin)" | cut -d/ -f1 | cut -d: -f2)
}

cd () {
    builtin cd $1 || exit
    if is_github_repo;then
        get_repo_root
        get_reponame
        get_branchname
        g;
    else
        export BRANCH_NAME=""
        export REPO_NAME=""
    fi
}

pr_exists() {
    if is_github_repo;then
        get_repo_root
        get_reponame
        get_branchname
        expectedPrName="$REPO_ROOT/refs/remotes/origin/$BRANCH_NAME"
        if [ -f "$expectedPrName" ];then
            return 0
        fi
    fi
    return 1
}

function git_push () {
    get_branchname
    retcode=$?
    non_push_suffix="_local"
    # Only push if branch_name was found (my be empty if in detached head state)
    if [ $retcode -eq 0 ] ; then
            #Only push if branch_name does not end with the non-push suffix
            if [[ "$BRANCH_NAME" != *$non_push_suffix ]] ; then
                echo
                echo 🚀🚀🚀 Pushing $BRANCH_NAME to origin;
                echo
                git push origin "$BRANCH_NAME"
            fi
    fi
}


function git_commit_and_push () {
    shouldOpenWeb=true
    if is_github_repo;then
        re="(.)*"
        if [[ "$1" =~  $re ]]; then
            get_repo_root
            get_branchname;
            get_repo_user;
            get_reponame;
            ga ;gc $1;git_push;
        if [[ "$shouldOpenWeb" = true ]]; then
                if [[ "$BRANCH_NAME" = "master" ]]; then
                    open https://github.com/$REPO_USER/$REPO_NAME
                elif pr_exists;then
                    open https://github.com/$REPO_USER/$REPO_NAME/pull/$BRANCH_NAME
                else
                    open https://github.com/$REPO_USER/$REPO_NAME/compare/$BRANCH_NAME?expand=1
                fi
            fi
        else
            echo "Bad commit message: " $1
        fi
    else
        exit 1
    fi
}

function github_open () {
    get_reponame
    chrome $GITHUB_HOME/$REPO_NAME
}
