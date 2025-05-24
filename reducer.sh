#!/bin/bash

while [[ $# -gt 0 ]]; do
  case $1 in
    --query)
      QUERY_FILE="$2"
      shift 2
      ;;
    --test)
      TEST_SCRIPT="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

echo "TEST=$TEST_SCRIPT"
ls -l "$TEST_SCRIPT"

echo "query= $QUERY_FILE"

DIR=$(dirname "$QUERY_FILE")

if [[ -z "$QUERY_FILE" || -z "$TEST_SCRIPT" ]]; then
  echo "Usage: $0 --query <query.sql> --test <test_script>"
  exit 1
fi

QUERY_FILE_real=$(realpath "$QUERY_FILE")

#javac Reducer.java || exit 1
sudo java reducer_helper "$QUERY_FILE_real" "$TEST_SCRIPT"