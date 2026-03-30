# Code Quality: Linting & Formatting

Design spec for adding actionlint, yamllint, markdownlint, and prettier to the `.github` repository, with mise for tool management, lefthook for git hooks, and a CI workflow as a merge gate.

## Goals

1. Catch GitHub Actions workflow errors before merge (actionlint)
2. Enforce consistent YAML style across workflows, issue templates, and dependabot config (yamllint)
3. Enforce consistent Markdown style across community health files and templates (markdownlint-cli2)
4. Auto-format YAML and Markdown on commit (prettier)
5. Run identical checks locally (lefthook pre-commit) and in CI

## Non-goals

- Link checking (can add later as a scheduled workflow)
- Spell checking (noisy for a config repo)
- Linting non-YAML/Markdown files (none exist in this repo)

## Files to add

```text
.mise.toml                  # Tool versions + task definitions
lefthook.yml                # Git hook config
.yamllint.yml               # yamllint rules
.markdownlint-cli2.yaml     # markdownlint rules
.prettierrc.yaml            # Prettier config
.prettierignore             # Prettier ignore patterns
.github/workflows/lint.yml  # CI workflow
```

## Tools

All managed and version-pinned by mise.

| Tool              | Purpose                                                                 | Auto-fix?       |
| ----------------- | ----------------------------------------------------------------------- | --------------- |
| actionlint        | Validate GitHub Actions workflow syntax, expressions, action references | No (read-only)  |
| yamllint          | YAML style and syntax linting                                           | No (read-only)  |
| markdownlint-cli2 | Markdown linting with rule enforcement                                  | Yes (`--fix`)   |
| prettier          | Opinionated formatter for YAML and Markdown                             | Yes (`--write`) |

## mise configuration (`.mise.toml`)

### Tool versions

```toml
[tools]
actionlint = "latest"
lefthook = "latest"
"npm:markdownlint-cli2" = "latest"
"npm:prettier" = "latest"
"pipx:yamllint" = "latest"
```

Version pinning: mise resolves `latest` on first install and writes the resolved version to `.mise.lock`. The lockfile is committed, ensuring reproducible installs across machines and CI.

### Tasks

```toml
[tasks.lint]
description = "Run all linters"
depends = ["lint:actions", "lint:yaml", "lint:markdown"]

[tasks."lint:actions"]
description = "Lint GitHub Actions workflows"
run = "actionlint"

[tasks."lint:yaml"]
description = "Lint YAML files"
run = "yamllint ."

[tasks."lint:markdown"]
description = "Lint Markdown files"
run = "markdownlint-cli2 '**/*.md'"

[tasks.fmt]
description = "Format YAML and Markdown files"
run = "prettier --write '**/*.{yml,yaml,md}'"

[tasks."fmt:check"]
description = "Check formatting (no writes)"
run = "prettier --check '**/*.{yml,yaml,md}'"

[tasks."fix:markdown"]
description = "Auto-fix Markdown lint violations"
run = "markdownlint-cli2 --fix '**/*.md'"

[tasks.check]
description = "Run all checks (format + lint)"
depends = ["fmt:check", "lint"]
```

## lefthook configuration (`lefthook.yml`)

Pre-commit hook with parallel jobs. Prettier runs first (formatter), then linters validate the result.

```yaml
pre-commit:
  commands:
    prettier:
      priority: 1
      glob: "**/*.{yml,yaml,md}"
      run: prettier --write {staged_files}
      stage_fixed: true
    actionlint:
      priority: 2
      glob: ".github/workflows/*.yml"
      run: actionlint {staged_files}
    yamllint:
      priority: 2
      glob: "**/*.{yml,yaml}"
      run: yamllint {staged_files}
    markdownlint:
      priority: 2
      glob: "**/*.md"
      run: markdownlint-cli2 --fix {staged_files}
      stage_fixed: true
```

Prettier at priority 1 ensures formatting is applied before linters run at priority 2 (lower number = runs first). The three linters run in parallel at the same priority.

## Linter configurations

### yamllint (`.yamllint.yml`)

Strict defaults with targeted overrides:

```yaml
extends: default

rules:
  line-length:
    max: 120
    allow-non-breakable-words: true
    allow-non-breakable-inline-mappings: true
  truthy:
    forbid-duplicated-merge-keys: true
    check-keys: false
```

Key overrides:

- **line-length: 120** — workflow expressions and long descriptions exceed 80 chars. 120 is a reasonable ceiling.
- **truthy check-keys: false** — GitHub Actions uses `on:` as a top-level key, which yamllint flags as a truthy value. Disabling key checking avoids false positives while still catching truthy values in other positions.

### markdownlint (`.markdownlint-cli2.yaml`)

Strict defaults with targeted overrides:

```yaml
config:
  MD013:
    line_length: 120
  MD033:
    allowed_elements:
      - "details"
      - "summary"
```

Key overrides:

- **MD013 (line length): 120** — matches yamllint for consistency.
- **MD033 (inline HTML):** Allow `<details>` and `<summary>` elements, which are commonly used in GitHub Markdown for collapsible sections. Other HTML is still flagged.

### Prettier (`.prettierrc.yaml`)

```yaml
proseWrap: preserve
```

- **proseWrap: preserve** — don't rewrap Markdown paragraphs. Avoids noisy diffs in hand-authored prose files (CODE_OF_CONDUCT, GOVERNANCE, etc.).
- All other settings use prettier defaults (2-space indent, no tabs, trailing newline).

### Prettier ignore (`.prettierignore`)

```text
LICENSE.md
CHANGELOG.md
pnpm-lock.yaml
```

- **LICENSE.md** — exact legal text, must not be reformatted.
- **CHANGELOG.md** — generated by Changesets in consuming repos; included defensively since this is a shared config repo.
- **pnpm-lock.yaml** — lockfiles should never be formatted.

## CI workflow (`.github/workflows/lint.yml`)

Triggers on PRs and pushes to main. Follows existing repo conventions.

```yaml
name: Lint

on:
  push:
    branches: [main]
  pull_request:

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

permissions:
  contents: read

jobs:
  lint:
    name: Lint
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - name: Checkout repository
        uses: actions/checkout@v6

      - name: Setup mise
        uses: jdx/mise-action@v2

      - name: Check formatting
        run: mise run fmt:check

      - name: Run linters
        run: mise run lint
```

Key decisions:

- **`cancel-in-progress: true`** — unlike the release workflow (which must not be cancelled), lint runs are safe to cancel on new pushes.
- **Formatting check before lint** — fail fast on formatting issues before spending time on lint.
- **`permissions: contents: read`** — minimal permissions, read-only.
- **`timeout-minutes: 5`** — these tools are fast; 5 minutes is generous.

## Execution order

### Local (lefthook pre-commit)

1. prettier formats staged YAML + Markdown files, auto-stages fixes
2. In parallel: actionlint, yamllint, markdownlint-cli2 validate staged files; markdownlint auto-stages fixes
3. Commit proceeds if all pass

### CI

1. `mise run fmt:check` — verify formatting (no writes)
2. `mise run lint` — run actionlint, yamllint, markdownlint-cli2

## AGENTS.md update

After implementation, update the AGENTS.md directory tree and add a new section documenting the lint/format commands:

```text
## Code Quality

- `mise run check` — run all checks (format + lint)
- `mise run fmt` — auto-format YAML and Markdown
- `mise run lint` — run all linters
- `mise run lint:actions` — actionlint only
- `mise run lint:yaml` — yamllint only
- `mise run lint:markdown` — markdownlint-cli2 only

Lefthook runs formatting and linting automatically on pre-commit.
```
