# Quick Reference: Reusable Workflows

> **Note**: All Node.js workflows internally use the custom `setup-node-pnpm` action for consistent environment setup. You don't need to call this action directly - it's automatically used by the workflows.

## 🔄 CI Workflow

**File**: `.github/workflows/ci.yml`

```yaml
name: CI
on: [pull_request, push]

jobs:
  ci:
    uses: benhigham/.github/.github/workflows/ci.yml@main
    with:
      node-version: '20'           # Optional: Node.js version
      pnpm-version: '8'            # Optional: pnpm version
      run-lint: true               # Run linting
      run-typecheck: true          # Run type checking
      run-test: true               # Run tests
      run-build: false             # Run build (optional)
```

---

## 🔧 Troubleshooting

### CI Workflow Issues

**Problem: "Module not found" errors**

```
Error: Cannot find module 'package-name'
```

**Solution:**

- Ensure `pnpm-lock.yaml` is committed and up-to-date
- Run `pnpm install` locally and commit any lockfile changes
- Check that the package is listed in `package.json` dependencies

**Problem: Timeout on test job**

```
Error: The operation was canceled.
```

**Solution:**

- Increase `timeout-minutes` in your workflow call
- Optimize your tests (split into smaller suites, remove unnecessary waits)
- Check for infinite loops or hanging promises

**Problem: Cache not working**

```
Cache not found for input keys: ...
```

**Solution:**

- Verify the cache key pattern in setup-node action
- Check if you've recently changed Node.js or pnpm versions
- First run after version change won't have cache (expected)

### Release Workflow Issues

**Problem: "No permission to publish to npm"**

```
Error: 403 Forbidden - PUT https://registry.npmjs.org/package-name
```

**Solution:**

- Verify `NPM_TOKEN` is set in repository secrets
- Ensure the token has publish permissions
- Check the package name isn't taken (for first publish)
- Verify you're a collaborator on existing package

**Problem: "No changesets found"**

```
Error: No changesets present
```

**Solution:**

- Run `pnpm changeset` before committing changes
- Ensure `.changeset/*.md` files are committed
- Check that `.changeset/config.json` is properly configured

**Problem: Build step failing during release**

```
Error: Command failed: pnpm run build
```

**Solution:**

- Test build locally first: `pnpm run build`
- Ensure all dependencies are in `dependencies`, not `devDependencies`
- Check that build outputs are in `.npmignore` or `files` in package.json

### Dependency Review Issues

**Problem: False positives on vulnerability scan**

```
Error: Dependency review detected vulnerabilities
```

**Solution:**

- Review the vulnerability details in the PR comment
- If false positive, adjust `fail-on-severity` to `high` or `critical`
- Use `allow-licenses` to permit specific packages if needed
- Consider adding to allow list if it's a known safe dependency

### Auto-merge Not Working

**Problem: Dependabot PRs not merging automatically**

```
No auto-merge triggered
```

**Solution:**

- Ensure required status checks are passing
- Verify branch protection allows auto-merge
- Check that `auto-merge-patch`, `auto-merge-minor`, or `auto-merge-major` is `true`
- Ensure the PR is from `dependabot[bot]` (check actor)

**Problem: "Required reviews not met"**

```
Error: Pull request is not mergeable
```

**Solution:**

- Configure branch protection to not require reviews for Dependabot
- Or set up code owners to auto-approve Dependabot PRs
- Or manually approve before auto-merge can trigger

### Workflow Configuration Issues

**Problem: "Workflow file is invalid"**

```
Error: Invalid workflow file
```

**Solution:**

- Validate YAML syntax (use a YAML linter)
- Check indentation (YAML is whitespace-sensitive)
- Ensure all required fields are present
- Review GitHub Actions documentation for correct syntax

**Problem: "Workflow not triggering"**

```
No workflow runs appearing
```

**Solution:**

