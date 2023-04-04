# Tinc for Docker

only 20mb size! (Can be less with precompiled binary)

## Usage
```
docker run -d \
    --name tinc \
    --net=host \
    --device=/dev/net/tun \
    --cap-add NET_ADMIN \
    --volume /srv/tinc:/etc/tinc \
    aooj/tinc start -D
```

```
docker run -ti -d --restart=always --name tinc18-2 -v /dev/net/tun:/dev/net/tun -v /etc/tinc:/usr/local/etc/tinc --network=host --privileged=true tinc:1.1pre18-2023-04-04 start -n aoj -D
```
