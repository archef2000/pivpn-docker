FROM ubuntu:latest
#debian:stretch-20211011

ENV DEBIAN_FRONTEND=noninteractive
RUN XDG_RUNTIME_DIR=/run/user/`id -u`


RUN apt-get update --fix-missing && apt-get upgrade -f -y --no-install-recommends
RUN apt-get install -y -f --no-install-recommends systemd sudo curl git systemd iproute2 nano procps ca-certificates grep dhcpcd5 iptables-persistent
# grepcidr openvpn expect whiptail net-tools bsdmainutils bash-completion git tar dnsutils apt-transport-https

COPY sh/ /usr/local/bin/
# RUN bash . /usr/local/bin/setupVars && bash . /usr/local/bin/reconfigure
# RUN chmod +x /etc/pivpn/setupVars && chmod +x /etc/pivpn/reconfigure
RUN mkdir /etc/pivpn/
RUN sudo bash setupVars


ARG PIVPN_TEST=false
ARG PLAT=ubuntu
ARG useUpdateVars=true
ARG SUDO=
ARG SUDOE=
ARG INSTALLER=/etc/pivpn/install.sh
RUN mkdir -p -v /usr/local/src/pivpn/
RUN curl -fsSL0 https://install.pivpn.io -o "${INSTALLER}" \
    && sed -i 's/debconf-apt-progress --//g' "${INSTALLER}" \
    && sed -i '/setStaticIPv4 #/d' "${INSTALLER}" \
    && sed -i 's/WIREGUARD_SUPPORT=0/WIREGUARD_SUPPORT=1/g' "${INSTALLER}" \
    && chmod +x "${INSTALLER}" \
    && bash "${INSTALLER}" --unattended /etc/pivpn/setupVars.conf --reconfigure

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /etc/pivpn/openvpn/* /etc/openvpn/*

WORKDIR /home/pivpn
COPY run .
RUN chmod +x /home/pivpn/run
CMD ["./run"]    
