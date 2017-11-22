#!/bin/bash -l

set -xe

echo "PATH: ${PATH}"

brew untap kaust-rc/apps 2> /dev/null
brew tap kaust-rc/apps
kaust_tap="$(brew --repository kaust-rc/apps)"
cd "${kaust_tap}"
chmod 644 *.rb
