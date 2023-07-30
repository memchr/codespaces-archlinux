#!/usr/bin/env bash

set -e

packages=(
	clang
	llvm
	lldb
	lld
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

