#! /usr/bin/env bash

# set -x

angle=0

while true; do
    value=$(awk -v angle=$angle 'BEGIN { printf("%10.3f\n", sin(angle * 3.14159 / 180))}')
    # echo "writing $value to graphite"
    echo "test.sinus;foo=bar $value `date +%s`" | nc -w 1 graphite 2003
    status=$?
    if [ "$status" != "0" ]; then
        echo "failed to write $value to graphite"
    fi
    ((angle+=2))
    sleep 1
done