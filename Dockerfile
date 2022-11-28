FROM ghcr.io/napi-rs/napi-rs/nodejs-rust:lts-alpine

RUN apk add openssh make perl pkgconfig openssl-dev

RUN mkdir /ssh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV RUSTFLAGS="-C link-arg=-s -C link-self-contained=yes -C target-feature=-crt-static"
ENTRYPOINT /entrypoint.sh