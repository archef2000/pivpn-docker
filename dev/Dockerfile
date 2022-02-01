FROM debian:stretch-20211011-slim
# debian:stretch-20211011
# ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

#RUN echo "deb http://deb.debian.org/debian buster-backports main non-free" >> /etc/apt/sources.list
RUN adduser --home /home/pivpn --disabled-password pivpn
RUN apt-get update --fix-missing 
## && apt-get upgrade -f -y --no-install-recommends
RUN apt-get install -y -f --no-install-recommends git curl nano sudo systemd bsdmainutils bash-completion ca-certificates iproute2 net-tools
#RUN apt-get install -y -f --no-install-recommends systemd sudo curl git ca-certificates \
#    apt-transport-https iproute2 grepcidr openvpn expect whiptail net-tools bsdmainutils \
#    bash-completion git tar dnsutils nano procps  grep dhcpcd5 iptables-persistent wireguard-tools qrencode

COPY sh/ /usr/local/bin/
#RUN mkdir /etc/pivpn/
#RUN sudo bash setupVars
#RUN mkdir -p -v /usr/local/src/pivpn
RUN git clone https://github.com/pivpn/pivpn.git /usr/local/src/pivpn

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /etc/pivpn/openvpn/* /etc/openvpn/* /etc/wireguard/* /tmp/* || true

WORKDIR /home/pivpn
COPY run .
RUN chmod +x /home/pivpn/run
CMD ["./run"]
