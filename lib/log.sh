#!/usr/bin/env bash

function print_section() {
  local section=$1
  local blue='\033[0;34m'
  local nc='\033[0m' # No Color

  set +x
  echo -e "${blue}======================================${nc}"
  echo -e "${blue}${section}${nc}"
  echo -e "${blue}======================================${nc}"
  set -x
}
