# benhigham/.github

Default [community health files][chf] and reusable GitHub Actions workflows for all repositories under my account.

[chf]: https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file

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
      node-version: "24"
      needs-build: true
```
