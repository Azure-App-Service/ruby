#!/usr/bin/env bash
set -x -e

docker build -t "$1"/rubybase:2.3.3 base_images/2.3.3
docker build -t "$1"/ruby:2.3.3-2 -t "$1"/ruby:2.3-2 -t "$1"/ruby:2-2 -t "$1"/ruby:latest 2.3

docker login -u "$2" -p "$3"

docker push "$1"/rubybase:2.3.3

docker push "$1"/ruby:2.3.3-2
docker push "$1"/ruby:2.3-2
docker push "$1"/ruby:2-2
docker push "$1"/ruby:latest

docker logout