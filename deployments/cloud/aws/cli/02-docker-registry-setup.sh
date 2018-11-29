#!/usr/bin/env bash

aws ecr create-repository --repository-name example-app

$(aws ecr get-login --no-include-email)