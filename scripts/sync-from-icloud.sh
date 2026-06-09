#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="/Users/Shuai/Library/Mobile Documents/iCloud~com~nssurge~inc/Documents/TAG_local_rulesets"

if [[ ! -d "$source_dir" ]]; then
  echo "Source ruleset directory not found: $source_dir" >&2
  exit 1
fi

find "$repo_dir" -maxdepth 1 -type f -name '*.list' -delete
find "$source_dir" -maxdepth 1 -type f -name '*.list' -exec cp {} "$repo_dir" \;

count="$(find "$repo_dir" -maxdepth 1 -type f -name '*.list' | wc -l | tr -d ' ')"
echo "Synced $count ruleset files into $repo_dir"
