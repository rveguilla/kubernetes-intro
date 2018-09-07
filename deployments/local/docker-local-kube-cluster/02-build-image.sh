#!/usr/bin/env bash
pushd ../../..
  docker build --tag example-app .
popd
