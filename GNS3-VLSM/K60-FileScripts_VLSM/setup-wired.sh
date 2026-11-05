#!/bin/sh
set -eu
# K-60 Modul 4 - router wired
sysctl -w net.ipv4.ip_forward=1
ip link set eth0 up
ip -4 addr flush dev eth0
ip addr add 192.241.16.58/30 dev eth0
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 192.241.16.61/30 dev eth1
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 192.241.16.65/30 dev eth2
ip link set eth3 up
ip -4 addr flush dev eth3
ip addr add 192.241.16.33/29 dev eth3
ip route replace default via 192.241.16.57
ip route replace 192.241.0.0/22 via 192.241.16.34 dev eth3
ip route replace 192.241.4.0/22 via 192.241.16.36 dev eth3
ip route replace 192.241.8.0/23 via 192.241.16.35 dev eth3
ip route replace 192.241.10.0/23 via 192.241.16.66 dev eth2
ip route replace 192.241.12.0/23 via 192.241.16.62 dev eth1
ip route replace 192.241.14.128/25 via 192.241.16.66 dev eth2
ip route replace 192.241.15.0/26 via 192.241.16.62 dev eth1
ip route replace 192.241.15.64/26 via 192.241.16.35 dev eth3
ip route replace 192.241.15.128/25 via 192.241.16.66 dev eth2
ip route replace 192.241.16.0/27 via 192.241.16.66 dev eth2
ip route replace 192.241.16.40/29 via 192.241.16.36 dev eth3
ip route replace 192.241.16.48/29 via 192.241.16.66 dev eth2
ip route replace 192.241.16.68/30 via 192.241.16.36 dev eth3
ip route replace 192.241.16.72/29 via 192.241.16.66 dev eth2
ip route replace 192.241.16.80/28 via 192.241.16.66 dev eth2
echo "OK: wired"
ip -br -4 addr
ip -4 route
