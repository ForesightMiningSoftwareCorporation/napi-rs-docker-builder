FROM ghcr.io/napi-rs/napi-rs/nodejs-rust:lts-alpine

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh