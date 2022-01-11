#!/bin/bash

IPV4DNS=${IPV4DNS:=172.17.0.1}

TWO_POINT_FOUR=${"TWO_POINT_FOUR":=1}

if [ $TWO_POINT_FOUR = "0" ]; then
   ENCRYPTION=2048
else
  ENCRYPTION=256
fi

cat << EOF > /etc/pivpn/setupVars.conf
USING_UFW=0
install_user=pivpn
install_home=/home/pivpn
VPN=openvpn
pivpnDEV=tun0
UNATTUPG=1
IPv4dns=$IPV4DNS
IPv4dev=${INTERFACE:=eth0}
pivpnInterface=${INTERFACE:=eth0}
pivpnPROTO=${PROTO:=udp}
pivpnPORT=${PORT:=1194}
pivpnDNS1=${DNS1:=8.8.8.8}
pivpnDNS2=${DNS2:=8.8.4.4}
pivpnHOST=${HOST:=example.com}
pivpnSEARCHDOMAIN=${SEARCHDOMAIN:=}
TWO_POINT_FOUR=$TWO_POINT_FOUR
pivpnENCRYPT=${ENCRYPT:="$ENCRYPTION"} # 2048, 3072, or 4096
USE_PREDEFINED_DH_PARAM=${PREDEFINED_DH_PARAM:=1}
pivpnNET=${NET:=10.8.0.0}
subnetClass=${subnetClass:=24}
EOF
