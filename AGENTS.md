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

When this repo is edited from the aggregate `set-me-up` checkout, also run the
root changed-repo validation if root routing or executable docs are involved:

```bash
scripts/validate-repos.sh --changed
```

## Git

- Use conventional commits.
- Do not add `Co-Authored-By` or AI attribution footers.
- Never force-push `master`.
