# Advanced Usage Guide

Advanced configurations and patterns for reusable workflows.

## 📋 Table of Contents

- [Node.js Version Matrix Testing](#nodejs-version-matrix-testing)
- [Complete CI/CD Pipeline Example](#complete-cicd-pipeline-example)
- [Custom Workflow Combinations](#custom-workflow-combinations)
- [Conditional Workflow Execution](#conditional-workflow-execution)
- [Custom Setup Action Usage](#custom-setup-action-usage)
- [Label Management Strategies](#label-management-strategies)
- [Documentation Template Customization](#documentation-template-customization)
- [Setup Checklists](#setup-checklists)

---

## Node.js Version Matrix Testing

Test your code across multiple Node.js versions simultaneously.

### Basic Matrix Testing

```yaml
name: CI
on: [pull_request, push]

jobs:
  ci:
    uses: benhigham/.github/.github/workflows/ci.yml@main
    with:
      # Test across multiple Node.js versions
      node-version-matrix: '["18", "20", "22"]'
      run-lint: true
      run-typecheck: true
      run-test: true
```

### How It Works

- When `node-version-matrix` is specified, it overrides `node-version` for the test job
- Lint and typecheck run once on the first version in the matrix
- Tests run on all specified versions in parallel
- If any version fails, the entire job fails

### Best Practices

- **Minimum**: Test on your target Node.js version only
- **Recommended**: Test on current LTS and latest stable
- **Comprehensive**: Test on all supported LTS versions
- **Example**: `["18", "20", "22"]` covers Node 18 LTS, Node 20 LTS, and Node 22

### When to Use Matrix Testing

✅ **Use for:**

- Libraries published to npm
- CLI tools distributed widely
- Projects claiming multi-version support
- Before major releases

❌ **Skip for:**

- Internal applications with fixed Node version
- Quick prototypes or personal projects
- When CI time is a concern

---

## Complete CI/CD Pipeline Example

Full-featured workflow combining multiple reusable workflows.

```yaml
name: Complete CI/CD Pipeline
on:
  pull_request:
  push:
    branches: [main]
  schedule:
    - cron: '0 0 * * 1'  # Weekly security scan

permissions:
  contents: write
  pull-requests: write
  security-events: write
  issues: write

jobs:
  # Run comprehensive CI checks
  ci:
    uses: benhigham/.github/.github/workflows/ci.yml@main
    with:
      node-version: '20'
      run-lint: true
      run-typecheck: true
      run-test: true
      run-build: true
      upload-coverage: true
      coverage-path: 'coverage'

  # Security scanning with CodeQL
  security:
    uses: benhigham/.github/.github/workflows/codeql.yml@main
    with:
      languages: 'javascript,typescript'
      queries: 'security-and-quality'

  # Review dependencies in PRs
  dependency-review:
    if: github.event_name == 'pull_request'
    uses: benhigham/.github/.github/workflows/dependency-review.yml@main
    with:
      fail-on-severity: 'high'
      comment-summary-in-pr: 'always'

  # Label PRs automatically
  label-pr:
    if: github.event_name == 'pull_request'
    uses: benhigham/.github/.github/workflows/labeler.yml@main
    with:
      enable-size-labeling: true
      enable-path-labeling: true

  # Auto-merge Dependabot PRs
  dependabot-auto-merge:
    if: github.actor == 'dependabot[bot]'
    needs: [ci, security]
    uses: benhigham/.github/.github/workflows/auto-merge-dependabot.yml@main
    with:
      enable-auto-merge: true
      merge-method: 'squash'
      auto-merge-patch: true
      auto-merge-minor: true
      auto-merge-major: false

  # Release to npm (only on main branch push)
  release:
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'
    needs: [ci, security]
    uses: benhigham/.github/.github/workflows/release-changesets.yml@main
    with:
      node-version: '20'
      needs-build: true
      version-command: 'pnpm changeset version'
      publish-command: 'pnpm changeset publish'
    secrets:
      NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
```

---

## Custom Workflow Combinations

### For npm Packages

```yaml
name: Package Workflow
on:
  pull_request:
  push:
    branches: [main]

jobs:
  ci:
    uses: benhigham/.github/.github/workflows/ci.yml@main
    with:
      node-version-matrix: '["18", "20", "22"]'
      run-build: true

  release:
    if: github.ref == 'refs/heads/main'
    needs: ci
    uses: benhigham/.github/.github/workflows/release-changesets.yml@main
    secrets:
      NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
```

### For Web Applications

```yaml
name: Web App Workflow
on:
  pull_request:
  push:
    branches: [main]

jobs:
  ci:
    uses: benhigham/.github/.github/workflows/ci.yml@main
    with:
      run-lint: true
      run-typecheck: true
      run-test: true
      run-build: true

  security:
    uses: benhigham/.github/.github/workflows/codeql.yml@main

  dependency-review:
    if: github.event_name == 'pull_request'
    uses: benhigham/.github/.github/workflows/dependency-review.yml@main
```

### For Documentation Sites

```yaml
name: Documentation Workflow
on:
  pull_request:
  push:
    branches: [main]

jobs:
  lint:
    uses: benhigham/.github/.github/workflows/ci.yml@main
    with:
      run-lint: true
      run-typecheck: false
      run-test: false

  label:
    if: github.event_name == 'pull_request'
    uses: benhigham/.github/.github/workflows/labeler.yml@main

  stale:
    if: github.event_name == 'schedule'
    uses: benhigham/.github/.github/workflows/stale.yml@main
```

---

## Conditional Workflow Execution

### Run Only on Specific Branches

```yaml
jobs:
  ci:
    if: github.ref == 'refs/heads/main' || startsWith(github.ref, 'refs/heads/release/')
    uses: benhigham/.github/.github/workflows/ci.yml@main
```

### Skip Workflows for Draft PRs

```yaml
jobs:
  ci:
    if: github.event.pull_request.draft == false
    uses: benhigham/.github/.github/workflows/ci.yml@main
```

### Run Only on Specific File Changes

```yaml
on:
  pull_request:
    paths:
      - 'src/**'
      - 'package.json'
      - 'pnpm-lock.yaml'
```

### Actor-Based Conditionals

```yaml
jobs:
  dependabot:
    if: github.actor == 'dependabot[bot]'
    uses: benhigham/.github/.github/workflows/auto-merge-dependabot.yml@main

  regular-pr:
    if: github.actor != 'dependabot[bot]'
    uses: benhigham/.github/.github/workflows/ci.yml@main
```

---

## Custom Setup Action Usage

### Basic Usage

```yaml
steps:
  - uses: benhigham/.github/.github/actions/setup-node-pnpm@main
```

### With Custom Versions

```yaml
steps:
  - uses: benhigham/.github/.github/actions/setup-node-pnpm@main
    with:
      node-version: '20'
      pnpm-version: '8'
```

### With Deep Git History

```yaml
steps:
  - uses: benhigham/.github/.github/actions/setup-node-pnpm@main
    with:
      fetch-depth: '0'  # Full history for semantic-release, etc.
```

### Accessing Cache Hit Output

```yaml
steps:
  - uses: benhigham/.github/.github/actions/setup-node-pnpm@main
    id: setup

  - name: Check cache
    run: echo "Cache hit: ${{ steps.setup.outputs.cache-hit }}"
```

---

## Label Management Strategies

### Syncing Labels Across Multiple Repositories

#### Method 1: Using github-label-sync CLI

```bash
# Install globally
npm install -g github-label-sync

# Sync to a repository
github-label-sync --access-token $(gh auth token) \
  --labels .github/labels.yml \
  benhigham/your-repo-name

# Sync to multiple repositories
for repo in repo1 repo2 repo3; do
  github-label-sync --access-token $(gh auth token) \
    --labels .github/labels.yml \
    benhigham/$repo
done
```

#### Method 2: Using GitHub Actions in Target Repo

```yaml
# .github/workflows/sync-labels.yml in your target repository
name: Sync Labels

on:
  schedule:
    - cron: '0 0 * * 0'  # Weekly
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

# Use gh CLI to sync (requires yq)
cat .github/labels.yml | yq -r '.[] | [.name, .color, .description] | @tsv' | \
while IFS=$'\t' read -r name color desc; do
  gh label create "$name" --color "$color" --description "$desc" --repo benhigham/your-repo || \
  gh label edit "$name" --color "$color" --description "$desc" --repo benhigham/your-repo
done
```

### Custom Label Configuration

Add project-specific labels while keeping standard ones:

```yaml
# your-repo/.github/labels.yml
# Include standard labels
- name: 'bug'
  color: 'd73a4a'
  description: "Something isn't working"

# Add your custom labels
- name: 'needs-design'
  color: 'e99695'
  description: 'Waiting for design input'

- name: 'backend'
  color: '0052cc'
  description: 'Backend related changes'
```

---

## Documentation Template Customization

### Quick Customization Checklist

When copying documentation templates, search and replace:

- `[repository-name]` → Your actual repository name
- `[package-name]` → Your npm package name
- `[username]` → Your GitHub username or organization

### Template-Specific Customizations

#### ARCHITECTURE.md

1. Replace the example architecture diagram
2. Fill in your actual tech stack
3. Document your design patterns
4. Add security considerations specific to your project

#### DEVELOPMENT.md

1. Update prerequisites with actual versions
2. Customize installation steps
3. Update available scripts to match your package.json
4. Add project-specific setup instructions

#### RELEASING.md

1. Adjust release schedule to your cadence
2. Customize changeset guidelines
3. Update version strategy if not using Changesets
4. Add deployment steps if applicable

---

## Setup Checklists

### Initial Repository Setup

```markdown
- [ ] Copy required workflows to `.github/workflows/`
- [ ] Copy `.github/labels.yml` and run sync
- [ ] Copy and customize `.github/labeler.yml`
- [ ] Copy documentation templates (ARCHITECTURE, DEVELOPMENT, RELEASING)
- [ ] Add secrets (NPM_TOKEN, etc.)
- [ ] Enable auto-merge in repository settings
- [ ] Configure branch protection on main
- [ ] Set up required status checks
- [ ] Enable Dependabot alerts
- [ ] Enable CodeQL scanning
- [ ] Update README with workflow badges
```

### Per-Workflow Checklist

#### CI Workflow

```markdown
- [ ] Create `.github/workflows/ci.yml`
- [ ] Configure inputs (lint, typecheck, test, build)
- [ ] Add to required status checks
- [ ] Test with a PR
```

#### Release Workflow

```markdown
- [ ] Install Changesets: `pnpm add -D @changesets/cli`
- [ ] Initialize: `pnpm changeset init`
- [ ] Configure `.changeset/config.json`
- [ ] Add NPM_TOKEN to secrets
- [ ] Create `.github/workflows/release.yml`
- [ ] Test with a changeset
```

#### Security Workflows

```markdown
- [ ] Enable CodeQL in repo settings
- [ ] Create `.github/workflows/codeql.yml`
- [ ] Create `.github/workflows/dependency-review.yml`
- [ ] Configure severity thresholds
- [ ] Test on a PR
```

---

## 🔗 Related Documentation

- [Quick Reference](QUICK_REFERENCE.md) - Basic workflow syntax
- [Troubleshooting](TROUBLESHOOTING.md) - Common issues and solutions
- [README](README.md) - Overview and getting started
- [Labels Guide](LABELS.md) - Complete label reference

---

**Last Updated**: 2025-10-01

---

## 🔗 Navigation

- [← Back to Quick Reference](QUICK_REFERENCE.md)
- [← Back to README](README.md)
- [Getting Started Guide →](GETTING_STARTED.md)
- [Troubleshooting →](TROUBLESHOOTING.md)
- [Labels Reference →](LABELS.md)
- [Contributing Guide →](CONTRIBUTING.md)
