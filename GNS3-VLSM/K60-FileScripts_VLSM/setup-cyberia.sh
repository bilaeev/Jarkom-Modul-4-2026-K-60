#!/bin/sh
set -eu
# K-60 Modul 4 - router cyberia
sysctl -w net.ipv4.ip_forward=1
ip link set eth0 up
if command -v dhclient >/dev/null 2>&1; then dhclient -1 eth0 || true; fi
ip link set eth1 up
ip -4 addr flush dev eth1
ip addr add 192.241.16.57/30 dev eth1
ip link set eth2 up
ip -4 addr flush dev eth2
ip addr add 192.241.14.1/25 dev eth2
iptables -t nat -C POSTROUTING -s 192.241.0.0/19 -o eth0 -j MASQUERADE 2>/dev/null || iptables -t nat -A POSTROUTING -s 192.241.0.0/19 -o eth0 -j MASQUERADE
ip route replace 192.241.0.0/19 via 192.241.16.58 dev eth1
echo "OK: cyberia"
ip -br -4 addr
ip -4 route
