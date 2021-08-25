# Build elastic/beats for Raspberry Pi

## Introduction

This repository provides a Docker image to cross compile [elastic/beats]
components for Raspberry Pi (ARMv7 architecture).


## Requirements

- [Docker Engine] >=19.03.0


## Usage

### Customizing

The image has a couple of ENV vars that can be used for customizing what and how
to build:

- `GOARCH=arm` - the target architecture, arm for RaspberryPi
- `GOARM=7` - ARM architecture version - 7 for RasperryPi 3
- `BEATS=filebeat,metricbeat` - comma-separated list of beats to compile
- `BEATS_VERSION=7.14.0` - version to compile

### Building the image

    docker build -t tschaffter/beats4pi:latest .

### Building elastic beats

These commands will clone the repository of elastic/beats, build the selected
beats components and output the build result in the current folder:

    git clone https://github.com/elastic/beats.git
    docker run --rm \
        -v $(pwd)/beats:/go/src/github.com/elastic/beats \
        -v $(pwd):/build \
        -e BEATS_VERSION=7.14.0 \
        tschaffter/beats4pi:latest

<!-- Links -->

[elastic/beats]: https://github.com/elastic/beats
[Docker Engine]: https://docs.docker.com/engine/install/