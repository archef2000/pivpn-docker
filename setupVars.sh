SetupVars=/etc/pivpn/setupVars.conf
sed -i "s/pivpnNET=10.8.0.0/pivpnNET=$PIVPNNET/" "${SetupVars}"
sed -i "s/VPN=openvpn/VPN=$VPN/" "${SetupVars}"
sed -i "s/TWO_POINT_FOUR=1/TWO_POINT_FOUR="$2.4"/" "${SetupVars}"

