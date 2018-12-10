#!/usr/bin/env bash

docker build --tag HelloWorld .
docker run -it HelloWorld:latest
