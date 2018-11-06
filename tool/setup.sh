#!/bin/bash
set -e

pushd "$(dirname ${BASH_SOURCE[0]:-$0})"
if [ ! -d flutter ]; then
  git clone https://github.com/flutter/flutter.git -b master --depth 1
fi

source ./env.sh
flutter doctor
