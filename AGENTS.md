# AI Agent Instructions

This document provides comprehensive guidance for AI coding assistants working on this `.github` repository. This is a special GitHub repository that contains default community health files, reusable workflows, and standardized configurations for all repositories under the `benhigham` organization.

## Repository Purpose & Context

This repository serves as a **centralized template and automation hub** for GitHub project management. It contains:

- **Community health files** that apply as defaults to other repositories
- **Reusable GitHub Actions workflows** for CI/CD, releases, and automation
- **Standardized configurations** for labels, Dependabot, and PR labeling
- **Template documentation** for projects to copy and customize
- **Custom GitHub Actions** for common setup tasks

## Tech Stack & Tools

### Core Technologies

- **YAML**: All workflows, configurations, and templates
- **Markdown**: Documentation and templates
- **GitHub Actions**: Automation and CI/CD
- **Conventional Commits**: `feat:`, `fix:`, `chore:`, `docs:`, etc.
- **Semantic Versioning**: MAJOR.MINOR.PATCH
- **Keep a Changelog**: Changelog format with [Unreleased], [Version] sections

### Key Tools & Actions

- **pnpm**: Package manager (not npm or yarn)
- **Changesets**: For versioning and releases (see `RELEASING.md`)
- **Dependabot**: Dependency updates (7 ecosystems: npm, github-actions, docker, terraform, devcontainers, gitsubmodule, gomod)
- **CodeQL**: Security scanning

## File Organization & Structure

### Root Level Files

```text
/
├── CODE_OF_CONDUCT.md         # Applies to all repos without their own
├── CONTRIBUTING.md             # Applies to all repos without their own
├── SECURITY.md                 # Applies to all repos without their own
├── SUPPORT.md                  # Applies to all repos without their own
├── GOVERNANCE.md               # This repo only
├── LICENSE.md                  # This repo only
├── README.md                   # This repo only
├── CHANGELOG.md                # This repo only
├── ARCHITECTURE.md             # Template for other repos
├── DEVELOPMENT.md              # Template for other repos
├── RELEASING.md                # Template for other repos
├── QUICK_REFERENCE.md          # Quick reference guide
└── LABELS.md                   # Label documentation
```

### .github Directory Structure

```text
.github/
├── workflows/                  # Reusable workflow definitions
│   ├── ci.yml                 # CI workflow with lint/test/build
│   ├── release-changesets.yml # Release automation
│   ├── auto-merge-dependabot.yml
│   ├── stale.yml
│   ├── labeler.yml
│   ├── sync-labels.yml
│   ├── first-time-contributor.yml
│   └── codeql.yml
├── actions/                    # Custom composite actions
│   └── setup-node-pnpm/
│       └── action.yml
├── ISSUE_TEMPLATE/            # Issue form templates (YAML)
├── PULL_REQUEST_TEMPLATE/     # PR markdown templates
├── DISCUSSION_TEMPLATE/       # Discussion form templates (YAML)
├── dependabot.yml             # Dependabot configuration
├── labels.yml                 # Label definitions (37 labels)
├── labeler.yml                # Path-based PR labeling rules
└── FUNDING.yml                # Funding info
```

## Code Standards & Conventions

### YAML Files

**Workflow Conventions:**

- Use `workflow_call` for reusable workflows
- Always include timeout limits (5-30 minutes typical)
- Use concurrency groups for workflows that shouldn't overlap
- Include helpful descriptions for all inputs
- Use kebab-case for input names: `node-version`, `run-lint`
- Set appropriate default values for optional inputs

**Example workflow structure:**

```yaml
name: Workflow Name

on:
  workflow_call:
    inputs:
      input-name:
        description: Clear description
        type: string|boolean|number
        default: 'default-value'
        required: false

permissions:
  contents: read  # Always use minimal permissions

jobs:
  job-name:
    name: Display Name
    runs-on: ubuntu-latest
    timeout-minutes: 10  # Always include
    steps:
      - name: Step name
        # ...
```

**Dependabot Configuration:**

- Commit message prefix: `chore`
- Include `scope` in commit messages
- Weekly schedule for all ecosystems
- Group minor and patch updates together
- Assign to: `benhigham`

**Label Configuration (labels.yml):**

- 37 standard labels across 8 categories
- Colors must be hex without `#`
- Always include description
- Categories: type, priority, status, size, area, dependencies, special, triage

### Markdown Files

**Documentation Style:**

