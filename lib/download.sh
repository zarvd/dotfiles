#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

function download_binary() {
  local name=$1
  local version=$2
  local url=$3

  local dir="${GIT_ROOT}/downloads/${name}-${version}"
  mkdir -p "${dir}"

  if [ -f "${dir}/${name}" ]; then
    return
  fi

  curl -L -o "${dir}/${name}" "${url}"
  chmod +x "${dir}/${name}"
  sudo mv "${dir}/${name}" "/usr/local/bin/${name}"
}
