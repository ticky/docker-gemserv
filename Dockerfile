FROM rust:1.50-alpine as builder
RUN apk update \
      && apk add --no-cache openssl
RUN cargo install \
      --git https://git.sr.ht/~int80h/gemserv \
      --rev f9c41edcb4cfeed50218ff6807b6245d575c0ddb \
      gemserv

FROM alpine:3.13
MAINTAINER  Jessica Stokes <hello@jessicastokes.net>
RUN apk update \
      && apk add --no-cache openssl

COPY --from=builder /usr/local/cargo/bin/gemserv /usr/local/bin/gemserv

CMD ["gemserv", "/gemserv/config.toml"]
