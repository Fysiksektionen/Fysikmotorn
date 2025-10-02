#!/bin/bash

if [ -z "$1" ]; then
    echo "Warning: No container name supplied."
    echo "Usage: $0 <container_name>"
    exit 1
fi

cd ../scripts
source gather_envs.sh
docker compose up -d $1
