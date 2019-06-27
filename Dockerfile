FROM golang:latest
RUN apt update -y && apt install unzip

ENV GOPATH=/go
ENV GOARCH=amd64
ENV ARCHGO=arm
ENV GOOS=linux
ENV GOARM=7
# ENV CC=arm-linux-gnueabi-gcc

ENV BEATS=filebeat,metricbeat
ENV BEATS_VERSION=7.2.0

COPY ./build.sh /build.sh
RUN [ "mkdir", "-p", "/go" ]
RUN [ "mkdir", "/build" ]

CMD "/build.sh"
