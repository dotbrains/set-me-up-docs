#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

if [ ! -d node_modules/mermaid ] || [ ! -d node_modules/jsdom ] || [ ! -d node_modules/dompurify ]; then
    npm install --silent
fi

node scripts/check-mermaid.mjs
