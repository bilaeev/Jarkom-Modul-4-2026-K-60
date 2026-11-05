#!/bin/sh
set -eu
# K-60 Modul 4 - router navi
sysctl -w net.ipv4.ip_forward=1
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.16.62/30 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 192.241.12.1/24 dev eth1
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 192.241.15.1/26 dev eth2
ip link set eth3 up
ip -4 addr flush dev eth3
ip addr add 192.241.13.1/24 dev eth3
ip route replace default via 192.241.16.61
echo "OK: navi"
ip -br -4 addr
ip -4 route
