#!/bin/bash -l

set -xe

# Let's see where we're running
myroot=$(cd "$(dirname "$0")"; pwd)
source "${myroot}/path.helper"

export HOMEBREW_DEVELOPER=1
formula="${1}"
brew reinstall "${formula}"
brew audit --strict --online "${formula}"
brew test "${formula}"
