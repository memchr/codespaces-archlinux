#!/usr/bin/env bash
#shellcheck disable=SC2164
 
if [[ $(id -u) != 0 ]]; then
	srcpath="$(realpath "$0")"
	exec sudo bash "$srcpath" "$@"
fi

cat > /tmp/mkswap.sh << 'EOF'
dd if=/dev/zero bs=1M of=/tmp/swapfile count=2K oflag=sync
chmod 644 /tmp/swapfile
mkswap /tmp/swapfile
swapon /tmp/swapfile
EOF

bash /tmp/mkswap.sh & disown

exec "$@"