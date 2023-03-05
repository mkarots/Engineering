#!/usr/bin/env bash

alias docker-clean-containers='docker rm $(docker ps -aq)'
alias docker-clean-images='docker rmi $(docker images -aq)'
alias dcdown='docker-compose down'
alias dcupd='docker-compose up -d'
alias dreset='dcdown && dcupd'
