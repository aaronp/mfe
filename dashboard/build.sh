#!/usr/bin/env bash
docker build . -t skeleton-debug

docker run -dp 3000:80 skeleton-debug