#!/usr/bin/env bash

set -e

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

