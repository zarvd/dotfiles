#!/usr/bin/env bash

source "setup/helper.sh"

function install_pre() {
  print_section "Install Prerequisites"

  sudo apt update
  sudo apt install -y build-essential make jq yq htop
}
