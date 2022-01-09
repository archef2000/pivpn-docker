#!/bin/bash

cat << EOF > /etc/pivpn/setupVars.conf
USING_UFW=0
IPv4dev=eth0
pivpnInterface=eth0
install_user=pivpn
install_home=/home/pivpn
VPN=openvpn
pivpnDEV=tun0
UNATTUPG=1
pivpnPROTO="${PROTO:=udp}"
pivpnPORT="${PORT:=1194}"
pivpnDNS1="${DNS1:=8.8.8.8}"
pivpnDNS2="${DNS2:=8.8.4.4}"
pivpnHOST="${HOST:=pivpn}"
pivpnSEARCHDOMAIN="${SEARCHDOMAIN:=}"
TWO_POINT_FOUR="${TWO_POINT_FOUR:=1}"
pivpnENCRYPT="${ENCRYPT:=256}"
USE_PREDEFINED_DH_PARAM="${PREDEFINED_DH_PARAM:=1}"
pivpnNET="${NET:=10.8.0.0}"
subnetClass="${subnetClass:=24}"
EOF
