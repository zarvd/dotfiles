#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)

source "$GIT_ROOT/setup/pre.sh"
source "$GIT_ROOT/setup/fish.sh"
source "$GIT_ROOT/setup/git.sh"
source "$GIT_ROOT/setup/rust.sh"
source "$GIT_ROOT/setup/golang.sh"
source "$GIT_ROOT/setup/docker.sh"
source "$GIT_ROOT/setup/vim.sh"
source "$GIT_ROOT/setup/bat.sh"
source "$GIT_ROOT/setup/utilities.sh"


