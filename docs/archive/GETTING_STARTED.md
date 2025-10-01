# Getting Started (5 Minutes)

Get up and running with reusable workflows in just 5 minutes.

## 🎯 Overview

This `.github` repository provides reusable workflows, templates, and configurations that you can use across all your repositories. This guide will help you start using them quickly.

---

## Step 1: Choose Your Workflows (1 minute)

Pick workflows based on your project type:

### For npm Packages/Libraries

- ✅ `ci.yml` - Lint, test, and build
- ✅ `release-changesets.yml` - Automated releases
- ✅ `dependency-review.yml` - Security checks
- ✅ `auto-merge-dependabot.yml` - Auto-merge safe updates

### For Web Applications

- ✅ `ci.yml` - Lint, test, and build
- ✅ `codeql.yml` - Security scanning
- ✅ `dependency-review.yml` - Security checks
- ✅ `auto-merge-dependabot.yml` - Auto-merge safe updates

### For Documentation Sites

- ✅ `labeler.yml` - Auto-label PRs
- ✅ `stale.yml` - Close inactive issues

> **See [README.md](README.md#choosing-the-right-workflows)** for the complete decision guide.

---

## Step 2: Copy Required Files (2 minutes)

### A. Create Your CI Workflow

Create `.github/workflows/ci.yml` in your repository:

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

### B. (Optional) Add Release Workflow

For npm packages, create `.github/workflows/release.yml`:

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

### C. (Optional) Sync Labels

Copy `.github/labels.yml` and create `.github/workflows/sync-labels.yml`:

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

Then copy the labels configuration:

```bash
curl -o .github/labels.yml \
  https://raw.githubusercontent.com/benhigham/.github/main/.github/labels.yml
```

---

## Step 3: Configure Secrets (1 minute)

### For Publishing to npm

1. Go to your repository **Settings → Secrets and variables → Actions**
2. Click **New repository secret**
3. Name: `NPM_TOKEN`
4. Value: Your npm access token (create one at npmjs.com)

### For Changesets (Release Workflow)

```bash
# Install Changesets
pnpm add -D @changesets/cli

# Initialize
pnpm changeset init

# Configure .changeset/config.json (optional)
```

---

## Step 4: Test It Out (1 minute)

### Test CI Workflow

1. Create a new branch
2. Make a small change
3. Open a pull request
4. Check the **Actions** tab - your CI workflow should run!

### Test Labels (if configured)

1. The PR should be automatically labeled by size
2. Labels like `documentation`, `dependencies`, etc. will be added based on changed files

### Create Your First Changeset (for releases)

```bash
# Create a changeset
pnpm changeset

# Select version bump type (patch/minor/major)
# Write a description
# Commit the changeset file
```

---

## ✅ You're Done

Your repository now has:

- ✅ Automated CI checks
- ✅ Security scanning (if configured)
- ✅ Auto-labeling (if configured)
- ✅ Release automation (if configured)

---

## 🚀 Next Steps

### Learn More

- **[Quick Reference](QUICK_REFERENCE.md)** - All workflow syntax examples
- **[Advanced Usage](ADVANCED_USAGE.md)** - Complex configurations
- **[Troubleshooting](TROUBLESHOOTING.md)** - Common issues and solutions

### Add More Workflows

- **Security**: Add `codeql.yml` and `dependency-review.yml`
- **Automation**: Add `auto-merge-dependabot.yml` and `stale.yml`
- **Community**: Add `first-time-contributor.yml`

### Customize

- Edit `.github/labels.yml` to add custom labels
- Edit `.github/labeler.yml` to customize path-based labeling
- Adjust workflow inputs to match your needs

### Documentation

- Copy and customize `ARCHITECTURE.md`, `DEVELOPMENT.md`, `RELEASING.md`
- Update your README with workflow badges
- Add a `CHANGELOG.md` using Keep a Changelog format

---

## 💡 Pro Tips

1. **Start simple** - Add one workflow at a time
2. **Test in a branch** - Don't push directly to main
3. **Check the logs** - Actions tab shows detailed output
4. **Use workflow_dispatch** - Add manual triggers for testing
5. **Pin versions** - Use `@v2` instead of `@main` for stability

---

## 🆘 Need Help?

- **Common issues?** See [Troubleshooting](TROUBLESHOOTING.md)
- **Advanced setup?** See [Advanced Usage](ADVANCED_USAGE.md)
- **Found a bug?** [Open an issue](https://github.com/benhigham/.github/issues)
- **Have questions?** [Start a discussion](https://github.com/benhigham/.github/discussions)

---

**Last Updated**: 2025-10-01

---

## 🔗 Navigation

- [← Back to README](README.md)
- [Quick Reference →](QUICK_REFERENCE.md)
- [Troubleshooting →](TROUBLESHOOTING.md)
- [Advanced Usage →](ADVANCED_USAGE.md)
- [Labels Reference →](LABELS.md)
- [Contributing Guide →](CONTRIBUTING.md)