- Check that the trigger event matches (e.g., `pull_request` vs `pull_request_target`)
- Verify the workflow file is in `.github/workflows/`
- Ensure the workflow file has `.yml` or `.yaml` extension
- Check if workflow is disabled in repository settings
- Review branch filters if specified

**Problem: "Secret not found"**

```
Error: Secret NPM_TOKEN not found
```

**Solution:**

- Add the secret in repository Settings → Secrets and variables → Actions
- Ensure secret name matches exactly (case-sensitive)
- For organization secrets, verify repository has access
- Check that you're passing secrets correctly in workflow call

### CodeQL Issues

**Problem: "No code found to analyze"**

```
Error: No source code was found
```

**Solution:**

- Verify the `languages` input includes your project's language
- Check that source files are in standard locations
- For compiled languages, ensure build commands are correct
- Review CodeQL configuration for path filters

**Problem: Build failing for compiled languages**

```
Error: Build failed
```

**Solution:**

- Customize `build-command` input with correct build steps
- Ensure all build dependencies are available
- Check that the build environment matches your local setup

### Getting More Help

If you're still stuck:

1. **Check workflow logs** - Click on the failed run to see detailed logs
2. **Enable debug logging** - Add `ACTIONS_STEP_DEBUG: true` to secrets
3. **Search GitHub Discussions** - Others may have had similar issues
4. **Review GitHub Actions documentation** - [docs.github.com/actions](https://docs.github.com/actions)
5. **Open an issue** - If you think there's a bug in the workflow

---
```

## 🔗 Useful Links

**Note**: Use `node-version-matrix` to test across multiple Node.js versions. If specified, it overrides `node-version` for the test job.

---

## 📦 Release Workflow

**File**: `.github/workflows/release-changesets.yml`

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
      needs-build: true            # Build before publishing
      version-command: 'pnpm run version'
      publish-command: 'pnpm run release'
      commit-message: 'chore(release): bump package versions'
      pr-title: 'chore(release): create new release'
    secrets:
      NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
```

---

## 🤖 Auto-merge Dependabot

**File**: `.github/workflows/auto-merge-dependabot.yml`

```yaml
name: Dependabot Auto-merge
on:
  pull_request:

permissions:
  contents: write
  pull-requests: write

jobs:
  auto-merge:
    uses: benhigham/.github/.github/workflows/auto-merge-dependabot.yml@main
    with:
      enable-auto-merge: true
      merge-method: squash         # squash, merge, or rebase
      auto-merge-patch: true       # Auto-merge patch updates
      auto-merge-minor: true       # Auto-merge minor updates
      auto-merge-major: false      # Don't auto-merge major updates
```

---

## 🧹 Stale Issues/PRs

**File**: `.github/workflows/stale.yml`

```yaml
name: Close Stale Issues
on:
  schedule:
    - cron: '0 0 * * *'  # Daily at midnight
  workflow_dispatch:      # Manual trigger

jobs:
  stale:
    uses: benhigham/.github/.github/workflows/stale.yml@main
    with:
      days-before-stale: 60        # Days before marking stale
      days-before-close: 7         # Days before closing
      exempt-issue-labels: 'priority: critical,priority: high,status: blocked'
      exempt-pr-labels: 'priority: critical,priority: high,status: blocked'
      stale-issue-label: 'stale'
      stale-pr-label: 'stale'
```

---

## 🏷️ PR Labeler

**File**: `.github/workflows/labeler.yml`

```yaml
name: Label PRs
on:
  pull_request:
    types: [opened, synchronize, reopened]

permissions:
  contents: read
  pull-requests: write

jobs:
  label:
    uses: benhigham/.github/.github/workflows/labeler.yml@main
    with:
      enable-size-labeling: true   # Label by size (xs, s, m, l, xl)
      enable-path-labeling: true   # Label by changed paths
```

**Note**: Requires `.github/labeler.yml` configuration file

---

## 🔄 Sync Labels

**File**: `.github/workflows/sync-labels.yml`

Automatically syncs repository labels when `.github/labels.yml` changes:

```yaml
name: Sync Labels
on:
  push:
    branches: [main]
    paths:
      - '.github/labels.yml'
  workflow_dispatch:

permissions:
  issues: write
  contents: read

jobs:
  sync:
    uses: benhigham/.github/.github/workflows/sync-labels.yml@main
```

**What it does:**

- Syncs labels from `.github/labels.yml` to the repository
- Creates missing labels
- Updates existing labels
- Removes labels not in the manifest (optional)

---

## 👋 First-Time Contributor Greeter

**File**: `.github/workflows/first-time-contributor.yml`

Welcomes new contributors with a friendly message:

```yaml
name: Greet First-Time Contributors
on:
  pull_request_target:
    types: [opened]
  issues:
    types: [opened]

permissions:
  pull-requests: write
  issues: write

jobs:
  greeting:
    uses: benhigham/.github/.github/workflows/first-time-contributor.yml@main
```

**Features:**

- Detects first-time contributors
- Posts welcoming message on first PR
- Posts helpful message on first issue
- Provides checklist and resources

---

## 🔒 CodeQL Security Scanning

**File**: `.github/workflows/codeql.yml`

```yaml
name: Security Scan
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 0 * * 1'  # Weekly on Monday

jobs:
  security:
    uses: benhigham/.github/.github/workflows/codeql.yml@main
    with:
      languages: 'javascript'      # Comma-separated: javascript,python,go
      queries: 'security-and-quality'  # default, security-extended, security-and-quality
      build-mode: 'autobuild'      # none, autobuild, manual
```

---

## 🎯 Setup Action

**File**: `.github/actions/setup-node-pnpm/action.yml`

```yaml
steps:
  - uses: benhigham/.github/.github/actions/setup-node-pnpm@main
    with:
      node-version: '20'           # Optional: Node.js version
      pnpm-version: '8'            # Optional: pnpm version
      fetch-depth: '1'             # Git fetch depth
```

This action:

- Checks out repository
- Sets up pnpm
- Sets up Node.js with caching
- Installs dependencies

---

## 📋 Label Management

### Available Label Categories

See [LABELS.md](LABELS.md) for the complete guide to all labels.

- **Type**: bug, enhancement, documentation, refactoring, performance, testing
- **Priority**: critical, high, medium, low
- **Status**: blocked, in progress, needs review, needs testing, ready
- **Size**: xs, s, m, l, xl, xxl (auto-assigned by PR Size Labeler)
- **Area**: ci/cd, security, api, ui
- **Dependencies**: npm, github-actions
- **Special**: breaking change, backport, chore
- **Triage**: triage, duplicate, invalid, wontfix, good first issue, help wanted

### Sync Labels to This Repository

Labels are automatically synced when `.github/labels.yml` is updated via the Sync Labels workflow.

### Sync Labels to Other Repositories

Using [github-label-sync](https://github.com/Financial-Times/github-label-sync):

```bash
# Install
npm install -g github-label-sync

# Sync labels
github-label-sync --access-token $(gh auth token) \
  --labels .github/labels.yml \
  benhigham/your-repo-name
```

Or use GitHub Actions (see README.md for complete examples).

---

## 🔧 Complete Example

```yaml
name: Complete CI/CD
on:
  pull_request:
  push:
    branches: [main]

permissions:
  contents: write
  pull-requests: write
  security-events: write

jobs:
  # Run CI checks
  ci:
    uses: benhigham/.github/.github/workflows/ci.yml@main
    with:
      run-lint: true
      run-typecheck: true
      run-test: true

  # Security scanning
  security:
    uses: benhigham/.github/.github/workflows/codeql.yml@main
    with:
      languages: 'javascript'

  # Label PRs
  label:
    if: github.event_name == 'pull_request'
    uses: benhigham/.github/.github/workflows/labeler.yml@main

  # Auto-merge Dependabot
  dependabot:
    if: github.actor == 'dependabot[bot]'
    uses: benhigham/.github/.github/workflows/auto-merge-dependabot.yml@main
    with:
      auto-merge-minor: true
      auto-merge-patch: true

  # Release (on main branch)
  release:
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'
    needs: [ci, security]
    uses: benhigham/.github/.github/workflows/release-changesets.yml@main
    with:
      needs-build: true
    secrets:
      NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
```

---

## 📝 Documentation Templates

### Available Templates

1. **ARCHITECTURE.md** - System architecture documentation
2. **DEVELOPMENT.md** - Development setup and guidelines
3. **RELEASING.md** - Release process and versioning
4. **CHANGELOG.md** - Keep a Changelog format

### Usage

Copy to your repository and customize:

```bash
# Copy all documentation templates
cp .github/ARCHITECTURE.md ./ARCHITECTURE.md
cp .github/DEVELOPMENT.md ./DEVELOPMENT.md
cp .github/RELEASING.md ./RELEASING.md
cp .github/CHANGELOG.md ./CHANGELOG.md

# Replace placeholders
# [repository-name] -> your-repo-name
# [package-name] -> your-package-name
```

---

## 🚀 Getting Started Checklist

### Initial Setup

- [ ] Copy workflows you need to your repository
- [ ] Sync labels using `.github/labels.yml` or the sync-labels workflow
- [ ] Configure `.github/labeler.yml` for your project
- [ ] Add `NPM_TOKEN` secret (if publishing to npm)
- [ ] Copy documentation templates
- [ ] Update README with workflow badges
- [ ] Set up first-time contributor greeting

### Per Repository

- [ ] Enable auto-merge in repository settings
- [ ] Configure branch protection rules
- [ ] Set up required status checks
- [ ] Configure Dependabot alerts
- [ ] Enable security scanning

### Optional

- [ ] Set up code coverage reporting
- [ ] Configure deployment workflows
- [ ] Add performance testing
- [ ] Set up notification webhooks
- [ ] Create custom label categories for your domain

---

## 🔍 Dependency Review Workflow

**File**: `.github/workflows/dependency-review.yml`

Automatically reviews dependencies for security vulnerabilities in PRs:

```yaml
name: Dependency Review
on:
  pull_request:

permissions:
  contents: read
  pull-requests: write

jobs:
  review:
    uses: benhigham/.github/.github/workflows/dependency-review.yml@main
    with:
      fail-on-severity: moderate  # low, moderate, high, critical
      comment-summary-in-pr: always  # always, on-failure, never
```

**Features:**

- Reviews dependencies for known vulnerabilities
- Configurable severity threshold
- Optional license allowlist/denylist
- Posts summary comments in PRs
- Runs automatically on all pull requests

---

## 🛡️ Branch Protection Check Workflow

**File**: `.github/workflows/branch-protection-check.yml`

Validates branch protection settings weekly:

```yaml
name: Branch Protection Check
on:
  schedule:
    - cron: '0 0 * * 1'  # Weekly on Monday
  workflow_dispatch:

jobs:
  check:
    uses: benhigham/.github/.github/workflows/branch-protection-check.yml@main
```

**Features:**

- Checks if branch protection is enabled
- Validates required settings (PR reviews, status checks, etc.)
- Creates issues if configuration problems are found
- Runs weekly or manually via workflow_dispatch

---

## 🔗 Useful Links

- [Reusable Workflows Docs](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)
- [Changesets Documentation](https://github.com/changesets/changesets)
- [Semantic Versioning](https://semver.org/)
- [Keep a Changelog](https://keepachangelog.com/)

---

## 💡 Tips

1. **Test workflows in a dedicated test repository first**
2. **Use workflow_dispatch for manual testing**
3. **Check workflow logs for debugging**
4. **Use matrix strategies for multi-version testing**
5. **Keep secrets in GitHub Secrets, never in code**
6. **Use concurrency groups to prevent duplicate runs**
7. **Set appropriate timeouts to prevent hanging jobs**
8. **Cache dependencies to speed up workflows**

---

**Last Updated**: 2025-10-01  
**Version**: 2.1.0
