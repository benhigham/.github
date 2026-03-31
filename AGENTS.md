# AI Agent Instructions

Guidance for AI coding assistants working on this `.github` repository.

## Repository Purpose

Centralized defaults and automation for all `benhigham` GitHub repositories:

- **Community health files** — inherited by repos without their own (CODE_OF_CONDUCT, SECURITY, SUPPORT, etc.)
- **Reusable workflows** — called by other repos via `workflow_call`
- **Templates** — issue and PR templates

## What's Here

```text
.github/
  actions/
    claude-invoke/             # Composite action: wraps claude-code-action with org-standard config
    setup-node-pnpm/           # Composite action: pnpm + Node.js setup with caching
    setup-terraform/           # Composite action: Terraform toolchain via mise
  workflows/
    lint.yml                   # Lint and format check on PRs and pushes to main
    release-changesets.yml     # Reusable: versioning and npm publishing via Changesets
  ISSUE_TEMPLATE/              # Issue form templates
  pull_request_template.md     # Default PR template
  dependabot.yml               # Dependabot config (npm, github-actions, docker, terraform, etc.)
  FUNDING.yml
.claude/
  commands/                    # Reference command files — copy to per-repo as needed
    code-review.md             # PR code review
    renovate-review.md         # Renovate dependency PR review
    test-gen.md                # Generate missing tests for PR changes
    security-review.md         # Security-focused PR review
    docs-sync.md               # Keep docs in sync with code changes
    respond.md                 # @claude mention handler
    triage.md                  # Issue triage and labelling
    release-notes.md           # Generate release notes
    quality-audit.md           # Weekly code quality sweep
    dependency-audit.md        # Dependency security audit
    docs-drift.md              # Documentation freshness check
  agents/
    workflow-reviewer.md       # Subagent: review workflows for pitfalls and convention adherence
  skills/
    workflow-scaffold/         # Skill: scaffold new workflows and composite actions
    update-command-file/       # Skill: create/update .claude/commands/*.md files
  settings.json                # Claude Code plugins and hooks (auto-format, sensitive file protection)
.mise.toml                     # Tool versions + task definitions (mise)
lefthook.yml                   # Git hook config (pre-commit)
.yamllint.yml                  # yamllint rules
.markdownlint-cli2.yaml        # markdownlint rules
.prettierrc.yaml               # Prettier config
.prettierignore                # Prettier ignore patterns
CODEOWNERS                     # GitHub code ownership rules
GOVERNANCE.md                  # Project governance policy
```

## Tech Stack

- **YAML** for workflows and configurations
- **Markdown** for documentation and templates
- **pnpm** as the package manager (not npm or yarn)
- **Changesets** for versioning and releases
- **Conventional Commits** (`feat:`, `fix:`, `chore:`, `docs:`, etc.)
- **mise** as the tool manager and task runner
- **lefthook** for git hooks (pre-commit linting and formatting)

## Setup

```bash
mise install   # Install all tool dependencies (actionlint, jq, lefthook, prettier, yamllint, markdownlint-cli2)
```

## Code Quality

- `mise run check` — run all checks (format + lint)
- `mise run fmt` — auto-format YAML and Markdown
- `mise run lint` — run all linters
- `mise run lint:actions` — actionlint only
- `mise run lint:yaml` — yamllint only
- `mise run lint:markdown` — markdownlint-cli2 only
- `mise run lint:markdown:fix` — auto-fix Markdown lint violations

Lefthook runs formatting and linting automatically on pre-commit.

## Composite Actions

Composite actions are steps, not jobs — the caller controls the job shape, permissions, and timeout.
Reference them with a pinned SHA ref: `benhigham/.github/.github/actions/{name}@<sha>`

> **SHA pinning:** Always pin to a specific commit SHA rather than `@main`. Exception: this repo's own
> workflows may reference its composite actions via `@main` as a self-reference, since the SHA is not
> available until after merge.

### claude-invoke

Wraps `anthropics/claude-code-action` with org-standard config (tools, plugins, validation).

```yaml
- uses: benhigham/.github/.github/actions/claude-invoke@<sha>
  with:
    oauth-token: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
    command: quality-audit # uses .claude/commands/quality-audit.md if it exists
    max-turns: "30"
    additional-permissions: |
      actions: read
```

**Behaviour:**

1. Fails fast if `oauth-token` is empty
2. Fails fast if neither `command` nor `prompt` is provided
3. Validates `command` name (alphanumeric, hyphens, underscores) and `max-turns` (positive integer)
4. If `command` is set and `.claude/commands/{command}.md` exists → invokes as `/{command} {command-args}`
5. If `command` is set but file is missing → falls back to `prompt` (fails if empty)
6. Otherwise → uses the `prompt` input directly

**Key inputs:**

