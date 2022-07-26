l2tp-ipsec-vpnclient
===
[![](https://images.microbadger.com/badges/image/ubergarm/l2tp-ipsec-vpn-client.svg)](https://microbadger.com/images/ubergarm/l2tp-ipsec-vpn-client) [![](https://images.microbadger.com/badges/version/ubergarm/l2tp-ipsec-vpn-client.svg)](https://microbadger.com/images/ubergarm/l2tp-ipsec-vpn-client) [![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/ubergarm/l2tp-ipsec-vpn-client/blob/master/LICENSE)

A tiny Debian based docker image to quickly setup an L2TP over IPsec VPN client w/ PSK.

## Motivation
Does your office or a client have a VPN server already setup and you
just need to connect to it? Do you use Linux and are jealous that the
one thing a MAC can do better is quickly setup this kind of VPN? Then
here is all you need:

1. VPN Server Address
2. Pre Shared Key
3. Username
4. Password

## Run
Setup environment variables for your credentials and config:

    export VPN_SERVER_IP='1.2.3.4'
    export VPN_PSK='pre shared key'
    export VPN_USERNAME='user@host.com'
    export VPN_PASSWORD='pass'

Now run it (you can daemonize of course after debugging):

    docker run --rm -it --privileged --net=host \
               -e VPN_SERVER_IP \
               -e VPN_PSK \
               -e VPN_USERNAME \
               -e VPN_PASSWORD \
                  extrim/vpnclient

## Route
From the host machine configure traffic to route through VPN link:

    # confirm the ppp0 link and get the peer e.g. (192.0.2.1) IPV4 address
    ip a show ppp0
    # route traffic for a specific target ip through VPN tunnel address
    sudo route add 1.2.3.4 via 192.0.2.1 dev ppp0
    # route all traffice through VPN tunnel address
    sudo route add default dev ppp0
    # when your done add your normal routes and delete the VPN routes
    # or just `docker stop` and you'll probably be okay

## Test
You can see if your IP address changes after adding appropriate routes e.g.:

    curl ifconfig.me

## TODO
- [ ] See if this can work without privileged and net=host modes to be more portable

## References
* [ubergarm/l2tp-ipsec-vpn-client](https://github.com/ubergarm/l2tp-ipsec-vpn-client)
* [Stanback/alpine-strongswan-vpn](https://github.com/Stanback/alpine-strongswan-vpn)
* [hwdsl2/docker-ipsec-vpn-server](https://github.com/hwdsl2/docker-ipsec-vpn-server)
* [wiki.debian.org](https://wiki.debian.org/ru/xl2tpd/Client)
