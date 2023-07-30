#!/usr/bin/env bash

set -e
user_name="${user_name:-$_CONTAINER_USER}"


install_devcontainer_cli() {
	[[ $(id -u) == 0 ]] && { echo "$0 should not be run as root"; return 1; }
	pnpm install -g @devcontainers/cli
}

if [[ $(id -u) == 0 ]]; then
	# root
	su -c 'bash install.sh' "$user_name"
else
	# regular user
	install_devcontainer_cli
fi
