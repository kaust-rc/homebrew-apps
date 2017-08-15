#!/bin/bash

if [ $# -eq 0 ]
then
    echo "Usage ./test.sh <formula>"
    exit 1
fi

_formula="$(basename $1 .rb)"

if [ ! -f  "${_formula}.rb" ]
then
    echo "Formula <${_formula}> does not exist"
    exit 1
fi

_cellar="$(brew --repository kaust-rc/apps)"
_pwd="$(pwd)"

ln -s "${_pwd}/${_formula}.rb" "${_cellar}/${_formula}.rb"
brew test-bot --tap=kaust-rc/apps --junit --skip-setup "${_formula}"
unlink "${_cellar}/${_formula}.rb"
