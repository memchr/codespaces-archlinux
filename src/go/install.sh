#!/usr/bin/env bash

set -e
user_name="${user_name:-$_CONTAINER_USER}"
packages=(
	go
	go-tools
	gopls
	delve
	revive
	staticcheck
)

##################
# Install and configure the required packages.
# globals:
# 	packages[]
##################
install_packages() {
	pacman -Syu --needed --ask 4 --noconfirm "${packages[@]}"
	ln -sf /usr/bin/revive /usr/bin/golint
}

install_packages