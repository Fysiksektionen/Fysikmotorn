#!/bin/bash
# Usage: source gather_envs.sh

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "ERROR: You must source this script: 'source $0'"
  exit 1
fi

cd ..
ENV_FILE_LIST="environments.txt"

if [[ ! -f "$ENV_FILE_LIST" ]]; then
  echo "ERROR: $ENV_FILE_LIST not found"
  return 1
fi

while IFS= read -r file || [[ -n "$file" ]]; do
  # skip empty lines and lines starting with #
  [[ -z "$file" || "$file" =~ ^# ]] && continue

  if [[ ! -f "$file" ]]; then
    echo "WARNING: File '$file' not found, skipping"
    continue
  fi

  # source the file to export variables
  # use 'set -a' to automatically export all variables
  set -a
  source "$file"
  set +a
done < "$ENV_FILE_LIST"
