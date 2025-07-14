#!/usr/bin/env bash

# Список сайтов для проверки
sites=(
  "https://google.com"
  "https://facebook.com"
  "https://twitter.com"
)

log_file="website_status.log"
> "$log_file"

echo "Starting check at $(date)" | tee -a "$log_file"

for url in "${sites[@]}"; do
  status_code=$(curl -skL -o /dev/null -w "%{http_code}" --max-time 10 "$url")
  echo "DEBUG: $url returned $status_code" | tee -a "$log_file"

  if [[ "$status_code" -eq 200 ]]; then
    echo "$url is UP" | tee -a "$log_file"
  else
    echo "$url is DOWN (HTTP $status_code)" | tee -a "$log_file"
  fi
done

echo "Done. Results written to $log_file"
