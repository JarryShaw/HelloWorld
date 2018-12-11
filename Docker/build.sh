#!/usr/bin/env bash

docker build --force-rm --tag HelloWorld .
docker run -it --rm HelloWorld:latest
