# Quick Reference: Reusable Workflows

> **Note**: All Node.js workflows internally use the custom `setup-node-pnpm` action for consistent environment setup. You don't need to call this action directly - it's automatically used by the workflows.

**For troubleshooting**, see [Troubleshooting](Troubleshooting)  
**For advanced usage**, see [Advanced Usage](Advanced-Usage)

## 📋 Table of Contents

- [CI Workflow](#-ci-workflow)
- [Release Workflow](#-release-workflow)
- [Auto-merge Dependabot](#-auto-merge-dependabot)
- [Stale Issues/PRs](#-stale-issuesprs)
- [PR Labeler](#️-pr-labeler)
- [Sync Labels](#-sync-labels)
- [First-Time Contributor](#-first-time-contributor-greeter)
- [CodeQL Security](#-codeql-security-scanning)
- [Dependency Review](#-dependency-review)
- [Branch Protection Check](#️-branch-protection-check)
- [PR Title Check](#-pr-title-check)
- [Setup Action](#-setup-action)

---

## 🔄 CI Workflow

**Purpose**: Lint, type check, test, and build your code  
**File**: `.github/workflows/ci.yml`

```yaml
name: CI
on: [pull_request, push]

jobs:
  ci:
    uses: benhigham/.github/.github/workflows/ci.yml@main
    with:
      node-version: '20'           # Optional: Node.js version
      node-version-matrix: '["18", "20", "22"]'  # Optional: Test multiple versions
      pnpm-version: '8'            # Optional: pnpm version
      run-lint: true
      run-typecheck: true
      run-test: true
      run-build: false  # Optional
```

**Common Inputs:**

- `node-version`: Node.js version (default: from package.json)
- `node-version-matrix`: Test multiple versions, e.g., `'["18", "20", "22"]'`
- `run-lint`, `run-typecheck`, `run-test`, `run-build`: Enable/disable steps
- Custom commands: `lint-command`, `typecheck-command`, `test-command`, `build-command`

---

## 📦 Release Workflow

**Purpose**: Automated releases with Changesets and npm publishing  
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
      needs-build: true
    secrets:
      NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
```

**Requirements:**

- Changesets installed: `pnpm add -D @changesets/cli`
- Initialize: `pnpm changeset init`
- Create changesets: `pnpm changeset`

---

## 🤖 Auto-merge Dependabot

**Purpose**: Automatically merge Dependabot PRs for safe updates  
**File**: `.github/workflows/auto-merge-dependabot.yml`

```yaml
name: Dependabot Auto-merge
on: pull_request

permissions:
  contents: write
  pull-requests: write

jobs:
  auto-merge:
    uses: benhigham/.github/.github/workflows/auto-merge-dependabot.yml@main
    with:
      auto-merge-patch: true
      auto-merge-minor: true
      auto-merge-major: false
      merge-method: squash
```

---

## 🧹 Stale Issues/PRs

**Purpose**: Automatically close inactive issues and PRs  
**File**: `.github/workflows/stale.yml`

```yaml
name: Close Stale Issues
on:
  schedule:
    - cron: '0 0 * * *'  # Daily

jobs:
  stale:
    uses: benhigham/.github/.github/workflows/stale.yml@main
    with:
      days-before-stale: 60
      days-before-close: 7
```

---

## 🏷️ PR Labeler

**Purpose**: Auto-label PRs by size and changed files  
**File**: `.github/workflows/labeler.yml`

```yaml
name: Label PRs
on:
  pull_request:
    types: [opened, synchronize]

permissions:
  contents: read
  pull-requests: write

jobs:
  label:
    uses: benhigham/.github/.github/workflows/labeler.yml@main
    with:
      enable-size-labeling: true
      enable-path-labeling: true
```

**Requires:** `.github/labeler.yml` configuration file

---

## 🔄 Sync Labels

**Purpose**: Sync repository labels from configuration  
**File**: `.github/workflows/sync-labels.yml`

```yaml
name: Sync Labels
on:
  push:
    branches: [main]
    paths: ['.github/labels.yml']
  workflow_dispatch:

permissions:
  issues: write

jobs:
  sync:
    uses: benhigham/.github/.github/workflows/sync-labels.yml@main
```

**Requires:** `.github/labels.yml` configuration file

---

## 👋 First-Time Contributor Greeter

**Purpose**: Welcome new contributors  
**File**: `.github/workflows/first-time-contributor.yml`

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

---

## 🔒 CodeQL Security Scanning

**Purpose**: Scan code for security vulnerabilities  
**File**: `.github/workflows/codeql.yml`

```yaml
name: Security Scan
on:
  push:
    branches: [main]
  pull_request:
  schedule:
    - cron: '0 0 * * 1'  # Weekly

jobs:
  security:
    uses: benhigham/.github/.github/workflows/codeql.yml@main
    with:
      languages: 'javascript,typescript'
      queries: 'security-and-quality'
```

---

## 🛡️ Dependency Review

**Purpose**: Review dependencies for vulnerabilities in PRs  
**File**: `.github/workflows/dependency-review.yml`

```yaml
name: Dependency Review
on: pull_request

permissions:
  contents: read
  pull-requests: write

jobs:
  review:
    uses: benhigham/.github/.github/workflows/dependency-review.yml@main
    with:
      fail-on-severity: moderate  # low, moderate, high, critical
      comment-summary-in-pr: always
```

---

## ✅ Branch Protection Check

**Purpose**: Validate branch protection settings weekly  
**File**: `.github/workflows/branch-protection-check.yml`

```yaml
name: Branch Protection Check
on:
  schedule:
    - cron: '0 0 * * 1'  # Weekly
  workflow_dispatch:

jobs:
  check:
    uses: benhigham/.github/.github/workflows/branch-protection-check.yml@main
```

---

## ✏️ PR Title Check

**Purpose**: Enforce conventional commit format in PR titles  
**File**: `.github/workflows/pr-title-check.yml`

```yaml
name: PR Title Check
on:
  pull_request:
    types: [opened, edited, synchronize]

jobs:
  check:
    uses: benhigham/.github/.github/workflows/pr-title-check.yml@main
```

**Valid formats:** `feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `test:`, `ci:`, `perf:`

---

## 🎯 Setup Action

**Purpose**: Reusable setup for Node.js and pnpm  
**File**: `.github/actions/setup-node-pnpm/action.yml`

```yaml
steps:
  - uses: benhigham/.github/.github/actions/setup-node-pnpm@main
    with:
      node-version: '20'  # Optional
      pnpm-version: '8'   # Optional
      fetch-depth: '1'    # Git history depth
```

**What it does:**

- Checks out repository
- Sets up pnpm with caching
- Sets up Node.js with caching
- Installs dependencies

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

## 🔗 Related Documentation

- **[Getting Started](Getting-Started)** - 5-minute quickstart guide
- **[Troubleshooting](Troubleshooting)** - Common issues and solutions
- **[Advanced Usage](Advanced-Usage)** - Complex configurations and patterns
- **[Labels Guide](Labels-Reference)** - Complete label reference
- **[Repository README](https://github.com/benhigham/.github#readme)** - Overview and features

---

## 💡 Quick Tips

1. **Test workflows** in a test repository first
2. **Use `workflow_dispatch`** for manual testing
3. **Check logs** when workflows fail
4. **Start simple** - add one workflow at a time
5. **Pin to `@main`** for latest features, or use `@v2` for stability

---

**Last Updated**: 2025-10-01  
**Version**: 2.1.0

---

## 🔗 Navigation

- [← Back to Home](Home)
- [Getting Started Guide →](Getting-Started)
- [Troubleshooting →](Troubleshooting)
- [Advanced Usage →](Advanced-Usage)
- [Labels Reference →](Labels-Reference)
- [Contributing Guide](https://github.com/benhigham/.github/blob/main/CONTRIBUTING.md)
