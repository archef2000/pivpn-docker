# pivpn for docker
<a href="https://hub.docker.com/repository/docker/archef2000/pivpn">Docker Container</a> for <a href="https://github.com/pivpn/pivpn">PIVPN</a>


[![Docker PIVPN](https://github.com/Archef2000/pivpn-docker/actions/workflows/main.yml/badge.svg)](https://github.com/Archef2000/pivpn-docker/actions/workflows/main.yml)

Run "reconf" to reinstall pivpn and use new Variable

First instalation takes about 1-5 min depending on your Internet connection

privileged is needed for openvpn

net_admin is needed for wireguard

Docker Container for <a href="https://github.com/pivpn/pivpn">PIVPN</a>

<a href="https://github.com/Archef2000/pivpn-docker/">Github</a>

Failed to connect to bus: No such file or directory AND
./easyrsa: 341: set: Illegal option -o echo
Are known and solved in other ways but still shown

<h2>docker-compose</h2>
<h2>Openvpn</h2>
<pre><code class="language-yaml">---
version: '3'
services:
  openvpn:
    image: archef2000/pivpn:latest
    container_name: pivpn
    hostname: pivpn
    ports:
      - 1194:1194/udp
    volumes:
      - ./openvpn/ovpns:/home/pivpn/ovpns
      - ./openvpn/openvpn:/etc/openvpn
    environment:
      - HOST=example.com
      - PROTO=udp # or tcp
      - VPN=openvpn
      - PORT=1194
# optional
      - CLIENT_NAME=pivpn
      - NET=10.8.0.0
      - TWO_POINT_FOUR=1 # or 0 If TWO_POINT_FOUR=0 then ENCRYPT needs to be 2048, 3072, or 4096
      - DNS1=1.1.1.1 # Client DNS
      - DNS2=9.9.9.9 # Client DNS
      - ENCRYPT=256 # 256, 384, or 521 if TWO_POINT_FOUR=0 then ENCRYPT needs to be 2048, 3072, or 4096
    privileged: true # Is needed to run Openvpn
    restart: always
</code></pre>
<h2>Wireguard</h2>
<pre><code class="language-yaml">---
version: '3'
services:
  wireguard:
    image: archef2000/pivpn:latest
    container_name: pivpn
    hostname: pivpn
    ports:
      - 51820:51820/udp
    volumes:
      - ./wireguard/configs:/home/pivpn/configs
      - ./wireguard/wireguard:/etc/wireguard
    environment:
      - HOST=example.com
      - VPN=wireguard
      - PORT=51820
# optional
      - CLIENT_NAME=pivpn
      - NET=10.8.0.0
      - DNS1=1.1.1.1 # Client DNS
      - DNS2=9.9.9.9 # Client DNS
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    restart: always
</code></pre>
<h2>Docker Run</h2>
<pre><code class="language-yaml">docker run -d --privileged \
-v ./openvpn/openvpn:/etc/openvpn -v ./openvpn/pivpn:/etc/pivpn/openvpn -v ./openvpn/ovpns:/home/pivpn/ovpns \
-p 1194:194/udp archef2000/pivpn:latest</code></pre>

<h2>Environment Variables:</h2>
<pre><code class="language-yaml">
pivpnHOST=example.com
pivpnPROTO=udp
pivpnPORT=1194
VPN=openvpn #/wireguard
# optional
pivpnDNS1=8.8.8.8
pivpnDNS2=8.8.4.4
pivpnSEARCHDOMAIN=
TWO_POINT_FOUR=1
pivpnENCRYPT=256, 384, 521 or 2048, 3072, 4096
USE_PREDEFINED_DH_PARAM=1
pivpnNET=10.8.0.0
subnetClass=24
</code></pre>
<h2>Volumes:</h2>
<pre><code class="language-yaml">
./pivpn/openvpn:/etc/openvpn         # OPENVPN Server Config
./pivpn/wireguard:/etc/wireguard      # If Wireguard
</code></pre>

<hr>
