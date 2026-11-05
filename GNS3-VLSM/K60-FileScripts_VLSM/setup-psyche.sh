#!/bin/sh
set -eu
# K-60 Modul 4 - router psyche
sysctl -w net.ipv4.ip_forward=1
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.16.34/29 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 192.241.0.1/22 dev eth1
ip route replace default via 192.241.16.33
echo "OK: psyche"
ip -br -4 addr
ip -4 route
