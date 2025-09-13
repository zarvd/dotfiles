#!/usr/bin/env bash

function print_section() {
  local SECTION=$1
  local BLUE='\033[0;34m'
  local NC='\033[0m' # No Color

  set +x
  echo -e "${BLUE}======================================${NC}"
  echo -e "${BLUE}${SECTION}${NC}"
  echo -e "${BLUE}======================================${NC}"
  set -x
}
