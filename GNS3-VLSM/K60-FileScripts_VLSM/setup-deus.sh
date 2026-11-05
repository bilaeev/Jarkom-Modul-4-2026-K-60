#!/bin/sh
set -eu
# K-60 Modul 4 - router deus
sysctl -w net.ipv4.ip_forward=1
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.16.74/30 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 192.241.14.129/25 dev eth1
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 192.241.16.77/30 dev eth2
ip route replace default via 192.241.16.73
ip route replace 192.241.15.128/25 via 192.241.16.78 dev eth2
ip route replace 192.241.16.0/27 via 192.241.16.78 dev eth2
ip route replace 192.241.16.48/29 via 192.241.16.78 dev eth2
ip route replace 192.241.16.80/28 via 192.241.16.78 dev eth2
echo "OK: deus"
ip -br -4 addr
ip -4 route
