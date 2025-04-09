#!/usr/bin/env bash

source ./helper.sh

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
  fish -c "fisher install jorgebucaran/fisher"
  fish -c "fisher install jethrokuan/z"
  # link fish config
  mkdir -p ~/.config/fish
  ln -sf "$(realpath .config/fish/config.fish)" ~/.config/fish/config.fish
  ln -sf "$(realpath .config/fish/fish_plugins)" ~/.config/fish/fish_plugins
  ln -sf "$(realpath .config/fish/func)" ~/.config/fish/func

  ENV_FISH_FILE="${HOME}/.env.fish"

  if [ ! -e "${ENV_FISH_FILE}" ]; then
    # init env
    touch "${ENV_FISH_FILE}"
    echo 'fish_add_path $HOME/.cargo/bin' >> "${ENV_FISH_FILE}"

    echo 'fish_add_path $HOME/go/bin' >> "${ENV_FISH_FILE}"
    echo 'fish_add_path /usr/local/go/bin' >> "${ENV_FISH_FILE}"
  fi

  sudo sed -i 's/auth\s\+required\s\+pam_shells.so/auth sufficient pam_shells.so/g' /etc/pam.d/chsh
  chsh -s "$(which fish)"
}
