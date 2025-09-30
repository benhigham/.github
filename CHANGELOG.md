# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
