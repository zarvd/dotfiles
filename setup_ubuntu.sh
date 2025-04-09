#!/usr/bin/env bash

set -x
set -e -o pipefail

source ./setup/helper.sh
source ./setup/fish.sh
source ./setup/git.sh
source ./setup/rust.sh
source ./setup/golang.sh
source ./setup/docker.sh
source ./setup/vim.sh
source ./setup/bat.sh
source ./setup/utilities.sh

export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:/usr/local/go/bin

CMD=$1

case $CMD in
  all)
    setup_fish
    setup_git
    setup_rust
    setup_golang
    setup_docker
    setup_vim
    setup_bat
    install_utilities
    ;;
  golang)
    setup_golang
    ;;
  *)
    echo "Usage: $0 all | golang"
    exit 1
    ;;
esac
