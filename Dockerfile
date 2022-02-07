FROM alpine AS builder
RUN apk add git ca-certificates > /dev/null 2>/dev/null
RUN git clone https://github.com/pivpn/pivpn.git /clone

FROM debian:stretch-20211011-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN adduser --home /home/pivpn --disabled-password pivpn
RUN echo "deb http://deb.debian.org/debian buster-backports main non-free" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y -f --no-install-recommends wireguard-tools qrencode gnupg openvpn grepcidr expect curl nano sudo systemd bsdmainutils bash-completion cron ca-certificates iproute2 net-tools iptables-persistent apt-transport-https whiptail dnsutils procps grep dhcpcd5 iptables-persistent

COPY sh/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*

# Cron Setup
COPY crontab /etc/cron.d/update
RUN chmod 0644 /etc/cron.d/update && crontab /etc/cron.d/update

COPY  --from=builder /clone /usr/local/src/pivpn

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /etc/pivpn/openvpn/* /etc/openvpn/* /etc/wireguard/* /tmp/* || true

WORKDIR /home/pivpn
COPY run .
RUN chmod +x /home/pivpn/run
CMD ["./run"]
