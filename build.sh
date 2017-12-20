#!/bin/bash
echo Target version: $BEATS_VERSION

BRANCH=$(echo $BEATS_VERSION | awk -F \. {'print $1 "." $2'})
echo Target branch: $BRANCH

if [ ! -d "$GOPATH/src/github.com/elastic/beats" ]; then go get -v github.com/elastic/beats; fi

cd $GOPATH/src/github.com/elastic/beats
git checkout $BRANCH

IFS=","
BEATS_ARRAY=($BEATS)

for BEAT in "${BEATS_ARRAY[@]}"
do
    # build
    cd $GOPATH/src/github.com/elastic/beats/$BEAT
    make
    cp $BEAT /build

    # package
    DOWNLOAD=$BEAT-$BEATS_VERSION-linux-x86.tar.gz
    if [ ! -e $DOWNLOAD ]; then wget --no-verbose https://artifacts.elastic.co/downloads/beats/$BEAT/$DOWNLOAD; fi
    tar xf $DOWNLOAD

    cp $BEAT $BEAT-$BEATS_VERSION-linux-x86
    tar zcf $BEAT-$BEATS_VERSION-linux-arm$GOARM.tar.gz $BEAT-$BEATS_VERSION-linux-x86
    cp $BEAT-$BEATS_VERSION-linux-arm$GOARM.tar.gz /build
done
