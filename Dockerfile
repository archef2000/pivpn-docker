FROM debian:stretch

RUN apt update
RUN apt install -y bsdmainutils bash-completion apt-transport-https iptables-persistent git tar curl grep dnsutils whiptail net-tools
RUN apt update && apt-get install -y curl software-properties-common debconf-utils git nano whiptail openvpn dhcpcd5 dnsutils expect whiptail \
        && rm -rf /var/lib/apt/lists/*
RUN apt install -y git curl dhcpcd5
RUN apt clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/*

ARG pivpnFilesDir=/etc/.pivpn

# RUN git clone https://github.com/pivpn/pivpn.git "${pivpnFilesDir}" \
#        && git -C "${pivpnFilesDir}" checkout 548492832d1ae1337c3e22fd0b2b487ca1f06cb0

ENV pivpnUser=pivpn

RUN useradd --no-log-init -rm -s /bin/bash "${pivpnUser}"

COPY setupVars.conf /etc/pivpn/

ARG PIVPN_TEST=false
ARG SUDO=
ARG SUDOE=
ARG INSTALLER=/tmp/install.sh

RUN printf '\n\
interface #pivpnInterface#\n\
static ip_address=#IPv4addr#\n\
static routers=#IPv4gw#\n\
static domain_name_servers=#IPv4dns#' >> /etc/dhcpcd.conf

RUN curl -fsSL0 https://install.pivpn.io -o "${INSTALLER}" \
    && sed -i 's/debconf-apt-progress --//g' "${INSTALLER}" \
    && sed -i '/systemctl start/d' "${INSTALLER}" \
    && sed -i '/setStaticIPv4 #/d' "${INSTALLER}" \
    && chmod +x "${INSTALLER}" \
#    && sed -i 's/set -e/set -eux/g' "${INSTALLER}" \
    && "${INSTALLER}" --unattended /etc/pivpn/setupVars.conf --reconfigure --pivpnHOST=test.com
    
RUN curl -L https://install.pivpn.io -o install.sh

WORKDIR /home/"${pivpnUser}"
COPY run .
CMD ["./run"]
