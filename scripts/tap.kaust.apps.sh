#!/bin/bash -l

set -xe

env|sort

brew tap kaust-rc/apps
kaust_tap="$(brew --repository kaust-rc/apps)"
ls -al "${kaust_tap}"
chmod 644 "${kaust_tap}/*.rb"
