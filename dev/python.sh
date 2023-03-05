#!/usr/bin/env bash

alias py=python3
alias python=python3
alias pip=pip3
alias pipr='pip3 install -r requirements.txt'
alias pybuildpackage='python setup.py sdist bdist_wheel'
alias pycheckpackage='twine check dist/*'
alias pypublishpackage='twine upload dist/*'
alias pyvenv='py -mvenv venv'
alias pyenv='py -mvenv'

# Needs to be exported in order to be used by Makefile
export TWINE_USERNAME="mkarotsieris"

function pypipush() {
    pybuildpackage && pycheckpackage && pypublishpackage -u $TWINE_USERNAME && rm -rf ./dist ./build
}

function py_version () {
    py -c "from importlib.metadata import version; print(version('${1}'))"
}
