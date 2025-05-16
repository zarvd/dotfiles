#!/usr/bin/env bash

source "setup/helper.sh"

function setup_golang() {
  print_section "Setup Golang"

  # Get the latest Go version from the official API
  VERSION=$(curl -s https://go.dev/dl/?mode=json | jq -r '.[0].version' | sed 's/go//')

  if command -v go &> /dev/null; then
    # Check if the installed version is the latest
    INSTALLED_VERSION=$(go version | awk '{print $3}' | sed 's/go//')
    
    # Compare versions
    if [ "$INSTALLED_VERSION" = "$VERSION" ]; then
      echo "Go is already at the latest version ($VERSION)"
      return
    elif [ -n "$INSTALLED_VERSION" ]; then
      echo "Updating Go from version $INSTALLED_VERSION to $VERSION"
    fi
  fi

  echo "Installing Go version $VERSION"
  
  URL="https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz"
  DIR="${HOME}/downloads"

  mkdir -p "${DIR}"
  pushd "${DIR}"
  wget "${URL}"

  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf go${VERSION}.linux-amd64.tar.gz
  popd
}
