FROM debian:stretch

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update --fix-missing

RUN mkdir -p /usr/local/src/pivpn

RUN apt install -y -f --no-install-recommends curl ca-certificates

COPY setupVars.conf /etc/pivpn/

ARG pivpnFilesDir=/etc/.pivpn
ARG PIVPN_TEST=false
ARG SUDO=
ARG SUDOE=
ARG INSTALLER=/tmp/install.sh
ENV pivpnUser=pivpn

RUN curl -fsSL0 https://install.pivpn.io -o "${INSTALLER}" \
    && sed -i 's/debconf-apt-progress --//g' "${INSTALLER}" \
    && sed -i '/systemctl start/d' "${INSTALLER}" \
    && sed -i '/setStaticIPv4 #/d' "${INSTALLER}" \
    && chmod +x "${INSTALLER}" \
    #    && sed -i 's/set -e/set -eux/g' "${INSTALLER}" \
    && "${INSTALLER}" --unattended /etc/pivpn/setupVars.conf --reconfigure --pivpnHOST=test.com
    
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/*
    
    
    
WORKDIR /home/pivpn
    
