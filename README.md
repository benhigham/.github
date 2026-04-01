# benhigham/.github

Default [community health files][chf] and reusable GitHub Actions workflows for all repositories under my account.

[chf]: https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file

## Community Health Files

GitHub uses these as defaults for any public repository that doesn't have its own version:

- `CODE_OF_CONDUCT.md`, `SECURITY.md`, `SUPPORT.md`, `GOVERNANCE.md`, `LICENSE.md`
- `.github/ISSUE_TEMPLATE/` — bug reports, feature requests, codebase improvements
- `.github/pull_request_template.md` — default PR template
- `.github/FUNDING.yml`

## Dependency Management

- `renovate.json` — Renovate dependency update config (assignees, grouping, labels, schedule)

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
      needs-build: true
```

## Composite Actions

Composite actions are composable steps — the caller controls the job, permissions, and timeout.

### claude-invoke

The core Claude Code wrapper. Handles token validation, command file resolution, and tool configuration.

```yaml
- name: Checkout repository
  uses: actions/checkout@... # required before claude-invoke

- uses: benhigham/.github/.github/actions/claude-invoke@<sha>
  with:
    oauth-token: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
    command: quality-audit
    max-turns: "30"
    additional-permissions: |
      actions: read
```

See `AGENTS.md` for the full input reference.

> **SHA pinning:** Always pin composite action refs to a specific commit SHA rather than `@main`.
> Exception: this repo's own workflows may use `@main` as a self-reference.

### setup-node-pnpm

```yaml
- name: Checkout repository
  uses: actions/checkout@...

- uses: benhigham/.github/.github/actions/setup-node-pnpm@<sha>
  # Zero-config: reads Node version from package.json by default
```

### setup-terraform

```yaml
- name: Checkout repository
  uses: actions/checkout@...

- uses: benhigham/.github/.github/actions/setup-terraform@<sha>
```

## Claude Code Commands

Reference command files live in `.claude/commands/`. Copy to your repo's `.claude/commands/`
directory and customise for your stack.

The Trigger column shows the intended workflow event — you must configure a workflow in your repo to
invoke these commands on the appropriate event.

| Command            | Purpose                                  | Trigger                  |
| ------------------ | ---------------------------------------- | ------------------------ |
| `code-review`      | PR code review with inline comments      | PR open/reopen           |
| `renovate-review`  | Review Renovate dependency PRs           | PR open (renovate actor) |
| `test-gen`         | Generate missing tests for changed files | PR open                  |
| `security-review`  | Security-focused PR review               | PR open                  |
| `docs-sync`        | Keep docs accurate after code changes    | PR open                  |
| `respond`          | Handle @claude mentions                  | issue/PR comment         |
| `triage`           | Categorise and label new issues          | issue opened             |
| `release-notes`    | Generate release notes from commits      | release event            |
| `quality-audit`    | Weekly code quality sweep                | schedule                 |
| `dependency-audit` | Dependency security audit                | schedule                 |
| `docs-drift`       | Documentation freshness check            | schedule                 |

Commands are **dual-use**: they run in CI via `claude-invoke` and locally via Claude Code's
`/command` syntax.
