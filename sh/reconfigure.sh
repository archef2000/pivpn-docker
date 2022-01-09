#!/bin/bash

Writung setupVars.conf
bash /home/pivpn/setupVars.sh

Reconfigure PIVPN
INSTALLER=/etc/pivpn/install.sh
curl -fsSL0 https://install.pivpn.io -o "${INSTALLER}" \
    && sed -i '/setStaticIPv4 #/d' "${INSTALLER}" \
    && chmod +x "${INSTALLER}" \
    && "${INSTALLER}" --unattended /etc/pivpn/setupVars.conf --reconfigure
