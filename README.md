# benhigham/.github

Repository containing my default community health files that apply to all public repositories under my GitHub account.

## What's Included

This repository contains comprehensive community health files and reusable workflows:

### 📄 Community Health Files

- [x] **CODE_OF_CONDUCT.md** - Guidelines for community behavior
- [x] **CODEOWNERS** - Defines ownership of repository code
- [x] **CONTRIBUTING.md** - How to contribute to my projects
- [x] **GOVERNANCE.md** - Project governance structure and processes
- [x] **SECURITY.md** - How to report security vulnerabilities
- [x] **SUPPORT.md** - Where to get help
- [x] **LICENSE.md** - Project licensing information

### 📋 Templates

- [x] **DISCUSSION_TEMPLATE/** - Templates for GitHub Discussions
- [x] **ISSUE_TEMPLATE/** - Enhanced templates for filing issues with validation
  - Bug reports with detailed information gathering
  - Feature requests with priority and effort estimation
  - Codebase improvements with impact assessment
- [x] **PULL_REQUEST_TEMPLATE/** - Templates for pull requests
  - General template with type selection
  - Specialized templates (bug fix, feature, docs, etc.)

### 🤖 Reusable Workflows

- [x] **CI Workflow** (`ci.yml`) - Comprehensive testing and linting with optional matrix testing
- [x] **Release Workflow** (`release-changesets.yml`) - Automated releases with Changesets
- [x] **Auto-merge Dependabot** (`auto-merge-dependabot.yml`) - Automatically merge dependency updates
- [x] **Stale Management** (`stale.yml`) - Auto-close inactive issues and PRs
- [x] **PR Labeler** (`labeler.yml`) - Auto-label PRs based on changed files
- [x] **Sync Labels** (`sync-labels.yml`) - Automatically sync labels when labels.yml changes
- [x] **First-Time Contributor** (`first-time-contributor.yml`) - Welcome new contributors
- [x] **CodeQL Security** (`codeql.yml`) - Security scanning and analysis
- [x] **Dependency Review** (`dependency-review.yml`) - Automated dependency security review in PRs
- [x] **Release Drafter** (`release-drafter.yml`) - Auto-generate release notes and PR descriptions
- [x] **Branch Protection Check** (`branch-protection-check.yml`) - Validate branch protection settings

### 🏷️ Configuration Files

- [x] **labels.yml** - Standard label configuration for consistent labeling (see [LABELS.md](LABELS.md))
- [x] **labeler.yml** - Auto-labeling rules based on file paths
- [x] **dependabot.yml** - Enhanced dependency management with grouping
- [x] **FUNDING.yml** - Funding information

### 🔧 Shared Actions

- [x] **setup-node-pnpm** - Reusable action for Node.js and pnpm setup with caching

### 📚 Documentation Templates

- [x] **ARCHITECTURE.md** - Template for documenting system architecture
- [x] **DEVELOPMENT.md** - Template for development setup and guidelines
- [x] **RELEASING.md** - Template for release process documentation
- [x] **CHANGELOG.md** - Changelog following Keep a Changelog format
- [x] **LABELS.md** - Comprehensive guide to all standard labels

## How It Works

GitHub will use these default files for any public repository under my account that doesn't have its own specific version of these files.

[Learn more about GitHub's community health files](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file).

## Using Reusable Workflows

To use any of the reusable workflows in your repository, create a workflow file that calls them:

### Example: CI Workflow

```yaml
name: CI
on:
  pull_request:
  push:
    branches: [main]

jobs:
  ci:
    uses: benhigham/.github/.github/workflows/ci.yml@main
    with:
      node-version: '20'
      run-lint: true
      run-typecheck: true
      run-test: true
```

### Example: Auto-merge Dependabot

```yaml
name: Auto-merge Dependabot
on:
  pull_request:

jobs:
  auto-merge:
    uses: benhigham/.github/.github/workflows/auto-merge-dependabot.yml@main
    with:
      auto-merge-patch: true
      auto-merge-minor: true
      merge-method: squash
```

### Example: Release with Changesets

```yaml
name: Release
on:
  push:
    branches: [main]

jobs:
  release:
    uses: benhigham/.github/.github/workflows/release-changesets.yml@main
    with:
      node-version: '20'
      needs-build: true
    secrets:
      NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
```

## Using Shared Actions

```yaml
- name: Setup Node.js with pnpm
  uses: benhigham/.github/.github/actions/setup-node-pnpm@main
  with:
    node-version: '20'
    pnpm-version: '8'
```

## Label Management

This repository includes a comprehensive label system with automatic syncing capabilities. See [LABELS.md](LABELS.md) for the complete guide.

### Available Labels

The repository includes **42 standardized labels** organized into categories:

- **Type Labels**: `bug`, `enhancement`, `documentation`, `refactoring`, `performance`, `testing`
- **Priority Labels**: `priority: critical`, `priority: high`, `priority: medium`, `priority: low`
- **Status Labels**: `status: blocked`, `status: in progress`, `status: needs review`, `status: needs testing`, `status: ready`
- **Size Labels**: `size: xs`, `size: s`, `size: m`, `size: l`, `size: xl`, `size: xxl` (auto-assigned)
- **Area Labels**: `area: ci/cd`, `area: security`, `area: api`, `area: ui`
- **Dependency Labels**: `dependencies`, `npm`, `github-actions`, `docker`, `terraform`, `devcontainers`, `git-submodules`, `go`
- **Special Labels**: `breaking change`, `backport`, `chore`
- **Triage Labels**: `triage`, `duplicate`, `invalid`, `wontfix`, `good first issue`, `help wanted`

### Syncing Labels to This Repository

Labels are automatically synced when `.github/labels.yml` is updated via the [Sync Labels workflow](.github/workflows/sync-labels.yml).

### Syncing Labels to Other Repositories

#### Method 1: Using github-label-sync CLI

```bash
# Install globally
npm install -g github-label-sync

# Sync to a repository
github-label-sync --access-token $(gh auth token) \
  --labels .github/labels.yml \
  benhigham/your-repo-name
```

#### Method 2: Using GitHub Actions

Create a workflow in your target repository:

```yaml
# .github/workflows/sync-labels.yml
name: Sync Labels

on:
  schedule:
    - cron: '0 0 * * 0' # Weekly
  workflow_dispatch:

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout labels config
        uses: actions/checkout@v4
        with:
          repository: benhigham/.github
          path: .github-templates

      - name: Sync labels
        uses: micnncim/action-label-syncer@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          manifest: .github-templates/.github/labels.yml
```

#### Method 3: Using GitHub CLI

```bash
# Clone this repo to get the labels
gh repo clone benhigham/.github
cd .github

# Use gh CLI to sync (requires jq)
cat .github/labels.yml | yq -r '.[] | [.name, .color, .description] | @tsv' | \
while IFS=$'\t' read -r name color desc; do
  gh label create "$name" --color "$color" --description "$desc" --repo benhigham/your-repo || \
  gh label edit "$name" --color "$color" --description "$desc" --repo benhigham/your-repo
done
```

For more details, see the [Label Reference Guide](LABELS.md).

## Usage

If you're contributing to any of my repositories, please review the guidelines in these files before submitting issues or pull requests.

### For Repository Owners

To use this as a template for your own `.github` repository:

1. Fork or use this repository as a template
2. Update all references from `benhigham` to your username
3. Customize templates, workflows, and documentation to your needs
4. Update FUNDING.yml with your funding information

## Features

✨ **Enhanced Issue Templates** - Structured forms with validation  
🔄 **Automated Workflows** - CI, releases, dependency management  
🏷️ **Smart Labeling** - Automatic PR labeling based on changes  
🔒 **Security Scanning** - CodeQL integration for security analysis  
📦 **Dependency Management** - Grouped updates with auto-merge  
🧹 **Housekeeping** - Automatic stale issue/PR management  
📖 **Documentation** - Comprehensive templates for all documentation needs

## Contact

If you have questions about these community health files, please [open a discussion](https://github.com/benhigham/.github/discussions) in this repository.

## License

This repository is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
