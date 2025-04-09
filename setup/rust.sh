#!/usr/bin/env bash

source "setup/helper.sh"

function setup_rust() {
  print_section "Setup Rust"

  if command -v cargo &> /dev/null; then
    echo "Skip"
    return
  fi

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  mkdir -p "${HOME}/.cargo"
  ln -s "$(realpath .cargo/config.toml)" "${HOME}/.cargo/config.toml"
}
