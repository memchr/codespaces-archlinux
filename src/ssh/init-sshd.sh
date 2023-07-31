#!/usr/bin/env bash
if [[ $(id -u) != 0 ]]; then
	sudo /usr/bin/sshd -D &
else
	/usr/bin/sshd -D &
fi
disown

exec "$@"