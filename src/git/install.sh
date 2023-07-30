#!/usr/bin/env bash

set -e
user_name="${user_name:-$_CONTAINER_USER}"
packages=(
	git
	onefetch
	tokei
)

##################
# Install and configure the required packages.
# globals:
# 	packages[]
##################
install_packages() {
	pacman -Syu --needed --ask 4 --noconfirm "${packages[@]}"
}

init_git() {
	su -s /usr/bin/bash -c 'git config pull.rebase false' "${user_name}"
}

install_packages

