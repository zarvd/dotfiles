#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

source "${GIT_ROOT}/lib/_includes.sh"

function setup_git() {
  print_section "Setup Git"

  local dir="${HOME}/.config/git"
  if [ -e "${dir}/config" ]; then
    echo "Skip"
    return
  fi

  mkdir -p "${dir}"
  ln -s "${GIT_ROOT}/.config/git/config" "${dir}/config"

  local cfg="${HOME}/.gitconfig"
  touch "${cfg}"
  cat > "${cfg}" <<EOL

[include]
  path = ~/.config/git/config
EOL
}
