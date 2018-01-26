#!/usr/bin/env bash
pushd ../..
  ./build.sh
  docker build --tag example-app .
popd
