#!/bin/sh
set -eu
# K-60 Modul 4 - host denpa
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.4.3/22 dev eth0
ip route replace default via 192.241.4.1 dev eth0
echo "OK: denpa"
ip -br -4 addr
ip -4 route
