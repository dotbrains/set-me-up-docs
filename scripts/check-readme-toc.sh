#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readme="$repo_root/README.md"

python3 - "$readme" <<'PY'
import re
import sys
from pathlib import Path

readme = Path(sys.argv[1])
content = readme.read_text()

toc_links = re.findall(r"\]\(#([^)]+)\)", content)
if not toc_links:
    raise SystemExit("README.md has no in-document table-of-contents links")

headers = []
for line in content.splitlines():
    match = re.match(r"^(#{1,6})\s+\[(.+?)\]\([^)]+\)\s*$", line)
    if match:
        title = match.group(2).strip()
    else:
        match = re.match(r"^(#{1,6})\s+(.+?)\s*(?:#+\s*)?$", line)
        if not match:
            continue
        title = match.group(2).strip()
    slug = re.sub(r"[^\w\s-]", "", title.lower())
    slug = re.sub(r"\s+", "-", slug).strip("-")
    headers.append(slug)

missing = [link for link in toc_links if link not in headers]
if missing:
    print("Missing README heading anchors for TOC entries:", ", ".join(missing), file=sys.stderr)
    raise SystemExit(1)

print(f"OK README TOC anchors ({len(toc_links)} links)")
PY
