# AGENTS.md

## Project Snapshot

This repository owns the published user-facing documentation for `set-me-up`.
Keep changes focused on installation, provisioning, trust, adapter, and
workflow docs. Product behavior belongs in the installer, modules, blueprint,
or tests repositories that own it.

## Where To Add Things

- Update `README.md` for user-facing setup, provisioning, trust, and adapter
  guidance.
- Update generated or static documentation assets only when the documented
  behavior has changed in an owning repository.
- Do not change sibling repositories from this checkout unless the routed task
  explicitly spans multiple repos.

## Validation

Run the native validator before finishing:

```bash
scripts/validate.sh --all
```

Focused checks:

```bash
scripts/validate.sh --markdown
scripts/validate.sh --shell
scripts/validate.sh --structure
scripts/validate.sh --links
scripts/validate.sh --mermaid
```

Install Node dependencies before mermaid validation:

```bash
npm ci
```

GitHub Actions runs markdown lint, ShellCheck, structure checks, link
validation, mermaid diagram validation, and the full native validator on every
push and pull request.

## Git

- Use conventional commits.
- Do not add `Co-Authored-By` or AI attribution footers.
- Never force-push `master`.
