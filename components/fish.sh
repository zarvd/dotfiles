#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

source "${GIT_ROOT}/lib/_includes.sh"

function fish::install() {
  log::section "Setup Fish"

  if command -v fish &> /dev/null; then
    echo "Skip"
    return
  fi

  fish::install-by-apt
  fish::setup-fisher
  fish::setup-config
  fish::setup-env
  fish::set-default-shell
}

function fish::install-by-apt() {
  sudo apt-add-repository -y ppa:fish-shell/release-3
  sudo apt update
  sudo apt install -y fish
}

function fish::setup-fisher() {
  fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source"
  fish -c "fisher install jorgebucaran/fisher"
  fish -c "fisher install jethrokuan/z"
}

function fish::setup-config() {
  mkdir -p ~/.config/fish
  ln -sf "${GIT_ROOT}/.config/fish/config.fish" ~/.config/fish/config.fish
  ln -sf "${GIT_ROOT}/.config/fish/fish_plugins" ~/.config/fish/fish_plugins
  ln -sf "${GIT_ROOT}/.config/fish/func" ~/.config/fish/func
}

function fish::setup-env() {
  local -r env_fish_file="${HOME}/.env.fish"

  if [[ ! -e "${env_fish_file}" ]]; then
    # init env
    touch "${env_fish_file}"
    echo 'fish_add_path $HOME/.cargo/bin' >> "${env_fish_file}"

    echo 'fish_add_path $HOME/go/bin' >> "${env_fish_file}"
    echo 'fish_add_path /usr/local/go/bin' >> "${env_fish_file}"
  fi
}

function fish::set-default-shell() {
  sudo sed -i 's/auth\s\+required\s\+pam_shells.so/auth sufficient pam_shells.so/g' /etc/pam.d/chsh
  chsh -s "$(which fish)"
}
