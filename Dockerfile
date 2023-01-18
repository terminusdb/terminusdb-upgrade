# syntax=docker/dockerfile:1.3

FROM rust:latest AS base
RUN set -eux; \
   git clone https://github.com/terminusdb/terminusdb-10-to-11 /app/terminusdb-10-to-11
WORKDIR /app/terminusdb-10-to-11
RUN cargo build --release

FROM debian:bullseye
WORKDIR /app/terminusdb-10-to-11
COPY --from=base /app/terminusdb-10-to-11/target/release/terminusdb-10-to-11 terminusdb-10-to-11