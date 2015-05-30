#!/bin/bash

cd /home/pi/images

rm *.jpg *.png

# go get the files
#landscape files
wget -q -O- "http://backend.deviantart.com/rss.xml?q=boost%3Apopular+in%3Adigitalart%2Fpaintings%2Flandscapes+max_age%3A72h&type=deviation" | grep -o '<media:content url="[^"]*' | grep -o '[^"]*$' | xargs wget -c

FILES=/home/pi/images/*
count=0
one=1

for f in $FILES
  do
    file -b $f
    echo "Checking file number $count"
    count=$(($count + $one))
    if [ "$(file $f|grep JPEG)" ]; then
      mv ${f} $RANDOM.jpg
    elif [ "$(file $f|grep PNG)" ]; then
      mv ${f} $RANDOM.png
    elif [ "$(file $f|grep ASCII)" ]; then
      echo ”Skip Script file”
    else
      echo "unknown file type $f"
    fi
  done