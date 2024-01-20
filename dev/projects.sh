#!/usr/bin/env bash

# "Active" projects get their own alias to ease navigation

PROJECTS_ROOT="$HOME/Projects"
ENGINEERING="$PROJECTS_ROOT/Engineering"
COMPILERS="$PROJECTS_ROOT/compilers"
GOPL="$PROJECTS_ROOT/gopl"
VRAXION="$PROJECTS_ROOT/vraxion"
PYLOX="$PROJECTS_ROOT/pylox"
DENTAPP="$PROJECTS_ROOT/dentapp"
DIAGRAMS="$PROJECTS_ROOT/diagrams"
MAS="$PROJECTS_ROOT/mas"
PROGLOG="$PROJECTS_ROOT/proglog"
NOOBCASH="$PROJECTS_ROOT/noobcash"

# Project navigation
alias prj='cd $PROJECTS_ROOT'
alias home='cd $HOME'
alias root='cd /'
alias dtop='cd $HOME/Desktop'

alias compilers='cd $COMPILERS'
alias dentapp='cd $DENTAPP'
alias diagrams='cd $DIAGRAMS'
alias mas='cd $MAS'
alias engineering='cd $ENGINEERING'
alias eng=engineering
alias gopl='cd $GOPL'
alias noobcash='cd $NOOBCASH'
alias pylox='cd $PYLOX'
alias proglog='cd $PROGLOG'
alias vraxion='cd $VRAXION'

alias proj='project_open'
alias projc='project_open_with_code'


### Functions

function project_open () {
    projectName="$1"
    if [ "$projectName" = "compilers" ] || [ "$projectName" = "cmp" ]; then
        cd "$PROJECTS_ROOT"/"compilers" || exit;
        if is_github_repo;then
            echo "Found existing github repo..."
            git log;
        fi

    fi
    if [ "$projectName" = "eng" ] || [ "$projectName" = "engineering" ]; then
        cd "$PROJECTS_ROOT"/"Engineering" || exit
        if is_github_repo;then
            echo "here"
            echo "Found existing github repo..."
            git log;
        fi
    fi
}


function project_open_with_code () {
    projectName="$1"
    if [ "$projectName" = "compilers" ] || [ "$projectName" = "cmp" ]; then
        cd "$PROJECTS_ROOT"/"compilers" && code .;

    fi
    if [ "$projectName" = "eng" ] || [ "$projectName" = "engineering" ]; then
        cd "$PROJECTS_ROOT"/"Engineering" && code .;
    fi
}
