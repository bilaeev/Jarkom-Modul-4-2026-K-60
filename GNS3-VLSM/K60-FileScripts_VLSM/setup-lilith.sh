#!/bin/sh
set -eu
# K-60 Modul 4 - host lilith
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.14.130/25 dev eth0
ip route replace default via 192.241.14.129 dev eth0
echo "OK: lilith"
ip -br -4 addr
ip -4 route
