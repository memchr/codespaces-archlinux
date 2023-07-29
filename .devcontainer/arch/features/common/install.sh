#!/usr/bin/env bash

set -e

user_name=${USERNAME}
user_uid=${USERUID}
user_gid=${USERGID}
user_shell=${CHSH}

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
	zsh
	grc
	zsh-completions
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
#	user_shell: default shell for user
##################
create_user() {
	# default shell
	if [[ -e "/bin/${user_shell}" ]]; then
		_shell="/bin/${user_shell}"
	else
		echo "shell $user_shell does not exist, revert to bash"
		_shell="/bin/bash"
	fi
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
		useradd -s "$_shell" --uid "$user_uid" --gid "$user_name" -m "$user_name"
		# Add user to wheel group (sudo privilege)
		usermod -aG wheel "$user_name"
		# touch blank zshrc to suppress the setup message
		su -s /bin/sh -c "touch ~/.zshrc" "$user_name" 
	fi
}

install_packages
create_user