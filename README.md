# Dockerized SOCAT

Ref: https://linux.die.net/man/1/socat

## TLDR; Sample usage: UDP proxy over TCP

```bash
server$ docker run \
    --name joestldr-socat-udp-over-tcp-server \
    --detach \
    --restart=unless-stopped \
    --publish=5353:5353/tcp \
  joestldr/socat:v1.0.0 \
    -dd TCP4-LISTEN:5353,REUSEADDR,FORK UDP:8.8.8.8:53
```
```bash
client$ DNS_PROXY_TCP_IP=172.17.0.1

client$ DNS_LISTEN_UDP_IP=172.17.0.1

client$ docker run \
    --name joestldr-socat-udp-over-tcp-client \
    --detach \
    --restart=unless-stopped \
    --publish=${DNS_LISTEN_UDP_IP}:53:53/udp \
  joestldr/socat:v1.0.0 \
    -dd UDP4-LISTEN:53,REUSEADDR,FORK TCP:${DNS_PROXY_TCP_IP}:5353

client$ nslookup google.com 172.17.0.1
```

## Why containerize `socat`?

`FORK` (child processes) of `socat` eats a lot of `PID`

# License

Copyright 2023 [joes-tldr](https://github.com/joes-tldr)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
