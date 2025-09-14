#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

source "${GIT_ROOT}/lib/_includes.sh"

function setup_fish() {
  print_section "Setup Fish"

  if command -v fish &> /dev/null; then
    echo "Skip"
    return
  fi

  sudo apt-add-repository -y ppa:fish-shell/release-3
  sudo apt update
  sudo apt install -y fish

  # install fisher and plugin
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | fish -c source
  #fish -c "fisher install jorgebucaran/fisher"
  #fish -c "fisher install jethrokuan/z"
  # link fish config
  mkdir -p ~/.config/fish
  ln -sf "${GIT_ROOT}/.config/fish/config.fish" ~/.config/fish/config.fish
  ln -sf "${GIT_ROOT}/.config/fish/fish_plugins" ~/.config/fish/fish_plugins
  ln -sf "${GIT_ROOT}/.config/fish/func" ~/.config/fish/func

  local env_fish_file="${HOME}/.env.fish"

  if [ ! -e "${env_fish_file}" ]; then
    # init env
    touch "${env_fish_file}"
    echo 'fish_add_path $HOME/.cargo/bin' >> "${env_fish_file}"

    echo 'fish_add_path $HOME/go/bin' >> "${env_fish_file}"
    echo 'fish_add_path /usr/local/go/bin' >> "${env_fish_file}"
  fi

  sudo sed -i 's/auth\s\+required\s\+pam_shells.so/auth sufficient pam_shells.so/g' /etc/pam.d/chsh
  chsh -s "$(which fish)"
}
