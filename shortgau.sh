#!/bin/bash

input_file="gau_output.txt"
output_file="filtered_urls.txt"

declare -A seen_urls

while IFS= read -r url; do
  base_url=$(echo "$url" | awk -F '?' '{print $1}')
  if [[ ! ${seen_urls["$base_url"]} ]]; then
    echo "$url" >> "$output_file"
    seen_urls["$base_url"]=1
  fi
done < "$input_file"
