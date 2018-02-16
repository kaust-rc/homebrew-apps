#!/bin/bash -l

set -xe

export HOMEBREW_DEVELOPER=1
formula="${1}"
brew reinstall "${formula}"
brew audit --strict --online "${formula}"
brew test "${formula}"
unlink "${formula}"
brew rm "${formula}"
