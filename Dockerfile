FROM debian:stretch

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update --fix-missing

RUN apt install -y -f --no-install-recommends curl ca-certificates

COPY setupVars.conf /etc/pivpn/

RUN curl -fsSL0 https://install.pivpn.io -o "${INSTALLER}" \
    && sed -i 's/debconf-apt-progress --//g' "${INSTALLER}" \
    && sed -i '/systemctl start/d' "${INSTALLER}" \
    && sed -i '/setStaticIPv4 #/d' "${INSTALLER}" \
    && chmod +x "${INSTALLER}" \
    #    && sed -i 's/set -e/set -eux/g' "${INSTALLER}" \
    && "${INSTALLER}" --unattended /etc/pivpn/setupVars.conf --reconfigure --pivpnHOST=test.com
    
WORKDIR /home/pivpn
EXPOSE 443
    
