#!/usr/bin/env bash

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CUR_DIR/helper.sh"

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
