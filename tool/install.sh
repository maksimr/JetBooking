#!/bin/bash
set -e

case "$(uname -s)" in
  Darwin*)
    export HOMEBREW_NO_AUTO_UPDATE=1
    brew install libimobiledevice
    brew install ideviceinstaller
    brew install ios-deploy
    pip install six
    ;;
  *)
    # Flutter depends on /usr/lib/x86_64-linux-gnu/libstdc++.so.6
    # version GLIBCXX_3.4.18
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
    sudo apt-get update -y
    sudo apt-get install -y libstdc++6
    ;;
esac
