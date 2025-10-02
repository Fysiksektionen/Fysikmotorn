#!/usr/bin/env bash
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "ERROR: You must source this script: 'source $0'"
  exit 1
fi

cd ..
MAPPING_FILE="environments.conf"

while IFS='=' read -r var_name env_file; do
    # skip empty lines and comments
    [[ -z "$var_name" || "$var_name" =~ ^# ]] && continue

    # read env_file safely, extract only the exact variable
    if [[ -f "$env_file" ]]; then
        value=$(grep -E "^${var_name}=" "$env_file" | head -n1 | cut -d= -f2-)
        if [[ -n "$value" ]]; then
            export "$var_name=$value"
        else
            echo "Warning: $var_name not found in $env_file" >&2
        fi
    else
        echo "Warning: file $env_file not found" >&2
    fi
done < "$MAPPING_FILE"
