#!/usr/bin/env bash

export LOG_LEVEL="error"

mix compile
mix update_html
if mix test; then
  mix update_api_json
else
  echo "Error running mix test"
  exit 1
fi