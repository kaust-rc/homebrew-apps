#!/bin/bash -l

set -xe

echo "PATH: ${PATH}"

brew tap kaust-rc/apps
kaust_tap="$(brew --repository kaust-rc/apps)"
cd "${kaust_tap}"
chmod 644 *.rb
