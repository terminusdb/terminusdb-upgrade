# syntax=docker/dockerfile:1.3

FROM rust:latest AS base
RUN set -eux; \
   git clone https://github.com/terminusdb/terminusdb-10-to-11 /app/terminusdb-10-to-11
WORKDIR /app/terminusdb-10-to-11
RUN cargo build --release

FROM debian:bullseye
WORKDIR /app/terminusdb-upgrade
RUN mkdir bin
COPY --from=base /app/terminusdb-10-to-11/target/release/terminusdb-10-to-11 bin/terminusdb-10-to-11
COPY upgrade.sh upgrade.sh
CMD ["/app/terminusdb-upgrade/upgrade.sh"]