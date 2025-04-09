#!/usr/bin/env bash

set -x
set -e -o pipefail

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CUR_DIR/setup/helper.sh"
source "$CUR_DIR/setup/fish.sh"
source "$CUR_DIR/setup/git.sh"
source "$CUR_DIR/setup/rust.sh"
source "$CUR_DIR/setup/golang.sh"
source "$CUR_DIR/setup/docker.sh"
source "$CUR_DIR/setup/vim.sh"
source "$CUR_DIR/setup/bat.sh"
source "$CUR_DIR/setup/utilities.sh"

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
