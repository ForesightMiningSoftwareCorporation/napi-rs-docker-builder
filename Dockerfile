FROM ghcr.io/napi-rs/napi-rs/nodejs-rust:lts-alpine

RUN apk add openssh make perl pkgconfig openssl-dev

RUN mkdir /ssh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh