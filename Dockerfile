# FROM debian:stretch
FROM debian:stretch-20211201-slim

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update --fix-missing && apt upgrade -f --no-install-recommends

RUN apt install -y -f --no-install-recommends sudo systemd nano procps curl ca-certificates dhcpcd5

COPY setupVars.conf /etc/pivpn/

ARG pivpnFilesDir=/etc/pivpn
ARG PIVPN_TEST=false
ARG PLAT=Debian
ARG useUpdateVars=true
ARG SUDO=
ARG SUDOE=

RUN apt clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/*

WORKDIR /home/pivpn
COPY run .
RUN chmod +x /home/pivpn/run
CMD ["./run"]    
