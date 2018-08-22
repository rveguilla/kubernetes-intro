#!/usr/bin/env bash

SERVICE_URL=http://localhost:3000
curl -s ${SERVICE_URL} | jq .
