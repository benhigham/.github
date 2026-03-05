# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Add PR Title Check workflow for enforcing conventional commit format in pull request titles
- Add workflow decision tree in README.md for choosing appropriate workflows by project type
- Add troubleshooting guide in QUICK_REFERENCE.md with solutions for common CI, release, and workflow issues
- Add missing labels to labels.yml:
  - `security` - Security-related issues or improvements
  - `branch-protection` - Related to branch protection configuration
  - `stale` - Automatically applied to inactive issues and PRs
- Add workflow description comments to all reusable workflows for better discoverability
- Add duplicate issue detection in branch-protection-check.yml to prevent issue spam
- Add Dependency Review workflow with configurable inputs (fail-on-severity, license checking)
- Add Branch Protection Check workflow to validate branch protection settings weekly
- Add Node.js version matrix testing support in CI workflow (test across multiple Node versions)
- Add five new dependency labels for comprehensive Dependabot coverage:
  - `docker` - Docker/container dependency updates
  - `terraform` - Terraform dependency updates
  - `devcontainers` - Development container dependency updates
  - `git-submodules` - Git submodule updates
  - `go` - Go module dependency updates

### Changed

- Consolidate auto-merge workflow steps from 3 duplicate steps into 1 with composite conditional
- Optimize first-time contributor detection to use `total_count` instead of fetching all items
- Replace deprecated `actions/first-interaction@v3` with `actions/github-script@v7` in first-time contributor workflow
- Enhance CI workflow with optional Node.js version matrix testing capability
- Enhance Dependabot configuration with five additional package ecosystems
- Update QUICK_REFERENCE.md with new workflows, enhanced documentation, and troubleshooting guide
- Update README.md with workflow decision tree, new workflows, and usage guidelines
- Refactor all workflows to use the custom `setup-node-pnpm` action
- Apply timeout constraints to all workflows for better resource management
- Update label documentation to reflect 45 total labels (increased from 42)
- Configure concurrency groups for all workflows for optimal resource usage
- Complete CONTRIBUTING.md with development setup, testing, and validation guidance
- Upload coverage reports only on successful test runs (changed from uploading regardless of test outcome)

### Removed

- Remove stale planning documents (ANALYSIS.md, TASKS.md)

## [2.0.0] - 2024-09-30

### Added

- Enhanced Dependabot configuration with npm support and dependency grouping rules
- New reusable CI workflow for comprehensive testing and linting
- Auto-merge workflow for Dependabot PRs with configurable rules
- Stale issue/PR management workflow for automated housekeeping
- PR labeler workflow for automatic labeling by size and changed paths
- CodeQL security scanning workflow for vulnerability detection
- Standardized labels configuration with 40+ labels across multiple categories
- Path-based PR labeling configuration (labeler.yml)
- Comprehensive documentation templates:
  - ARCHITECTURE.md - System architecture documentation template
  - DEVELOPMENT.md - Development setup and guidelines template
  - RELEASING.md - Release process and versioning guide
  - QUICK_REFERENCE.md - Quick workflow usage reference

### Changed

- Improved setup-node-pnpm action with 5-minute timeout on install step
- Enhanced Dependabot to monitor both GitHub Actions and npm packages
- Enhanced issue templates with better validation, new fields, and contributor checklists
- Updated README.md with comprehensive documentation of all features and workflows

### Fixed

- Added missing timeout to prevent hanging builds on npm registry issues

## [1.0.0] - 2025-03-31

### Added

- Initial release with community health files
- Code of Conduct (CODE_OF_CONDUCT.md)
- Contributing guidelines (CONTRIBUTING.md)
- Governance documentation (GOVERNANCE.md)
- Security policy (SECURITY.md)
- Support information (SUPPORT.md)
- Issue templates (bug report, feature request, codebase improvement)
- Pull request templates (multiple types: bug fix, feature, documentation, etc.)
- Discussion templates (general, Q&A, announcements, ideas, show and tell)
- Release workflow for changesets (release-changesets.yml)
- Reusable setup action for Node.js and pnpm (setup-node-pnpm)
- CODEOWNERS file
- Funding configuration (FUNDING.yml)
- Basic Dependabot configuration for GitHub Actions

[Unreleased]: https://github.com/benhigham/.github/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/benhigham/.github/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/benhigham/.github/releases/tag/v1.0.0
