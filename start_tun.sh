#! /bin/bash

if [ "$#" -ne 4 ]; then
	printf 'usage:\n\t./start_tunnel.sh <gateway> <interface> <proxy-ip> <proxy-port>\n'
	printf 'gateway: 192.168.10.2\n\ninterface: eth0\nproxy-ip: 192.168.10.153\nproxy-port:1080\n'
	exit
fi
mv /etc/resolv.conf /etc/resolv.conf.bak
ip route save > route.bak
printf 'nameserver 8.8.8.8\noptions use-vc\n' > /etc/resolv.conf
ip route flush all
tun2socks -proxy "socks5://$3:$4" -device tun0 -interface "$2" &
ip link set dev tun0 up
ip addr add 10.0.0.1 dev tun0
ip route add default via 10.0.0.1 dev tun0
ip route add $1 dev $2
ip route add $3 via $1


