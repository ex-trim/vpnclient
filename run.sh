#!/bin/bash

# set user credentials
echo ': PSK "'$VPN_PSK'"' > /etc/ipsec.secrets
sed -i 's/right=.*/right='$VPN_SERVER_IP'/' /etc/ipsec.conf
sed -i 's/lns = .*/lns = '$VPN_SERVER_IP'/' /etc/xl2tpd/xl2tpd.conf
sed -i 's/name .*/name '$VPN_USERNAME'/' /etc/ppp/options.l2tpd.client
sed -i 's/password .*/password '$VPN_PASSWORD'/' /etc/ppp/options.l2tpd.client

# startup tunnel
ipsec start --nofork &

sleep 2

# startup ppp daemon
exec /usr/sbin/xl2tpd -c /etc/xl2tpd/xl2tpd.conf -p /var/run/xl2tpd.pid -D
