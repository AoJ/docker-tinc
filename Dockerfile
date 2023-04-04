FROM alpine:latest
MAINTAINER AooJ <aooj@n13.cz>

# http://www.tinc-vpn.org/pipermail/tinc/2016-May/004572.html
# As it turns out, it's a bug in the igmp snooping code in the kernel that's the problem with multicast traffic not being forwarded.
# echo 0 > /sys/devices/virtual/net/br0/bridge/multicast_snooping


ENV DEV_PACKAGES="build-base make zlib-dev lzo-dev libressl-dev linux-headers ncurses-dev readline-dev"
ENV TINC_VERSION=4c6a9a9611442f958c3049a566ac4369653978e9

RUN     cd /tmp && \
        wget https://github.com/gsliepen/tinc/archive/${TINC_VERSION}.tar.gz && \
        tar -xzf ${TINC_VERSION}.tar.gz && \
        cd tinc-${TINC_VERSION} && \
        .ci/deps.sh && \
        mkdir -p /tmp/target && \
        .ci/build.sh /tmp/target && \
        /tmp/target/src/tinc --version

FROM alpine:latest
RUN apk add readline lzo lz4-libs vde2-libs iptables \
 && mkdir -p /usr/local/tinc /var/local/run
COPY --from=0 /tmp/target/src/tinc /usr/sbin/tinc
COPY --from=0 /tmp/target/src/tincd /usr/sbin/tincd

EXPOSE 655/tcp 655/udp
VOLUME /etc/tinc

ENTRYPOINT [ "/usr/sbin/tinc" ]
CMD [ "start", "-D", "-U", "nobody" ]
