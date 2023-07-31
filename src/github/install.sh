#!/usr/bin/env bash

set -e
user_name="${user_name:-$_CONTAINER_USER}"
use_act="$USEACT"
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

install_act() {
	[[ $(id -u) == 0 ]] && { echo "$0 should not be run as root"; return 1; }
	pushd /tmp
	git clone --depth 1 https://aur.archlinux.org/act-bin.git
	cd act-bin
	makepkg -si --noconfirm
	rm -rf act-bin
	popd

}

if [[ $(id -u) == 0 ]]; then
	install_packages
	su -c 'bash install.sh' "$user_name"
else
	if [[ $use_act == true ]]; then
		install_act
	fi
fi