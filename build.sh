#!/usr/bin/env bash
set -x -e

buildnumber=${4-$(date -u +"%y%m%d%H%M")}

#docker build -t "$1"/rubybase:2.3.3_"$buildnumber" base_images/2.3.3
docker build -t "$1"/ruby:2.3.3_"$buildnumber" -t "$1"/ruby:latest_"$buildnumber" 2.3.3

docker login -u "$2" -p "$3"

#docker push "$1"/rubybase:2.3.3

docker push "$1"/ruby:latest_"$buildnumber"
docker push "$1"/ruby:2.3.3_"$buildnumber"

docker logout
