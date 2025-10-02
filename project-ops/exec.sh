#!/bin/bash

if [ -z "$1" ]; then
    echo "Warning: No container name supplied."
    echo "Usage: $0 <container_name>"
    exit 1
fi

/usr/bin/docker exec -it "$1" bash
