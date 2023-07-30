#!/usr/bin/env bash

set -e
user_name=${user_name:-$_CONTAINER_USER}


install_paru() {
	pushd /tmp
	git clone --depth 1 https://aur.archlinux.org/paru-bin.git
	cd paru-bin
	makepkg -si --noconfirm
	popd
	rm -rf paru-bin
}

if [[ $(id -u) == 0 ]]; then
	# root
	su -c 'bash install.sh' $user_name
else
	# regular user
	install_paru
fi