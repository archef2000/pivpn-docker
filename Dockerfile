FROM debian:stretch

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update --fix-missing && apt upgrade -f --no-install-recommends

RUN apt install -y -f --no-install-recommends curl ca-certificates git tar grep dnsutils whiptail net-tools bsdmainutils bash-completion apt-transport-https dhcpcd5 iptables-persistent

COPY setupVars.conf /etc/pivpn/

ARG pivpnFilesDir=/etc/pivpn
ARG PIVPN_TEST=false
ARG PLAT=Debian
ARG useUpdateVars=true
ARG SUDO=
ARG SUDOE=
ARG INSTALLER=/etc/pivpn/install.sh

RUN echo $TEST
RUN TEST := $(if $(TEST),$(TEST),$(something else))
RUN echo $TEST

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/*

WORKDIR /home/pivpn
COPY run .
CMD ["./run"]    
