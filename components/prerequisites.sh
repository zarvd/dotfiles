#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

source "${GIT_ROOT}/lib/_includes.sh"

function prerequisites::install() {
  log::section "Install Prerequisites"

  jq::install
  yq::install

  case "$(uname)" in
    Darwin)
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      brew install htop
      ;;
    Linux)
      sudo apt update
      sudo apt install -y build-essential make htop
      ;;
    *)
      echo "Unsupported OS"
      exit 1
      ;;
  esac
}

function jq::install() {
  if command -v jq &> /dev/null; then
    return
  fi

  echo "Installing jq"

  local -r version="1.8.1"
  local url
  case "$(uname)" in
    Darwin)
      url="https://github.com/jqlang/jq/releases/download/jq-${version}/jq-macos-arm64"
      ;;
    Linux)
      url="https://github.com/jqlang/jq/releases/download/jq-${version}/jq-linux-amd64"
      ;;
    *)
      echo "Unsupported OS"
      exit 1
      ;;
  esac

  download_binary "jq" "${version}" "${url}"
}

function yq::install() {
  if command -v yq &> /dev/null; then
    return
  fi

  echo "Installing yq"

  local -r version="4.47.2"
  local url
  case "$(uname)" in
    Darwin)
      url="https://github.com/mikefarah/yq/releases/download/v${version}/yq_darwin_amd64"
      ;;
    Linux)
      url="https://github.com/mikefarah/yq/releases/download/v${version}/yq_linux_amd64"
      ;;
    *)
      echo "Unsupported OS"
      exit 1
      ;;
  esac
  readonly url

  download_binary "yq" "${version}" "${url}"
}
