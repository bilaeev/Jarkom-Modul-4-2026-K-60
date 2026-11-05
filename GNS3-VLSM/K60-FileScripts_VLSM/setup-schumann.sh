#!/bin/sh
set -eu
# K-60 Modul 4 - router schumann
sysctl -w net.ipv4.ip_forward=1
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.16.36/29 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 192.241.16.41/29 dev eth1
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 192.241.16.69/30 dev eth2
ip route replace default via 192.241.16.33
ip route replace 192.241.4.0/22 via 192.241.16.70 dev eth2
echo "OK: schumann"
ip -br -4 addr
ip -4 route
