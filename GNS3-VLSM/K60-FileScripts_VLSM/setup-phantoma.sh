#!/bin/sh
set -eu
# K-60 Modul 4 - router phantoma
sysctl -w net.ipv4.ip_forward=1
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.16.86/30 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 192.241.16.1/27 dev eth1
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 192.241.16.89/30 dev eth2
ip route replace default via 192.241.16.85
ip route replace 192.241.15.192/26 via 192.241.16.90 dev eth2
echo "OK: phantoma"
ip -br -4 addr
ip -4 route
