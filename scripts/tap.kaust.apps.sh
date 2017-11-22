#!/bin/bash -l

set -xe

brew tap kaust-rc/apps
kaust_tap="$(brew --repository kaust-rc/apps)"
cd "${kaust_tap}"
chmod 644 *.rb
