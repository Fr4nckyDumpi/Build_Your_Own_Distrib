#!/bin/bash

apt-get install -y iptables

iptables -I INPUT 1 -p tcp --dport 22 -j ACCEPT
iptables -I INPUT 2 -p udp --dport 22 -j ACCEPT
iptables -I INPUT 3 -p tcp --dport 80 -j ACCEPT
iptables -I INPUT 4 -p udp --dport 80 -j ACCEPT
iptables -I INPUT 5 -j DROP
iptables -I FORWARD 1 -j DROP