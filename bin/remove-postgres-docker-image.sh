#! /bin/bash
docker image rm -f `docker image ls | grep monitoringlove | grep postgres | awk '{print $3}'`