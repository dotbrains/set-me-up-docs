# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Purpose

This is a documentation repository for `set-me-up`, a macOS development environment automation toolkit. It contains:
- Main documentation in `.github/README.md`
- Preview images and assets
- No executable code or build system

## Key Concepts

### set-me-up Architecture
- **Core**: The `smu` script orchestrates the entire setup process
- **Installer**: Located at [set-me-up-installer](https://github.com/dotbrains/set-me-up-installer), handles initial installation
- **Blueprint**: Template repo at [set-me-up-blueprint](https://github.com/dotbrains/set-me-up-blueprint) provides base setup
- **Modules**: Automated installation scripts for different tools/environments (app_store, casks, php, etc.)
- **rcm Integration**: Uses [thoughtbot's rcm](https://github.com/thoughtbot/rcm) for dotfile management via symlinks

### Module System
Modules are bash scripts that automate software installation. Key modules include:
- `base`: Foundation module that symlinks dotfiles and ensures brew is installed
- `app_store`: Mac App Store applications via brewfile
- `casks`: Homebrew casks for GUI applications
- Language-specific modules (e.g., `php`)

### Customization Mechanisms
1. **Hooks**: `before.sh` and `after.sh` files in module directories
2. **rcm Tags**: Create `dotfiles/tag-<name>` directories to override default files
3. **rcrc Configuration**: Controls which tags are active and how dotfiles are managed

## Documentation Workflow

### Viewing Documentation
```bash
# Main README
cat .github/README.md

# View preview image
open .github/preview.png
```

### Editing Documentation
When updating documentation:
1. Edit `.github/README.md` for main content
2. Maintain consistent structure with existing sections
3. Use relative links for internal references to other set-me-up repos

### Git Workflow
```bash
# Check status
git status

# View recent changes
git --no-pager log --oneline -10

# View diff
git --no-pager diff
```

## Related Repositories

This documentation references three interconnected repositories:
- **set-me-up-installer**: Entry point with install script and `smu` command
- **set-me-up-blueprint**: Template for user customizations
- **set-me-up**: Main repository (inferred from context)

When editing docs, ensure cross-repository references remain accurate.
