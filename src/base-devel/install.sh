#!/usr/bin/env bash

set -e
user_name="${user_name:-$_CONTAINER_USER}"
packages=(
	gdb
	strace
	ltrace
	cmake
	meson
	ninja
	patch
	patchelf
	perf
	valgrind
	debuginfod
	shfmt
	shellcheck
	typos
	valgrind
	nasm
	ccache
)

##################
# Install and configure the required packages.
# globals:
# 	packages[]
##################
install_packages() {
	pacman -Syu --needed --ask 4 --noconfirm "${packages[@]}"
}

## Setup ccache
init_ccache() {
	su -s /usr/bin/bash -c 'mkdir -p ~/.config/ccache' "$user_name"
	install -o "$user_name" -g "$user_name" -Dm644 ccache.conf "/home/$user_name/.config/ccache"
	install -Dm644 ccache.sh /etc/profile.d/ccache.sh
}

install_packages
init_ccache
