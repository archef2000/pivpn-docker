FROM alpine AS builder
RUN apk add git ca-certificates > /dev/null 2>/dev/null
RUN git clone https://github.com/pivpn/pivpn.git /clone

FROM debian:stable-slim

RUN adduser --home /home/pivpn --disabled-password pivpn \
    && echo "deb http://deb.debian.org/debian buster-backports main non-free" >> /etc/apt/sources.list \
    && apt-get update && apt-get install -y -f --no-install-recommends wireguard-tools qrencode gnupg \
    openvpn grepcidr expect curl nano sudo bsdmainutils bash-completion cron ca-certificates iproute2 \
    net-tools iptables-persistent apt-transport-https whiptail dnsutils grep dhcpcd5 iptables-persistent

WORKDIR /home/pivpn
COPY sh/ /usr/local/bin/
COPY crontab /etc/cron.d/update
COPY  --from=builder /clone /usr/local/src/pivpn
COPY run .
    
RUN chmod 0644 /etc/cron.d/update && crontab /etc/cron.d/update \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /etc/pivpn/openvpn/* /etc/openvpn/* /etc/wireguard/* /tmp/* || true \
    && chmod +x /home/pivpn/run /usr/local/bin/*

ENTRYPOINT ["./run"]
