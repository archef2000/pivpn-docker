SetupVars=/etc/pivpn/setupVars.conf
sed -i "s/pivpnNET=/pivpnNET=$PIVPNNET/" "${SetupVars}"
