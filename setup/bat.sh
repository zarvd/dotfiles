#!/usr/bin/env bash

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CUR_DIR/helper.sh"

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
