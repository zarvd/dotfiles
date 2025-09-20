#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

source "${GIT_ROOT}/lib/_includes.sh"

function git::setup() {
  log::section "Setup Git"

  local -r dir="${HOME}/.config/git"
  if [[ -e "${dir}/config" ]]; then
    echo "Skip"
    return
  fi

  mkdir -p "${dir}"
  ln -s "${GIT_ROOT}/.config/git/config" "${dir}/config"

  local -r config_file="${HOME}/.gitconfig"
  touch "${config_file}"
  cat > "${config_file}" <<EOL

[include]
  path = ~/.config/git/config
EOL
}
