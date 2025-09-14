#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

source "${GIT_ROOT}/lib/_includes.sh"

function setup_vim() {
  print_section "Setup Vim"

  sudo apt update
  sudo apt install -y neovim

  mkdir -p "${HOME}/.config/nvim"

  if [ -e "${HOME}/.ideavimrc" ]; then
    rm "${HOME}/.ideavimrc"
  fi
  if [ -e "${HOME}/.config/nvim/init.vim" ]; then
    rm "${HOME}/.config/nvim/init.vim"
  fi

  ln -s "${GIT_ROOT}/.config/nvim/init.vim" "${HOME}/.config/nvim/init.vim"
  ln -s "${GIT_ROOT}/.ideavimrc" "${HOME}/.ideavimrc"
}
