#!/bin/sh
set -eu
# K-60 Modul 4 - router protocol7
sysctl -w net.ipv4.ip_forward=1
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.16.78/30 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 192.241.15.129/26 dev eth1
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 192.241.16.81/30 dev eth2
ip route replace default via 192.241.16.77
ip route replace 192.241.15.192/26 via 192.241.16.82 dev eth2
ip route replace 192.241.16.0/27 via 192.241.16.82 dev eth2
ip route replace 192.241.16.48/29 via 192.241.16.82 dev eth2
ip route replace 192.241.16.84/30 via 192.241.16.82 dev eth2
ip route replace 192.241.16.88/30 via 192.241.16.82 dev eth2
echo "OK: protocol7"
ip -br -4 addr
ip -4 route
