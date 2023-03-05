#!/usr/bin/env bash

# "Active" projects get their own alias to ease navigation

PROJECTS_ROOT="$HOME/Projects"
ARACHNE="$PROJECTS_ROOT/arachne"
ENGINEERING="$PROJECTS_ROOT/Engineering"
COMPILERS="$PROJECTS_ROOT/compilers"
VRAXION="$PROJECTS_ROOT/vraxion"
PYLOX="$PROJECTS_ROOT/pylox"
VRAXIONAPP="$PROJECTS_ROOT/vraxion-app"
DENTAPP="$PROJECTS_ROOT/dentapp"
DIAGRAMS="$PROJECTS_ROOT/diagrams"
PROGLOG="$PROJECTS_ROOT/proglog"
NOOBCASH="$PROJECTS_ROOT/noobcash"

BOARDS_TRELLO="https://trello.com/michaelkarotsieris/boards"
COMPILERS_TRELLO="https://trello.com/b/gFL5QAQm/compilers"
ENGINEERING_TRELLO="https://trello.com/b/MPTBFQzo/engineering"

# Navigation

# Project navigation
alias prj='cd $PROJECTS_ROOT'
alias home='cd $HOME'
alias root='cd /'
alias dtop='cd $HOME/Desktop'

alias arachne='cd $ARACHNE'
alias compilers='cd $COMPILERS'
alias dentapp='cd $DENTAPP'
alias diagrams='cd $DIAGRAMS'
alias engineering='cd $ENGINEERING'
alias eng=engineering
alias noobcash='cd $NOOBCASH'
alias pylox='cd $PYLOX'
alias proglog='cd $PROGLOG'
alias vraxion='cd $VRAXION'
alias vraxionapp='cd $VRAXIONAPP'


### Functions

function project_open () {  
    projectName="$1"
    if [ "$projectName" = "compilers" ] || [ "$projectName" = "cmp" ]; then
        cd $PROJECTS_ROOT/"compilers";
        if is_github_repo;then
            echo "Found existing github repo..."
            git log;
        fi

    fi
    if [ "$projectName" = "eng" ] || [ "$projectName" = "engineering" ]; then
        cd $PROJECTS_ROOT/"Engineering"
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
        cd $PROJECTS_ROOT/"compilers" && code .;

    fi
    if [ "$projectName" = "eng" ] || [ "$projectName" = "engineering" ]; then
        cd $PROJECTS_ROOT/"Engineering" && code .;
    fi
} 
