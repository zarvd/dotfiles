#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

source "${GIT_ROOT}/lib/_includes.sh"

function install_utilities() {
  print_section "Install Utilities"

  cargo install bat fd-find git-delta du-dust just lsd ripgrep tealdeer tokei ouch --locked --force
}
