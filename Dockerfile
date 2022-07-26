FROM debian:stable

RUN apt update && apt install -y \
	strongswan \
	xl2tpd \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /var/run/xl2tpd \
	&& touch /var/run/xl2tpd/l2tp-control
 
COPY ipsec.conf /etc
COPY xl2tpd.conf /etc/xl2tpd
COPY options.l2tpd.client /etc/ppp
COPY run.sh /

RUN chmod 755 /run.sh

CMD ["/run.sh"]
