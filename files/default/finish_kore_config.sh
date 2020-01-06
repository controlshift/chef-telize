#!/usr/bin/env bash

set -e
set -x

NET_IF=$(ip link | awk -F: '$0 !~ "lo|docker|tun|^[^0-9]"{print $2;getline}')
PRIVATE_IP=$(ifconfig $NET_IF 2>/dev/null | awk '/inet / {print $2}' | sed 's/addr://')

sed -i -e "s%127.0.0.1%$PRIVATE_IP%" /srv/telize/telize.config

service kore start
