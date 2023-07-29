#!/usr/bin/env bash
sudo /usr/bin/sshd -D &
disown

exec "$@"