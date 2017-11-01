#!/bin/bash

if [ $# -eq 0 ]
then
    echo "Usage ./test.sh <formula>"
    exit 1
fi

_formula="$1"
_formula_name="$(basename $_formula .rb)"

if [ ! -f  "${_formula}" ]
then
    echo "Formula <${_formula_name}> does not exist"
    exit 1
fi

_cellar="$(brew --repository kaust-rc/apps)"

if [ ! -d "${_cellar}" ]
then
    brew tap kaust-rc/apps
fi

_pwd="$(pwd)"

if [ -f "${_cellar}/${_formula}" ]
then
    echo "Formula already exist so I'm bailing out..."
    exit 1
fi

ln -s "${_pwd}/${_formula}" "${_cellar}/${_formula}"
brew install "${_formula}"
brew audit --strict "${_formula}"
brew test "${_formula}"
unlink "${_cellar}/${_formula}"
brew rm "${_formula_name}"
