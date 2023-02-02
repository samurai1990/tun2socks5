#! /bin/bash
kill -9 $(pidof tun2socks)
ip route flush all
mv /etc/resolv.conf.bak /etc/resolv.conf
ip route restore < route.bak
rm -f route.bak
