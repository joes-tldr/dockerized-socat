FROM alpine:latest

RUN set -xv; \
    apk add --update socat && \
    rm -rf /var/cache/apk/*

ENTRYPOINT [ "socat" ]
