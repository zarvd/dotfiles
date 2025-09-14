#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

source "${GIT_ROOT}/lib/_includes.sh"

function setup_golang() {
  print_section "Setup Golang"

  # Get the latest Go version from the official API
  local version=$(curl -s https://go.dev/dl/?mode=json | jq -r '.[0].version' | sed 's/go//')

  if command -v go &> /dev/null; then
    # Check if the installed version is the latest
    local installed_version=$(go version | awk '{print $3}' | sed 's/go//')
    
    # Compare versions
    if [ "$installed_version" = "$version" ]; then
      echo "Go is already at the latest version ($version)"
      return
    elif [ -n "$installed_version" ]; then
      echo "Updating Go from version $installed_version to $version"
    fi
  fi

  echo "Installing Go version $version"
  
  local url="https://go.dev/dl/go${version}.linux-amd64.tar.gz"
  local dir="${HOME}/downloads"

  mkdir -p "${dir}"
  pushd "${dir}"
  wget "${url}"

  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf go${version}.linux-amd64.tar.gz
  popd
}
