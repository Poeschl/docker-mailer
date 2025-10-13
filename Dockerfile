FROM alpine:3.22

RUN apk add --no-cache \
    coreutils=9.7-r1 \
    ssmtp=2.64-r22

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
