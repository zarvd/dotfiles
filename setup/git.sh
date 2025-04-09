#!/usr/bin/env bash

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CUR_DIR/helper.sh"

function setup_git() {
  print_section "Setup Git"

  DIR="${HOME}/.config/git"
  if [ -e "${DIR}/config" ]; then
    echo "Skip"
    return
  fi

  mkdir -p "${DIR}"
  ln -s "$(realpath .config/git/config)" "${DIR}/config"

  CFG="${HOME}/.gitconfig"
  touch "${CFG}"
  cat > "${CFG}" <<EOL

[include]
  path = ~/.config/git/config
EOL
}
