#!/usr/bin/env bash

set -e
user_name="${user_name:-$_CONTAINER_USER}"
packages=(
	nodejs
	npm
	pnpm
	prettier
	wasmtime
)

##################
# Install and configure the required packages.
# globals:
# 	packages[]
##################
install_packages() {
	pacman -Syu --needed --ask 4 --noconfirm "${packages[@]}"
}

config_npm() {
	sed -i "s/__user_name__/$user_name/g" npm.conf
	install -o "$user_name" -g "$user_name" -Dm644 npm.conf "/home/$user_name/.npmrc"
}

config_pnpm() {
	sed -i "s/__user_name__/$user_name/g" pnpm.conf
	su -s /usr/bin/bash -c 'mkdir -p ~/.config/pnpm' "$user_name"
	install -o "$user_name" -g "$user_name" -Dm644 pnpm.conf "/home/$user_name/.config/pnpm/rc"
}

install_packages
config_npm
config_pnpm