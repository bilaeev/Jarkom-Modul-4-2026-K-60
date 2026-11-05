#!/bin/sh
set -eu
# K-60 Modul 4 - router accela
sysctl -w net.ipv4.ip_forward=1
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.16.70/30 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 192.241.4.1/22 dev eth1
ip route replace default via 192.241.16.69
echo "OK: accela"
ip -br -4 addr
ip -4 route
