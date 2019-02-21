# FROM alpine
# RUN apk add --no-cache alpine-sdk go
# RUN apk add --no-cache bash

FROM debian:buster-slim

RUN apt update && apt install -y \
    golang \
    build-essential \
    gcc-arm-linux-gnueabi \
    git \
    wget \
    python2 \
    && rm -rf /var/lib/apt/lists/*

ENV GOPATH=/go
ENV GOARCH=arm
ENV GOARM=7
# ENV CC=arm-linux-gnueabi-gcc

ENV BEATS=filebeat,metricbeat
ENV BEATS_VERSION=6.1.1

COPY ./build.sh /build.sh
RUN [ "chmod", "+x", "/build.sh" ]
RUN [ "mkdir", "-p", "/go" ]
RUN [ "mkdir", "/build" ]

CMD "/build.sh"
