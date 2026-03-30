# AI Agent Instructions

Guidance for AI coding assistants working on this `.github` repository.

## Repository Purpose

Centralized defaults and automation for all `benhigham` GitHub repositories:

- **Community health files** — inherited by repos without their own (CODE_OF_CONDUCT, SECURITY, SUPPORT, etc.)
- **Reusable workflows** — called by other repos via `workflow_call`
- **Shared actions** — composite actions for common setup tasks
- **Templates** — issue and PR templates

## What's Here

```text
.github/
  workflows/
    lint.yml                   # Lint and format check on PRs and pushes to main
    release-changesets.yml     # Reusable: versioning and npm publishing via Changesets
    auto-merge-dependabot.yml  # Reusable: approve and merge Dependabot PRs by semver
  ISSUE_TEMPLATE/              # Issue form templates
  pull_request_template.md     # Default PR template
  dependabot.yml               # Dependabot config (npm, github-actions, docker, terraform, etc.)
  FUNDING.yml
```

## Tech Stack

- **YAML** for workflows and configurations
- **Markdown** for documentation and templates
- **pnpm** as the package manager (not npm or yarn)
- **Changesets** for versioning and releases
- **Conventional Commits** (`feat:`, `fix:`, `chore:`, `docs:`, etc.)
- **mise** as the tool manager and task runner
- **lefthook** for git hooks (pre-commit linting and formatting)

## Code Quality

- `mise run check` — run all checks (format + lint)
- `mise run fmt` — auto-format YAML and Markdown
- `mise run lint` — run all linters
- `mise run lint:actions` — actionlint only
- `mise run lint:yaml` — yamllint only
- `mise run lint:markdown` — markdownlint-cli2 only

Lefthook runs formatting and linting automatically on pre-commit.

## Conventions

### Workflows

- Use `workflow_call` for reusable workflows
- Always include `timeout-minutes` on jobs
- Use concurrency groups: `${{ github.workflow }}-${{ github.ref }}` (or PR number for PR-triggered workflows). Reusable
  workflows should prefix the group (e.g. `release-${{ github.workflow }}-${{ github.ref }}`) to namespace separately
  from the caller's concurrency groups
- Minimal permissions (declare only what's needed)
- kebab-case for input names
- Use environment variables (not `${{ inputs }}`) in `github-script` blocks to prevent injection

### Commits

```text
<type>: <description>
```

Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`, `perf`

### Files That Affect Other Repos

Community health files, templates, and `.github/dependabot.yml` are inherited by other repositories. Edit carefully —
breaking changes affect all repos without their own versions.

### Files Local to This Repo

`README.md`, `AGENTS.md`, and workflow definitions. Other repos call workflows explicitly;
changes here require consumers to update their references if inputs change.
