#!/bin/bash -l

export HOMEBREW_DEVELOPER=1
formula="${1}"
brew reinstall "${formula}"
brew audit --strict --online "${formula}"
brew test "${formula}"
