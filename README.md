# Docker image to build elastic/beats for Raspberry Pi

## Customizing

The image has a couple of ENV vars that can be used for customizing what and how
to build:

- `GOARCH=arm` - the target architecture, arm for RaspberryPi
- `GOARM=7` - ARM architecture version - 7 for RasperryPi 3
- `BEATS=filebeat,metricbeat` - comma-separated list of beats to compile
- `BEATS_VERSION=7.14.0` - version to compile

## Building the image

    docker build -t tschaffter/beats4pi:latest .

## Building elastic beats

These commands will clone the repository of elastic/beats, build the selected
beats and output the build result in the current folder:

    git clone https://github.com/elastic/beats
    docker run --rm \
        -v $(pwd)/beats:/go/src/github.com/elastic/beats \
        -v $(pwd):/build \
        -e BEATS_VERSION=7.14.0 \
        tschaffter/beats4pi:latest
