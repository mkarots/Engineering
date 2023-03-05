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
AUTOMALABS_MVP="$PROJECTS_ROOT/solana_related/automalabs/automalabs-mvp"
AUTOMALABS_LANDING="$PROJECTS_ROOT/solana_related/automalabs/automalabs-landing"
PROGLOG="$PROJECTS_ROOT/proglog"
NOOBCASH="$PROJECTS_ROOT/noobcash"

SETTINGS="$ENGINEERING/bashrc_design"
AUTOCOMPLETION_SETTINGS="$SETTINGS/autocompletion_scripts"
NOTES="$SETTINGS/notes"
BASH_PROFILE_PATH="$HOME/.bash_profile"
ZSH_PROFILE_PATH=""$HOME/.zshrc""
TRELLO_VARS_FILE="$SETTINGS/.trello_vars"
GITHUB_USERNAME="michael-karotsieris"
GITHUB_HOME="https://github.com/$GITHUB_USERNAME"
BOARDS_TRELLO="https://trello.com/michaelkarotsieris/boards"
COMPILERS_TRELLO="https://trello.com/b/gFL5QAQm/compilers"
ENGINEERING_TRELLO="https://trello.com/b/MPTBFQzo/engineering"

# Navigation
alias home='cd $HOME'
alias root='cd /'
alias dtop='cd $HOME/Desktop'

# Project navigation
alias arachne='cd $ARACHNE'
alias automalabs-landing='cd $AUTOMALABS_LANDING'
alias automalabs-mvp='cd $AUTOMALABS_MVP'
alias compilers='cd $COMPILERS'
alias dentapp='cd $DENTAPP'
alias diagrams='cd $DIAGRAMS'
alias engineering='cd $ENGINEERING'
alias eng=engineering
alias exploit='cd $PROJECTS_ROOT/exploit'
alias prj='cd $PROJECTS_ROOT'
alias pylox='cd $PYLOX'
alias proglog='cd $PROGLOG'
alias vraxion='cd $VRAXION'
alias vraxionapp='cd $VRAXIONAPP'
