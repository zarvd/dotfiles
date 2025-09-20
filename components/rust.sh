#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

source "${GIT_ROOT}/lib/_includes.sh"

function rust::install() {
  log::section "Setup Rust"

  if command -v cargo &> /dev/null; then
    echo "Skip"
    return
  fi

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  mkdir -p "${HOME}/.cargo"
  ln -s "${GIT_ROOT}/.cargo/config.toml" "${HOME}/.cargo/config.toml"
}
