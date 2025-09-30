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

- [x] **CI Workflow** (`ci.yml`) - Comprehensive testing and linting
- [x] **Release Workflow** (`release-changesets.yml`) - Automated releases with Changesets
- [x] **Auto-merge Dependabot** (`auto-merge-dependabot.yml`) - Automatically merge dependency updates
- [x] **Stale Management** (`stale.yml`) - Auto-close inactive issues and PRs
- [x] **PR Labeler** (`labeler.yml`) - Auto-label PRs based on changed files
- [x] **CodeQL Security** (`codeql.yml`) - Security scanning and analysis

### 🏷️ Configuration Files

- [x] **labels.yml** - Standard label configuration for consistent labeling
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

The `labels.yml` file defines a standard set of labels. You can sync these to your repositories using tools like:

- [github-label-sync](https://github.com/Financial-Times/github-label-sync)
- [GitHub CLI with gh-label](https://cli.github.com/manual/gh_label)

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
