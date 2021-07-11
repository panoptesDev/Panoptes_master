#!/usr/bin/env bash
set -ex

cd "$(dirname "$0")"

docker build -t panopteslabs/rust .

read -r rustc version _ < <(docker run panopteslabs/rust rustc --version)
[[ $rustc = rustc ]]
docker tag panopteslabs/rust:latest panopteslabs/rust:"$version"
docker push panopteslabs/rust:"$version"
docker push panopteslabs/rust:latest
