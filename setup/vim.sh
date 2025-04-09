#!/usr/bin/env bash

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CUR_DIR/helper.sh"

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

  ln -s "$(realpath .config/nvim/init.vim)" "${HOME}/.config/nvim/init.vim"
  ln -s "$(realpath .ideavimrc)" "${HOME}/.ideavimrc"
}
