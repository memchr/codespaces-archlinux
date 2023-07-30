#!/usr/bin/env bash

set -e
user_name="${user_name:-$_CONTAINER_USER}"
packages=(
	openssh
)

##################
# Install and configure the required packages.
# globals:
# 	packages[]
##################
install_packages() {
	pacman -Syu --needed --ask 4 --noconfirm "${packages[@]}"
}

## generate random password for user
init_passwd() {
	_passwd="$(openssl rand -hex 16)"
	cho "${user_name}:${_passwd}" | chpasswd
}

init_sshd() {
	ssh-keygen -A
	cp init-sshd.sh /usr/local/lib
	chmod +x /usr/local/lib/init-sshd.sh
}

install_packages
init_passwd
init_sshd