#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

run_markdown=0
run_shell=0
run_structure=0
run_links=0
run_mermaid=0

usage() {
    printf "Usage: %s [--all|--markdown|--shell|--structure|--links|--mermaid]\\n" "$0" >&2
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --all)
            run_markdown=1
            run_shell=1
            run_structure=1
            run_links=1
            run_mermaid=1
            ;;
        --markdown)
            run_markdown=1
            ;;
        --shell)
            run_shell=1
            ;;
        --structure)
            run_structure=1
            ;;
        --links)
            run_links=1
            ;;
        --mermaid)
            run_mermaid=1
            ;;
        -h | --help)
            usage
            exit 0
            ;;
        *)
            usage
            exit 2
            ;;
    esac
    shift
done

if [ "$run_markdown$run_shell$run_structure$run_links$run_mermaid" = "00000" ]; then
    run_markdown=1
    run_shell=1
    run_structure=1
    run_links=1
    run_mermaid=1
fi

validate_markdown() {
    npx --yes markdownlint-cli2 "**/*.md" "#node_modules"
    printf "OK markdown lint\\n"
}

validate_shell() {
    local script

    while IFS= read -r -d '' script; do
        bash -n "$script"
    done < <(find scripts -type f -name '*.sh' -print0)

    if command -v shellcheck >/dev/null 2>&1; then
        shellcheck scripts/*.sh
    else
        printf "SKIP shellcheck: not installed\\n"
    fi

    printf "OK shell syntax\\n"
}

validate_structure() {
    local file

    for file in \
        README.md \
        AGENTS.md \
        LICENSE \
        preview.png \
        scripts/validate.sh \
        scripts/check-readme-toc.sh \
        scripts/check-mermaid.sh \
        scripts/check-mermaid.mjs \
        package.json \
        package-lock.json \
        .markdownlint-cli2.yaml \
        .github/workflows/ci.yml; do
        [ -e "$file" ] || {
            printf "Missing required file: %s\\n" "$file" >&2
            exit 1
        }
    done

    [ -x scripts/validate.sh ] || {
        printf "scripts/validate.sh must be executable\\n" >&2
        exit 1
    }
    [ -x scripts/check-readme-toc.sh ] || {
        printf "scripts/check-readme-toc.sh must be executable\\n" >&2
        exit 1
    }
    [ -x scripts/check-mermaid.sh ] || {
        printf "scripts/check-mermaid.sh must be executable\\n" >&2
        exit 1
    }

    if grep -R --include='*.md' -F 'dotbrains/' . >/dev/null 2>&1; then
        printf "Found stale dotbrains/ documentation links\\n" >&2
        exit 1
    fi

    scripts/check-readme-toc.sh
    printf "OK repository structure\\n"
}

validate_links() {
    if command -v lychee >/dev/null 2>&1; then
        lychee --no-progress --exclude-all-private README.md AGENTS.md
        printf "OK external links (lychee)\\n"
        return 0
    fi

    npx --yes markdown-link-check@3.14.2 README.md --quiet
    printf "OK external links (markdown-link-check)\\n"
}

validate_mermaid() {
    scripts/check-mermaid.sh
}

if [ "$run_markdown" -eq 1 ]; then
    validate_markdown
fi
if [ "$run_shell" -eq 1 ]; then
    validate_shell
fi
if [ "$run_structure" -eq 1 ]; then
    validate_structure
fi
if [ "$run_links" -eq 1 ]; then
    validate_links
fi
if [ "$run_mermaid" -eq 1 ]; then
    validate_mermaid
fi
