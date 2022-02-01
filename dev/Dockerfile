FROM debian:stretch-20211011-slim AS builder
RUN (apt update && apt install -y -f --no-install-recommends git ca-certificates) > /dev/null
RUN git clone https://github.com/pivpn/pivpn.git /clone

FROM debian:stretch-20211011-slim
# debian:stretch-20211011
# ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN adduser --home /home/pivpn --disabled-password pivpn
RUN apt-get update --fix-missing
RUN apt-get install -y -f --no-install-recommends git curl nano sudo systemd bsdmainutils bash-completion ca-certificates iproute2 net-tools

COPY sh/ /usr/local/bin/
#RUN mkdir -p -v /usr/local/src/pivpn
COPY  --from=builder /clone /usr/local/src/pivpn

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /etc/pivpn/openvpn/* /etc/openvpn/* /etc/wireguard/* /tmp/* || true

WORKDIR /home/pivpn
COPY run .
RUN chmod +x /home/pivpn/run
CMD ["./run"]
