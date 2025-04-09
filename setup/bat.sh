#!/usr/bin/env bash

source ./helper.sh

function setup_bat() {
  print_section "Setup Bat"

  DIR="${HOME}/.config/bat"

  if [ -e "${DIR}/config" ]; then
    echo "Skip"
    return
  fi

  mkdir -p "${DIR}"
  ln -s "$(realpath .config/bat/config)" "${DIR}/config"
}
