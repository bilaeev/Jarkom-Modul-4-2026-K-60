#!/bin/sh
set -eu
# K-60 Modul 4 - host lain
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.15.194/26 dev eth0
ip route replace default via 192.241.15.193 dev eth0
echo "OK: lain"
ip -br -4 addr
ip -4 route
