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
