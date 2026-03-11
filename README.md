# benhigham/.github

Default [community health files](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file) and reusable GitHub Actions workflows for all repositories under my account.

## Community Health Files

GitHub uses these as defaults for any public repository that doesn't have its own version:

- `CODE_OF_CONDUCT.md`, `SECURITY.md`, `SUPPORT.md`, `GOVERNANCE.md`, `LICENSE.md`
- `.github/ISSUE_TEMPLATE/` — bug reports, feature requests, codebase improvements
- `.github/pull_request_template.md` — default PR template
- `.github/dependabot.yml` — dependency updates with grouping and auto-assign
- `.github/FUNDING.yml`

## Reusable Workflows

### Release with Changesets

Automated versioning, changelog, and npm publishing via [Changesets](https://github.com/changesets/changesets).

```yaml
name: Release
on:
  push:
    branches: [main]

permissions:
  attestations: write
  contents: write
  id-token: write
  pull-requests: write

jobs:
  release:
    uses: benhigham/.github/.github/workflows/release-changesets.yml@main
    with:
      node-version: '24'
      needs-build: true
```

### Auto-merge Dependabot

Automatically approves and merges Dependabot PRs based on semver rules.

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

## Shared Actions

### setup-node-pnpm

Sets up Node.js and pnpm with dependency caching:

```yaml
- uses: benhigham/.github/.github/actions/setup-node-pnpm@main
  with:
    node-version: '24'
```
