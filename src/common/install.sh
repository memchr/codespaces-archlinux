#!/usr/bin/env bash

set -e

user_name=${USERNAME}
user_uid=${USERUID}
user_gid=${USERGID}

packages=(
	# networking
	iproute2
	bind
	dog
	curl
	httping
	iptables-nft
	nftables
	socat
	tcpdump
	# stream processing
	ripgrep
	fd
	bat
	jq
	fzf
	go-yq
	pv
	# system
	gdu
	sudo
	htop
	duf
	dust
	lf
	rsync
	time
	# shell
	grc
	bash-completion
	# text editor
	neovim
)

##################
# Install and configure the required packages.
# globals:
# 	packages[]
##################

install_packages() {
	pacman -Syu --needed --ask 4 --noconfirm "${packages[@]}"
	ln -sf /usr/bin/nvim /usr/bin/vi
	echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' >  /etc/sudoers.d/wheel_users
}

##################
# Create non-root user 
# globals:
# 	user_name
#	user_uid
#	user_gid
##################
create_user() {
	# create user
	local _group_name="${user_name}"
	if id -u "${user_name}" &> /dev/null; then
		# User exists
		if [[ "$user_gid" != "$(id -g "$user_name")" ]]; then
			groupmod --gid "$user_gid" "$_group_name"
			usermod --gid "$user_gid" "$user_name"
		fi
		if [[ "$user_uid" != "$(id -u "$user_name")" ]]; then
			usermod --uid "$user_uid" "$user_name"
		fi
	else
		# Create user
		groupadd --gid "$user_gid" "$user_name"
		useradd --uid "$user_uid" --gid "$user_name" -m "$user_name"
		# Add user to wheel group (sudo privilege)
		usermod -aG wheel "$user_name"
	fi
}

init_system_profile() {
	install -Dm644 '00-profile.sh' /etc/profile.d
}

#shellcheck disable=SC2016
init_user_profile() {
	# bash
	install -Dm644 -o "$user_name" -g "$user_name" bashrc "/home/$user_name/.bashrc"
}

install_packages
create_user
init_system_profile
init_user_profile