- Use ATX-style headers (`#`, `##`, not underlines)
- Include table of contents for docs >100 lines
- Use code blocks with language identifiers: ` ```yaml `, ` ```bash `
- Use emoji sparingly but consistently (✅, ❌, 🎯, 📋, etc.)
- Include concrete examples, not just abstract descriptions
- Use proper heading hierarchy (don't skip levels)

**Template Files (ARCHITECTURE.md, DEVELOPMENT.md, RELEASING.md):**

- Start with: `> **Note**: This is a template file. When creating a new repository, copy this file and customize it for your specific project.`
- Use placeholders: `[repository-name]`, `[package-name]`
- Include TODO comments where customization is needed
- Provide multiple examples for different use cases

**Changelog (CHANGELOG.md):**

- Follow Keep a Changelog format strictly
- Categories: Added, Changed, Deprecated, Removed, Fixed, Security
- Only document consumer-facing changes (not internal refactoring)
- Use present tense: "Add feature" not "Added feature"
- Be specific with version numbers and dates: `[2.0.0] - 2024-09-30`
- Consumer-focused, not developer-focused

### Commit Messages

**Conventional Commits Format:**

```text
<type>: <description>

[optional body]

[optional footer(s)]
```

**Types:**

- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation only
- `chore:` - Maintenance (dependencies, configs)
- `refactor:` - Code refactoring
- `test:` - Adding/updating tests
- `ci:` - CI/CD changes
- `perf:` - Performance improvements

**Examples:**

```
feat: add terraform support to dependabot config
fix: correct labeler workflow permissions
docs: update README with new workflow examples
chore: bump actions/checkout to v5
```

## Label System

### Label Categories & Usage

**Type Labels** (what kind of work):

- `bug`, `enhancement`, `documentation`, `refactoring`, `performance`, `testing`

**Priority Labels** (urgency):

- `priority: critical`, `priority: high`, `priority: medium`, `priority: low`

**Status Labels** (current state):

- `status: blocked`, `status: in progress`, `status: needs review`, `status: needs testing`, `status: ready`

**Size Labels** (auto-assigned by PR size labeler):

- `size: xs` (1-10 lines), `size: s` (11-50), `size: m` (51-200), `size: l` (201-500), `size: xl` (501-1000), `size: xxl` (1000+)

**Area Labels** (what part of system):

- `area: ci/cd`, `area: security`, `area: api`, `area: ui`

**Dependency Labels**:

- `dependencies`, `npm`, `github-actions`, `docker`, `terraform`, `devcontainers`, `git-submodules`, `go`

**Special Labels**:

- `breaking change`, `backport`, `chore`

**Triage Labels**:

- `triage`, `duplicate`, `invalid`, `wontfix`, `good first issue`, `help wanted`

### When Adding New Labels

1. Add to `.github/labels.yml` following the existing structure
2. Update `LABELS.md` with description and when to use
3. Consider adding to `.github/labeler.yml` if path-based auto-labeling makes sense
4. Sync will happen automatically on push to main

## Workflow Patterns

### Reusable Workflow Design

**Required Elements:**

```yaml
on:
  workflow_call:
    inputs:  # All configurable options
    secrets: # Only if needed (e.g., NPM_TOKEN)

concurrency:  # Prevent parallel runs
  group: workflow-name-${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true|false

permissions:  # Minimal required permissions
  contents: read
```

**Common Inputs:**

- `node-version`, `pnpm-version` - Tool versions (optional, reads from package.json if not specified)
- `run-*` - Boolean flags to enable/disable steps
- `*-command` - Customizable commands with sensible defaults

**Job Structure:**

- Name: Clear, descriptive display name
- `runs-on: ubuntu-latest` (always)
- `timeout-minutes: 5-30` (always include)
- Checkout → Setup tools → Install deps → Run commands

### Action Inputs

**For setup-node-pnpm action:**

```yaml
- uses: benhigham/.github/.github/actions/setup-node-pnpm@main
  with:
    node-version: '20'      # Optional
    pnpm-version: '8'       # Optional
    fetch-depth: '1'        # Optional
```

**This action:**

1. Checks out repository
2. Sets up pnpm
3. Sets up Node.js with caching
4. Installs dependencies with `--frozen-lockfile`

## Common Tasks & Examples

### Adding a New Reusable Workflow

1. Create in `.github/workflows/` with descriptive name
2. Use `workflow_call` trigger
3. Define clear inputs with descriptions
4. Include timeout and permissions
5. Add to README.md "Using Reusable Workflows" section
6. Add to QUICK_REFERENCE.md with usage example
7. Test in a consumer repository before merging

### Adding a New Label

1. Edit `.github/labels.yml`:

```yaml
- name: 'new-label'
  color: 'hex-color'  # No # prefix
  description: 'Clear description'
```

2. Update `LABELS.md` with the label in appropriate category
3. Commit and push - sync happens automatically

### Adding a New Issue Template

1. Create YAML file in `.github/ISSUE_TEMPLATE/`
2. Use GitHub form schema:

```yaml
name: Template Name
description: Template description
title: '[Prefix] '
labels: ['label1', 'label2']
assignees: ['benhigham']
body:
  - type: input|textarea|dropdown|checkboxes
    id: field-id
    attributes:
      label: Field Label
      description: Help text
    validations:
      required: true|false
```

3. Update README.md to mention new template

### Updating Dependabot

1. Edit `.github/dependabot.yml`
2. Add new ecosystem following existing pattern:

```yaml
- package-ecosystem: 'ecosystem-name'
  directory: '/'
  schedule:
    interval: 'weekly'
  assignees:
    - 'benhigham'
  labels:
    - 'dependencies'
    - 'ecosystem-specific-label'
  commit-message:
    prefix: 'chore'
    include: 'scope'
```

3. Add corresponding label to `.github/labels.yml` if new ecosystem
4. Update CHANGELOG.md under [Unreleased]

## Testing & Validation

### Before Submitting Changes

**For Workflow Changes:**

- Test in a separate test repository first
- Use `workflow_dispatch` for manual testing
- Check all input combinations work
- Verify timeout settings are appropriate
- Review logs for errors or warnings

**For Configuration Changes:**

- Validate YAML syntax (use IDE or `yamllint`)
- Check all references are correct
- Test label sync in this repo
- Verify Dependabot config in GitHub UI

**For Documentation Changes:**

- Check markdown rendering in GitHub preview
- Verify all links work
- Ensure examples are accurate and current
- Check for typos and formatting consistency

### Common Pitfalls

❌ **Don't:**

- Use `npm` - always use `pnpm`
- Use old action versions
- Omit timeout values on jobs
- Use overly broad permissions
- Skip validation requirements on forms

✅ **Do:**

- Use semantic commit messages
- Include clear descriptions on all inputs
- Test workflows before merging
- Keep documentation up to date
- Use minimal necessary permissions
- Follow existing patterns and conventions
- Update CHANGELOG.md for user-facing changes

## Repository Maintenance

### Regular Tasks

**Weekly:**

- Review Dependabot PRs
- Check for security advisories
- Monitor workflow run times

**Monthly:**

- Review and update documentation
- Check for deprecated GitHub Actions
- Update examples if APIs changed

**Quarterly:**

- Major version updates for key dependencies
- Review and improve workflows based on usage
- Clean up stale templates or configurations

### Version Management

**This repository follows Semantic Versioning:**

- **MAJOR**: Breaking changes to workflows or templates
- **MINOR**: New workflows, templates, or features
- **PATCH**: Bug fixes, documentation updates

**When to Release:**

- Accumulate changes in [Unreleased] section
- Release minor versions for new workflows/features
- Release patch versions for fixes
- Tag releases: `v2.1.0`, `v2.1.1`, etc.

## Special Considerations

### Files That Apply to Other Repos

These files are used as defaults by other repositories:

- `CODE_OF_CONDUCT.md`
- `CONTRIBUTING.md`
- `SECURITY.md`
- `SUPPORT.md`
- `FUNDING.yml`
- `.github/ISSUE_TEMPLATE/*`
- `.github/PULL_REQUEST_TEMPLATE/*`
- `.github/DISCUSSION_TEMPLATE/*`

**When editing these:** Consider they may be inherited by many repositories. Breaking changes should be avoided or clearly documented.

### Files That Don't Apply to Other Repos

These files are local to this repository only:

- `README.md`, `CHANGELOG.md`, `LICENSE.md`
- `GOVERNANCE.md`, `LABELS.md`, `QUICK_REFERENCE.md`
- `.github/workflows/*` (called explicitly by other repos)
- `.github/dependabot.yml`, `.github/labels.yml`, `.github/labeler.yml`

**When editing these:** Changes only affect this repository unless other repos explicitly call the workflows.

## Getting Help & Resources

### Documentation

- [QUICK_REFERENCE.md](QUICK_REFERENCE.md) - Quick workflow usage guide
- [LABELS.md](LABELS.md) - Complete label documentation
- [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute
- [CHANGELOG.md](CHANGELOG.md) - History of changes

### External References

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Reusable Workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
- [Keep a Changelog](https://keepachangelog.com/)
- [Semantic Versioning](https://semver.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Community Health Files](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file)

### Key Patterns & Examples

**Calling a reusable workflow:**

```yaml
jobs:
  ci:
    uses: benhigham/.github/.github/workflows/ci.yml@main
    with:
      node-version: '20'
      run-lint: true
```

**Using the setup action:**

```yaml
- uses: benhigham/.github/.github/actions/setup-node-pnpm@main
  with:
    node-version: '20'
```

**Label definition:**

```yaml
- name: 'label-name'
  color: 'hex-without-hash'
  description: 'Clear description of when to use'
```

## Project Owner

- **Maintainer**: Ben Higham (@benhigham)
- **License**: MIT
- **Repository**: <https://github.com/benhigham/.github>

---

**Last Updated**: 2025-10-01
**For Questions**: Open an issue or discussion in this repository
