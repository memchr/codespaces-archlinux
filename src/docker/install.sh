#!/usr/bin/env bash

set -e
user_name="${user_name:-$_CONTAINER_USER}"
packages=(
	docker
	docker-buildx
)

##################
# Install and configure the required packages.
# globals:
# 	packages[]
##################
install_packages() {
	pacman -Syu --needed --ask 4 --noconfirm "${packages[@]}"
}

init_docker() {
	if ! grep -e "^docker:" /etc/group > /dev/null 2>&1; then
		groupadd -r docker
	fi
	usermod -aG docker "${user_name}"
	cp init-docker.sh /usr/local/lib/init-docker.sh
	chmod +x /usr/local/lib/init-docker.sh
}

install_packages
init_docker