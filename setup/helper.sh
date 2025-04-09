#!/usr/bin/env bash

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
