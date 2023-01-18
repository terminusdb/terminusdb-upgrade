# syntax=docker/dockerfile:1.3

FROM rust:latest AS base
WORKDIR /app/terminusdb-10-to-11
COPY src src
COPY Cargo.toml Cargo.toml
COPY Cargo.lock Cargo.lock
RUN cargo build --release

FROM debian:bullseye
WORKDIR /app/terminusdb-10-to-11
COPY --from=base /app/terminusdb-10-to-11/target/release/terminusdb-10-to-11 terminusdb-10-to-11