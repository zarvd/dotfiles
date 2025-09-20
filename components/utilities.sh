#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

source "${GIT_ROOT}/lib/_includes.sh"

function utilities::install() {
  log::section "Install Utilities"

  local -ra utilities=(
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