| Input                      | Default                                                                            | Notes                                       |
| -------------------------- | ---------------------------------------------------------------------------------- | ------------------------------------------- |
| `oauth-token`              | —                                                                                  | **Required.** Forward the secret explicitly |
| `command`                  | `''`                                                                               | Command name (without .md)                  |
| `prompt`                   | `''`                                                                               | Inline prompt fallback                      |
| `command-args`             | `''`                                                                               | Appended after `/{command}`                 |
| `max-turns`                | `'20'`                                                                             | Tune per concern (review: 20, quality: 30)  |
| `allowed-tools`            | `Read,Glob,Grep,Edit,Write,Bash(pnpm:*),Bash(git:*),Bash(gh:*),WebSearch,WebFetch` | Override to change the tool allowlist       |
| `extra-tools`              | `''`                                                                               | Appended to allowed-tools                   |
| `additional-permissions`   | `''`                                                                               | YAML string forwarded to claude-code-action |
| `track-progress`           | `'true'`                                                                           | Visual progress comments                    |
| `classify-inline-comments` | `'true'`                                                                           | Filter test/probe inline comments           |

**Baked-in plugins:** `context7@claude-plugins-official`, `security-guidance@claude-plugins-official`

**Note:** The `@claude` mention handler and code-review workflow call `anthropics/claude-code-action`
directly — the former is event-driven (no prompt needed), the latter uses different plugins.

### setup-node-pnpm

```yaml
- uses: benhigham/.github/.github/actions/setup-node-pnpm@<sha>
  with:
    # Zero-config: reads Node version from package.json by default
    # Override with node-version for an explicit version:
    # node-version: '24'
    # Or point to a different file:
    # node-version-file: '.nvmrc'
    cache-dependency-path: "**/pnpm-lock.yaml" # optional, default '**/pnpm-lock.yaml'
    install: "true" # optional, default 'true' — runs pnpm install --frozen-lockfile
```

### setup-terraform

```yaml
- uses: benhigham/.github/.github/actions/setup-terraform@<sha>
# No inputs — reads tool versions from .mise.toml in the repo
```

## Command Files

`.claude/commands/*.md` files in this repo are **reference implementations**. They are not automatically
inherited — copy what you need to your repo's own `.claude/commands/` directory and customise for your stack.

When `claude-invoke` receives `command: foo`:

- If `.claude/commands/foo.md` exists in the calling repo → runs `/foo {args}`
- If not → falls back to the `prompt` input

This means zero-config onboarding (use `prompt:` inline) with a clean migration path to command files as
repos mature.

## Skills

Skills in `.claude/skills/` provide guided workflows for common tasks in this repo.

### workflow-scaffold

Scaffolds new reusable workflows (`workflow_call`) and composite actions with org conventions
(concurrency groups, timeouts, permissions, SHA pinning, input validation). Includes templates
and pointers to real examples in this repo.

### update-command-file

Creates or updates `.claude/commands/*.md` files. Encodes the command file structure (opening line,
context section, steps, output), naming rules (`^[a-zA-Z0-9_-]+$`), and conventions like `$ARGUMENTS`,
severity levels, and branch naming. Instructs the agent to read existing command files for style.

## Agents

Subagents in `.claude/agents/` are specialised reviewers that can run in parallel.

### workflow-reviewer

Reviews `.github/workflows/` and `.github/actions/` for:

- Missing `timeout-minutes` or overly broad permissions
- Unpinned action versions (should be full SHA, not `@v4` or `@main`)
- Injection risks — `${{ inputs }}` or `${{ github.event }}` in `run:` blocks
- Missing or incorrectly namespaced concurrency groups
- Secrets handling (explicit forwarding, least-privilege `GITHUB_TOKEN`)

## Hooks

Claude Code hooks in `.claude/settings.json` run automatically during sessions:

- **PostToolUse (Write|Edit):** Runs `prettier --write` on YAML/Markdown files and
  `markdownlint-cli2 --fix` on Markdown files after every edit
- **PreToolUse (Edit|Write):** Blocks edits to `.env*` files and `settings.local.json` —
  these may contain secrets or local permission overrides and should be edited manually

## Plugins

Claude Code plugins are enabled in `.claude/settings.json` via `enabledPlugins`:

- **context7** — live documentation lookup for GitHub Actions, mise, Changesets, pnpm, and other
  tools used in this repo
- **github** — GitHub API access (automatic in GitHub Actions; locally, requires
  `export GITHUB_TOKEN=$(gh auth token)`)

Both are from `anthropics/claude-plugins-official` — the same plugins used by the `claude-invoke`
composite action in CI.

## Conventions

### Workflows

- Use `workflow_call` for reusable workflows
- Always include `timeout-minutes` on jobs
- Use concurrency groups: `${{ github.workflow }}-${{ github.ref }}` (or PR number for PR-triggered workflows). Reusable
  workflows should prefix the group (e.g. `release-${{ github.workflow }}-${{ github.ref }}`) to namespace separately
  from the caller's concurrency groups
- Minimal permissions (declare only what's needed)
- kebab-case for input names
- Use environment variables (not `${{ inputs }}` or `${{ github.event }}`) in `run:` and `github-script` blocks to prevent injection

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
