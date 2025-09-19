#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

source "${GIT_ROOT}/lib/_includes.sh"

function install_utilities() {
  print_section "Install Utilities"

  local utilities=(
    bat
    lsd
    fd-find
    git-delta
    du-dust
    dysk
    just
    ripgrep
    tealdeer
    tokei
    ouch
    typst-cli
  )

  cargo install "${utilities[@]}" --locked
}
