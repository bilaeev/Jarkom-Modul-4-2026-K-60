#!/bin/sh
set -eu
# K-60 Modul 4 - host taro
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.15.2/26 dev eth0
ip route replace default via 192.241.15.1 dev eth0
echo "OK: taro"
ip -br -4 addr
ip -4 route
