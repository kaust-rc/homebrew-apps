#!/bin/bash -l

set -xe

brew tap kaust-rc/apps
kaust_tap="$(brew --repository kaust-rc/apps)"
chmod 644 "${kaust_tap}/*.rb"
