# denizzzzp/beats4piext

Docker image to build elastic/beats for Raspberry Pi

## Customizing

The image has a couple of ENV vars that can be used for customizing what and how to build:

  - `GOARCH=amd64` - Architecture run condiner on build
  - `GOARM=7` - ARM architecture version - 7 for RasperryPi 3
  - `GOOS=linux` - OS system
  - `ARCHGO=arm` - the target architecture, arm for RaspberryPi - EXT (386 amd64 arm ppc64 ppc64le)
  - `BEATS=filebeat,metricbeat` - comma-separated list of beats to compile
  - `BEATS_VERSION=6.8.1` - version to compile



## Building elastic beats

This command will output the build result in the current folder:

    docker run -v $(pwd):/build -e BEATS_VERSION=6.8.1 -e GOOS=linux -e ARCHGO=arm denizzzzp/beats4piext
    
