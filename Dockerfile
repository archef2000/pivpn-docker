FROM debian:stretch-20211011

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update --fix-missing && apt-get upgrade -f -y --no-install-recommends

RUN apt-get install -y -f curl systemd grepcidr openvpn expect nano procps ca-certificates git tar grep dnsutils whiptail net-tools bsdmainutils bash-completion apt-transport-https dhcpcd5 iptables-persistent
# 

COPY sh/ /home/pivpn/

ARG pivpnFilesDir=/etc/pivpn
ARG PIVPN_TEST=false
ARG PLAT=Debian
ARG useUpdateVars=true
ARG SUDO=
ARG SUDOE=
ARG INSTALLER=/etc/pivpn/install.sh

RUN curl -fsSL0 https://install.pivpn.io -o "${INSTALLER}" \
    && sed -i 's/debconf-apt-progress --//g' "${INSTALLER}" \
    && sed -i '/setStaticIPv4 #/d' "${INSTALLER}" \
    && chmod +x "${INSTALLER}" \
    && bash "${INSTALLER}" --unattended /etc/pivpn/setupVars.conf --reconfigure

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/*

WORKDIR /home/pivpn
COPY run .
RUN chmod +x /home/pivpn/run
CMD ["./run"]    
