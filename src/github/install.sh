#!/usr/bin/env bash

set -e
user_name=${user_name:-$_CONTAINER_USER}
packages=(
	github-cli
)

##################
# Install and configure the required packages.
# globals:
# 	packages[]
##################
install_packages() {
	pacman -Syu --needed --ask 4 --noconfirm "${packages[@]}"
}

install_packages