#!/usr/bin/env bash

set -e
user_name="${user_name:-$_CONTAINER_USER}"
packages=(
	python
	python-pip
	python-pipx
	ipython
	ruff
	memray
	yapf
	python-black
	autopep8
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