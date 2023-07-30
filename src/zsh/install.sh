#!/usr/bin/env bash

set -e

set_default_shell=${CHSH}
user_name="${user_name:-$_CONTAINER_USER}"

packages=(
	zsh
	zsh-completions
)

##################
# Install and configure the required packages.
# globals:
# 	packages[]
##################

install_packages() {
	pacman -Syu --needed --ask 4 --noconfirm "${packages[@]}"
}

##################
# change user shell to zsh
# globals:
# 	user_name: user name
#	set_default_shell: if "true", change user default shell to zsh
##################
chsh_zsh() {
	if [[ $set_default_shell == true ]]; then
		usermod -s /bin/zsh "$user_name"
	fi
}

##################
# configure zsh
# globals:
#	user_name
# unprivileged
##################
#shellcheck disable=SC2016
init_zsh() {
	[[ $(id -u) == 0 ]] && { echo "$0 should not be run as root"; return 1; }
	install -Dm644 zshenv "$HOME/.zshenv"
	install -Dm644 zshrc "/home/$user_name/.zshrc"
	mkdir -p "$HOME/.zshenv.d"
}

if [[ $(id -u) == 0 ]]; then
	install_packages
	chsh_zsh
	su -c 'bash install.sh' "$user_name"
else
	init_zsh
fi