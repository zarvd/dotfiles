#!/usr/bin/env bash

set -x

function print_section() {
  set +x
  SECTION=$1
  BLUE='\033[0;34m'
  NC='\033[0m' # No Color
  echo -e "${BLUE}======================================${NC}"
  echo -e "${BLUE}${SECTION}${NC}"
  echo -e "${BLUE}======================================${NC}"
  set -x
}

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
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
  fisher install jorgebucaran/fisher
  fisher install jethrokuan/z
  # link fish config
  mkdir -p ~/.config/fish
  ln -sf "$(realpath .config/fish/config.fish)" ~/.config/fish/config.fish
  ln -sf "$(realpath .config/fish/fish_plugins)" ~/.config/fish/fish_plugins

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

function setup_rust() {
  print_section "Setup Rust"

  if command -v cargo &> /dev/null; then
    echo "Skip"
    return
  fi

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  mkdir -p "${HOME}/.cargo"
  ln -s "$(realpath .cargo/config.toml)" "${HOME}/.cargo/config.toml"
}

function setup_golang() {
  print_section "Setup Golang"

  if command -v go &> /dev/null; then
    echo "Skip"
    return
  fi

  VERSION="1.24.0"
  URL="https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz"
  DIR="${HOME}/downloads"

  mkdir "${DIR}"
  pushd "${DIR}"
  wget "${URL}"

  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf go${VERSION}.linux-amd64.tar.gz
  popd
}

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

function setup_vim() {
  print_section "Setup IdeaVim"

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

function setup_docker() {
  print_section "Setup Docker"

  if command -v docker &> /dev/null; then
    echo "Skip"
    return
  fi

  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  sudo usermod -aG docker "${USER}"
}

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

function install_utilities() {
  print_section "Install Utilities"

  sudo apt update
  sudo apt install -y build-essential make jq
  cargo install bat fd-find git-delta just lsd ripgrep tealdeer tokei --locked --force
}

export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:/usr/local/go/bin

setup_git
setup_rust
setup_golang
setup_fish
setup_bat
setup_vim
setup_docker
install_utilities
