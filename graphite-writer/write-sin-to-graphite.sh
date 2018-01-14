#! /usr/bin/env bash

# set -x

angle=0

# echo "the graphite host is:"
# echo $(nslookup graphite)

while true; do
    value=$(awk -v angle=$angle 'BEGIN { printf("%10.3f\n", sin(angle * 3.14159 / 180))}')
    echo "writing $value to graphite"
    echo "test.sinus;foo=bar $value `date +%s`" | nc -w 1 graphite 2003
    # echo "test.sinus;foo=bar $value `date +%s`" | nc -w 1 graphite 2003
    status=$?
    if [ "$status" != "0" ]; then
        echo "failed to write $value to graphite"
    fi
    # echo "gaga 1"
    ((angle+=5))
    # echo "gaga 2"
    sleep 1
    # echo "gaga 3"
done