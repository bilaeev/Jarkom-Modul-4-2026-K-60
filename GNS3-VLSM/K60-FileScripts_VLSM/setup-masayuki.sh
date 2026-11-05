#!/bin/sh
set -eu
# K-60 Modul 4 - host masayuki
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.8.2/23 dev eth0
ip route replace default via 192.241.8.1 dev eth0
echo "OK: masayuki"
ip -br -4 addr
ip -4 route
