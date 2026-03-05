# AI Agent Instructions

Guidance for AI coding assistants working on this `.github` repository.

## Repository Purpose

Centralized defaults and automation for all `benhigham` GitHub repositories:

- **Community health files** — inherited by repos without their own (CODE_OF_CONDUCT, SECURITY, SUPPORT, etc.)
- **Reusable workflows** — called by other repos via `workflow_call`
- **Shared actions** — composite actions for common setup tasks
- **Templates** — issue, PR, and discussion templates; documentation templates to copy

## What's Here

```text
.github/
  actions/setup-node-pnpm/    # Composite action: checkout + pnpm + Node.js + install
  workflows/
    release-changesets.yml     # Reusable: versioning and npm publishing via Changesets
    auto-merge-dependabot.yml  # Reusable: approve and merge Dependabot PRs by semver
  ISSUE_TEMPLATE/              # Issue form templates
  PULL_REQUEST_TEMPLATE/       # PR templates by change type
  DISCUSSION_TEMPLATE/         # Discussion form templates
  dependabot.yml               # Dependabot config (npm, github-actions, docker, terraform, etc.)
  FUNDING.yml
```

## Tech Stack

- **YAML** for workflows and configurations
- **Markdown** for documentation and templates
- **pnpm** as the package manager (not npm or yarn)
- **Changesets** for versioning and releases
- **Conventional Commits** (`feat:`, `fix:`, `chore:`, `docs:`, etc.)

## Conventions

### Workflows

- Use `workflow_call` for reusable workflows
- Always include `timeout-minutes` on jobs
- Use concurrency groups: `${{ github.workflow }}-${{ github.ref }}`
- Minimal permissions (declare only what's needed)
- kebab-case for input names
- Use environment variables (not `${{ inputs }}`) in `github-script` blocks to prevent injection

### Commits

```
<type>: <description>
```

Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`, `perf`

### Files That Affect Other Repos

Community health files, templates, and `.github/dependabot.yml` are inherited by other repositories. Edit carefully — breaking changes affect all repos without their own versions.

### Files Local to This Repo

`README.md`, `AGENTS.md`, workflow definitions, and the setup-node-pnpm action. Other repos call workflows explicitly; changes here require consumers to update their references if inputs change.
