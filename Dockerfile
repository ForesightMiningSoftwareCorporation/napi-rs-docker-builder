FROM ghcr.io/napi-rs/napi-rs/nodejs-rust:lts-alpine

RUN apk add openssh make perl pkgconfig openssl-dev curl gcc musl-dev linux-headers


RUN mkdir -p /usr/local/musl/include

WORKDIR /tmp

RUN curl -fLO "https://www.openssl.org/source/openssl-1.1.1m.tar.gz"
RUN tar xvzf "openssl-1.1.1m.tar.gz"
WORKDIR /tmp/openssl-1.1.1m
RUN ./config -fPIC
RUN make -j$(nproc) depend
RUN make -j$(nproc)
RUN make -j$(nproc) install_sw

ENV OPENSSL_LIB_DIR=/usr/local/lib
ENV OPENSSL_INCLUDE_DIR=/usr/include/openssl
ENV OPENSSL_STATIC=yes
ENV RUSTFLAGS="-C link-arg=-s -C link-self-contained=yes -C target-feature=-crt-static -C link-args=-static-libgcc"

RUN mkdir /ssh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh