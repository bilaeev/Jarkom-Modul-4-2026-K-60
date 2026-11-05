#!/bin/sh
set -eu
# K-60 Modul 4 - router knights
sysctl -w net.ipv4.ip_forward=1
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.16.82/30 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 192.241.16.49/29 dev eth1
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 192.241.16.85/30 dev eth2
ip route replace default via 192.241.16.81
ip route replace 192.241.15.192/26 via 192.241.16.86 dev eth2
ip route replace 192.241.16.0/27 via 192.241.16.86 dev eth2
ip route replace 192.241.16.88/30 via 192.241.16.86 dev eth2
echo "OK: knights"
ip -br -4 addr
ip -4 route
