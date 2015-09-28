FROM alpine:3.2
MAINTAINER AooJ <aooj@n13.cz>

RUN apk add --update tinc && rm -rf /var/cache/apk/*

EXPOSE 655/tcp 655/udp
VOLUME /etc/tinc

ENTRYPOINT [ "/usr/sbin/tincd" ]
CMD [ "start", "-D", "-U", "nobody" ]
