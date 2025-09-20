#!/usr/bin/env bash

function log::section() {
  local -r COLOR_BLUE='\033[0;34m'
  local -r COLOR_NC='\033[0m' # No Color

  local -r section=$1

  set +x
  echo -e "${COLOR_BLUE}======================================${COLOR_NC}"
  echo -e "${COLOR_BLUE}${section}${COLOR_NC}"
  echo -e "${COLOR_BLUE}======================================${COLOR_NC}"
  set -x
}
