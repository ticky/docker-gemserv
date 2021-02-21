FROM rust:1.50 as builder
RUN apt-get update \
      && apt-get install -y openssl
RUN cargo install \
      --git https://git.sr.ht/~int80h/gemserv \
      --rev f9c41edcb4cfeed50218ff6807b6245d575c0ddb \
      gemserv

FROM debian:buster-slim
MAINTAINER  Jessica Stokes <hello@jessicastokes.net>
RUN apt-get update \
      && apt-get install -y openssl extra-runtime-dependencies \
      && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/cargo/bin/gemserv /usr/local/bin/gemserv

CMD ["gemserv", "/gemserv/config.toml"]
