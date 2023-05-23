FROM alpine:3.18

RUN apk add --no-cache \
    coreutils=9.3-r1 \
    ssmtp=2.64-r20

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]