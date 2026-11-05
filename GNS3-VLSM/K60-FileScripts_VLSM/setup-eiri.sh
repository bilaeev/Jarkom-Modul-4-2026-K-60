#!/bin/sh
set -eu
# K-60 Modul 4 - host eiri
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.16.50/29 dev eth0
ip route replace default via 192.241.16.49 dev eth0
echo "OK: eiri"
ip -br -4 addr
ip -4 route
