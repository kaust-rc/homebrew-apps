#!/bin/bash -l

set -xe

# Let's see where we're running
myroot=$(cd "$(dirname "$0")"; pwd)
source "${myroot}/path.helper"

brew tap kaust-rc/apps
kaust_tap="$(brew --repository kaust-rc/apps)"
cd "${kaust_tap}"
chmod 644 ./*.rb
