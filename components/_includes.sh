#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)
COMPONENTS_ROOT="${GIT_ROOT}/components"

source "$COMPONENTS_ROOT/prerequisites.sh"
source "$COMPONENTS_ROOT/fish.sh"
source "$COMPONENTS_ROOT/git.sh"
source "$COMPONENTS_ROOT/rust.sh"
source "$COMPONENTS_ROOT/golang.sh"
source "$COMPONENTS_ROOT/docker.sh"
source "$COMPONENTS_ROOT/vim.sh"
source "$COMPONENTS_ROOT/bat.sh"
source "$COMPONENTS_ROOT/utilities.sh"


