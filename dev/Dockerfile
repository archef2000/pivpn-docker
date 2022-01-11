FROM debian:stretch-20211011

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --fix-missing && apt-get upgrade -f -y --no-install-recommends
RUN apt-get install -y -f --no-install-recommends curl systemd nano procps ca-certificates grep dhcpcd5 iptables-persistent
# grepcidr openvpn expect whiptail net-tools bsdmainutils bash-completion git tar dnsutils apt-transport-https

COPY sh/ /etc/pivpn/
RUN chmod +x /etc/pivpn/setupVars.sh && chmod +x /etc/pivpn/reconfigure.sh
RUN /etc/pivpn/setupVars.sh

ARG pivpnFilesDir=/etc/pivpn
ARG PIVPN_TEST=false
ARG PLAT=Debian
ARG useUpdateVars=true
ARG SUDO=
ARG SUDOE=
ARG INSTALLER=/etc/pivpn/install.sh
RUN mkdir -p -v /usr/local/src/pivpn/
RUN curl -fsSL0 https://install.pivpn.io -o "${INSTALLER}" \
    && sed -i 's/debconf-apt-progress --//g' "${INSTALLER}" \
    && sed -i '/setStaticIPv4 #/d' "${INSTALLER}" \
    && chmod +x "${INSTALLER}" \
    && bash "${INSTALLER}" --unattended /etc/pivpn/setupVars.conf --reconfigure

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /etc/pivpn/openvpn/* /etc/openvpn/*

WORKDIR /home/pivpn
COPY run .
RUN chmod +x /home/pivpn/run
CMD ["./run"]    
