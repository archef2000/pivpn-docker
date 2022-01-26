FROM debian:stretch-20211011
# debian:stretch-20211011
# ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN XDG_RUNTIME_DIR=/run/user/`id -u`

RUN echo "deb http://deb.debian.org/debian buster-backports main non-free" >> /etc/apt/sources.list
RUN apt-get update --fix-missing && apt-get upgrade -f -y --no-install-recommends
#RUN apt-get install -y -f --no-install-recommends git sudo systemd bsdmainutils nano bash-completion curl 
RUN apt-get install -y -f --no-install-recommends systemd sudo curl git ca-certificates \
    apt-transport-https iproute2 grepcidr openvpn expect whiptail net-tools bsdmainutils \
    bash-completion git tar dnsutils nano procps  grep dhcpcd5 iptables-persistent


COPY sh/ /usr/local/bin/
RUN mkdir /etc/pivpn/
RUN sudo bash setupVars

ARG INSTALLER=/etc/pivpn/install.sh
RUN apt update --fix-missing && apt-get upgrade -f -y --no-install-recommends
RUN mkdir -p -v /usr/local/src
ENV SUDO=sudo
ENV SUDOE="sudo -E"
ENV pivpnFilesDir="/usr/local/src/pivpn"
ENV pivpnGitUrl="https://github.com/pivpn/pivpn.git"
RUN git clone -q --depth 1 --no-single-branch ${pivpnFilesDir} ${pivpnGitUrl} 

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /etc/pivpn/openvpn/* /etc/openvpn/* /etc/wireguard/* /tmp/* || true

WORKDIR /home/pivpn
COPY run .
RUN chmod +x /home/pivpn/run
CMD ["./run"]
