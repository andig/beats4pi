#!/bin/bash
echo Target version: $BEATS_VERSION
go get github.com/mitchellh/gox
go get github.com/magefile/mage

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
    gox -output=/go/src/github.com/elastic/beats/$BEAT/build/bin/{{.Dir}} -os=$GOOS -arch=$ARCHGO

    # package
    DOWNLOAD=$BEAT-$BEATS_VERSION-windows-x86_64.zip
    if [ ! -e $DOWNLOAD ]; then wget --no-verbose https://artifacts.elastic.co/downloads/beats/$BEAT/$DOWNLOAD; fi
    unzip $DOWNLOAD
    rm /go/src/github.com/elastic/beats/$BEAT/$BEAT-$BEATS_VERSION-windows-x86_64/$BEAT.exe
    rm /go/src/github.com/elastic/beats/$BEAT/$BEAT-$BEATS_VERSION-windows-x86_64/*.ps1
    mv $BEAT-$BEATS_VERSION-windows-x86_64 $BEAT-$BEATS_VERSION

    cp -f /go/src/github.com/elastic/beats/$BEAT/build/bin/$BEAT /go/src/github.com/elastic/beats/$BEAT/$BEAT-$BEATS_VERSION/
    tar zcf $BEAT-$BEATS_VERSION-$GOOS-$ARCHGO.tar.gz $BEAT-$BEATS_VERSION
    cp $BEAT-$BEATS_VERSION-$GOOS-$ARCHGO.tar.gz /build
done
