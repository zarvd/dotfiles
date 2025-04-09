#!/usr/bin/env bash

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CUR_DIR/helper.sh"

function install_utilities() {
  print_section "Install Utilities"

  sudo apt update
  sudo apt install -y build-essential make jq yq htop
  cargo install bat fd-find git-delta du-dust just lsd ripgrep tealdeer tokei --locked --force
}
