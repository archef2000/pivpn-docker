#!/bin/bash

# VPN
VPN=${VPN:=openvpn}
if [ $VPN = openvpn ]; then VPNPORT=1194; else VPNPORT=51820; fi

#2.4 Openvpn
TWO_POINT_FOUR=${TWO_POINT_FOUR:=1}
if [ $TWO_POINT_FOUR = "0" ]; then ENCRYPTION=2048; else ENCRYPTION=256; fi


cat << EOF > /etc/pivpn/setupVars.conf
# All
install_user=pivpn
install_home=/home/pivpn
pivpnPROTO=${PROTO:=udp}
pivpnPORT=${PORT:=$VPNPORT}
pivpnDNS1=${DNS1:=8.8.8.8}
pivpnDNS2=${DNS2:=8.8.4.4}
pivpnHOST=${HOST:=example.com}
pivpnNET=${NET:=10.8.0.0}
subnetClass=${subnetClass:=24}
IPv4dev=${INTERFACE:=eth0}
UNATTUPG=1
VPN=$VPN
#OPENVPN
TWO_POINT_FOUR=$TWO_POINT_FOUR
pivpnENCRYPT=${ENCRYPT:="$ENCRYPTION"} # 2048, 3072, 4096 or 256, 384, 521
USE_PREDEFINED_DH_PARAM=${PREDEFINED_DH_PARAM:=1}
# Wireguard
ALLOWED_IPS="0.0.0.0/0, ::0/0"
pivpnMTU=1420
pivpnPERSISTENTKEEPALIVE=25
EOF
# pivpnDEV=tun0; IPv4dns=$IPV4DNS; pivpnInterface=${INTERFACE:=eth0}; pivpnSEARCHDOMAIN=${SEARCHDOMAIN:=}; USING_UFW=0
# IPV4DNS=${IPV4DNS:=172.17.0.1}
