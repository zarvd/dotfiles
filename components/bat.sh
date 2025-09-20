#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

source "${GIT_ROOT}/lib/_includes.sh"

function bat::setup() {
  log::section "Setup Bat"

  local -r dir="${HOME}/.config/bat"

  if [[ -e "${dir}/config" ]]; then
    echo "Skip"
    return
  fi

  mkdir -p "${dir}"
  ln -s "${GIT_ROOT}/.config/bat/config" "${dir}/config"
}
