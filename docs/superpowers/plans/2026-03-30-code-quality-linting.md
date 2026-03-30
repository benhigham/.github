# Code Quality: Linting & Formatting — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add actionlint, yamllint, markdownlint-cli2, and prettier to the `.github` repository with mise for tool management, lefthook for git hooks, and a CI workflow as a merge gate.

**Architecture:** mise manages all tool versions and defines tasks. lefthook calls tools on staged files at pre-commit. A GitHub Actions workflow runs the same checks in CI on PRs and pushes to main.

**Tech Stack:** mise, lefthook, actionlint, yamllint, markdownlint-cli2, prettier

**Spec:** `docs/superpowers/specs/2026-03-30-code-quality-linting-design.md`

---

### Task 1: mise setup

**Files:**
- Create: `.mise.toml`

- [ ] **Step 1: Create `.mise.toml`**

```toml
[tools]
actionlint = "latest"
lefthook = "latest"
"npm:markdownlint-cli2" = "latest"
"npm:prettier" = "latest"
"pipx:yamllint" = "latest"

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

- [ ] **Step 2: Install tools**

Run: `mise install`
Expected: All five tools install successfully. mise creates `.mise.lock` with resolved versions.

- [ ] **Step 3: Verify tools are available**

Run: `actionlint --version && yamllint --version && markdownlint-cli2 --help | head -1 && prettier --version && lefthook version`
Expected: Each tool prints its version without error.

- [ ] **Step 4: Commit**

```bash
git add .mise.toml .mise.lock
git commit -m "chore: add mise config with linting and formatting tools"
```

---

### Task 2: Prettier setup and formatting pass

**Files:**
- Create: `.prettierrc.yaml`
- Create: `.prettierignore`

- [ ] **Step 1: Create `.prettierrc.yaml`**

```yaml
proseWrap: preserve
```

- [ ] **Step 2: Create `.prettierignore`**

```text
LICENSE.md
CHANGELOG.md
pnpm-lock.yaml
```

- [ ] **Step 3: Run prettier to check which files need formatting**

Run: `mise run fmt:check`
Expected: Prettier reports files that don't match its formatting. Note which files it lists — these will be auto-fixed in the next step.

- [ ] **Step 4: Run prettier to auto-format existing files**

Run: `mise run fmt`
Expected: Prettier rewrites files in-place. `LICENSE.md` is excluded via `.prettierignore`.

- [ ] **Step 5: Review the diff**

Run: `git diff`
Expected: Only whitespace/formatting changes. No content changes. Verify `LICENSE.md` is untouched.

- [ ] **Step 6: Commit**

```bash
git add .prettierrc.yaml .prettierignore
git commit -m "chore: add prettier config"
```

Then commit formatting fixes separately so the intent is clear:

```bash
git add -A
git commit -m "style: format existing files with prettier"
```

---

### Task 3: yamllint setup

**Files:**
- Create: `.yamllint.yml`

- [ ] **Step 1: Create `.yamllint.yml`**

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

- [ ] **Step 2: Run yamllint on the repo**

Run: `mise run lint:yaml`
Expected: Either clean output (no violations) or a list of violations to fix. Since prettier already formatted the YAML files, most formatting issues should be resolved. Any remaining violations are likely content issues (e.g., long lines over 120 chars).

- [ ] **Step 3: Fix any yamllint violations**

yamllint has no auto-fix mode. Manually fix any reported violations. Common fixes:
- Lines over 120 chars: break long strings or expressions across lines
- Missing newline at end of file: add trailing newline (prettier should have handled this)
- Comments spacing: ensure a space after `#`

- [ ] **Step 4: Re-run yamllint to confirm clean**

Run: `mise run lint:yaml`
Expected: Clean output, no violations.

- [ ] **Step 5: Commit**

```bash
git add .yamllint.yml
git commit -m "chore: add yamllint config"
```

If existing files were fixed:

```bash
git add -A
git commit -m "style: fix yamllint violations in existing files"
```

---

### Task 4: markdownlint setup

**Files:**
- Create: `.markdownlint-cli2.yaml`

- [ ] **Step 1: Create `.markdownlint-cli2.yaml`**

```yaml
config:
  MD013:
    line_length: 120
  MD033:
    allowed_elements:
      - "details"
      - "summary"
```

- [ ] **Step 2: Run markdownlint on the repo**

Run: `mise run lint:markdown`
Expected: A list of violations in existing Markdown files. Common issues: missing blank lines around headings, inconsistent list markers, trailing spaces, line length.

- [ ] **Step 3: Auto-fix what markdownlint can fix**

Run: `mise run fix:markdown`
Expected: markdownlint-cli2 fixes violations in-place where possible. Some violations may require manual fixes (e.g., line length, restructuring).

- [ ] **Step 4: Manually fix remaining violations**

Run: `mise run lint:markdown`
Review any remaining violations and fix them manually. If a rule produces false positives on a specific file, add an inline disable comment or add a file-specific override to `.markdownlint-cli2.yaml`:

```yaml
config:
  MD013:
    line_length: 120
  MD033:
    allowed_elements:
      - "details"
      - "summary"

# Per-file overrides if needed:
# ignores:
#   - "SOME_FILE.md"
```

- [ ] **Step 5: Re-run markdownlint to confirm clean**

Run: `mise run lint:markdown`
Expected: Clean output, no violations.

- [ ] **Step 6: Commit**

```bash
git add .markdownlint-cli2.yaml
git commit -m "chore: add markdownlint config"
```

If existing files were fixed:

```bash
git add -A
git commit -m "style: fix markdownlint violations in existing files"
```

---

### Task 5: actionlint verification

**Files:**
- None created (actionlint uses no config file by default)

- [ ] **Step 1: Run actionlint on existing workflows**

Run: `mise run lint:actions`
Expected: actionlint checks `.github/workflows/release-changesets.yml` and `.github/workflows/auto-merge-dependabot.yml`. Either clean output or a list of issues.

- [ ] **Step 2: Fix any actionlint violations**

Fix any reported issues in the workflow files. Common actionlint findings:
- Unknown action versions
- Type mismatches in expressions
- Missing permissions
- Deprecated syntax

- [ ] **Step 3: Re-run actionlint to confirm clean**

Run: `mise run lint:actions`
Expected: Clean output, no violations.

- [ ] **Step 4: Commit (only if files were changed)**

```bash
git add .github/workflows/
git commit -m "fix: resolve actionlint violations in existing workflows"
```

---

### Task 6: lefthook setup

**Files:**
- Create: `lefthook.yml`

- [ ] **Step 1: Create `lefthook.yml`**

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

- [ ] **Step 2: Install lefthook git hooks**

Run: `lefthook install`
Expected: lefthook installs the pre-commit hook into `.git/hooks/pre-commit`. Output confirms installation.

- [ ] **Step 3: Verify hook is installed**

Run: `cat .git/hooks/pre-commit | head -5`
Expected: Script content referencing lefthook.

- [ ] **Step 4: Commit**

```bash
git add lefthook.yml
git commit -m "chore: add lefthook pre-commit hooks for linting and formatting"
```

Note: This commit itself will trigger the pre-commit hook, which validates the setup end-to-end. If it passes, the hook is working.

---

### Task 7: CI workflow

**Files:**
- Create: `.github/workflows/lint.yml`

- [ ] **Step 1: Create `.github/workflows/lint.yml`**

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

- [ ] **Step 2: Run actionlint on the new workflow**

Run: `actionlint .github/workflows/lint.yml`
Expected: Clean output. The new workflow itself must pass actionlint.

- [ ] **Step 3: Run the full check suite**

Run: `mise run check`
Expected: All checks pass — `fmt:check` and all three linters report clean.

- [ ] **Step 4: Commit**

```bash
git add .github/workflows/lint.yml
git commit -m "ci: add lint workflow for PRs and pushes to main"
```

---

### Task 8: Update AGENTS.md

**Files:**
- Modify: `AGENTS.md`

- [ ] **Step 1: Add lint workflow to the directory tree**

In the `## What's Here` section, add `lint.yml` to the workflows list:

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

- [ ] **Step 2: Add mise and lefthook to the Tech Stack section**

Add these entries to the existing Tech Stack list:

```markdown
- **mise** as the tool manager and task runner
- **lefthook** for git hooks (pre-commit linting and formatting)
```

- [ ] **Step 3: Add Code Quality section**

Add a new `## Code Quality` section between `## Tech Stack` and `## Conventions`:

```markdown
## Code Quality

- `mise run check` — run all checks (format + lint)
- `mise run fmt` — auto-format YAML and Markdown
- `mise run lint` — run all linters
- `mise run lint:actions` — actionlint only
- `mise run lint:yaml` — yamllint only
- `mise run lint:markdown` — markdownlint-cli2 only

Lefthook runs formatting and linting automatically on pre-commit.
```

- [ ] **Step 4: Fix stale reference in "Files Local to This Repo"**

The current text references "the setup-node-pnpm action" which was removed. Update line 60 from:

```
`README.md`, `AGENTS.md`, workflow definitions, and the setup-node-pnpm action.
```

To:

```
`README.md`, `AGENTS.md`, and workflow definitions.
```

- [ ] **Step 5: Commit**

```bash
git add AGENTS.md
git commit -m "docs: update AGENTS.md with code quality tooling"
```

---

### Task 9: Final verification

- [ ] **Step 1: Run the full check suite one final time**

Run: `mise run check`
Expected: All checks pass. Zero violations across all linters and formatters.

- [ ] **Step 2: Review git log**

Run: `git log --oneline -10`
Expected: Clean commit history with conventional commit messages. Roughly these commits (order may vary slightly):

```
ci: add lint workflow for PRs and pushes to main
chore: add lefthook pre-commit hooks for linting and formatting
fix: resolve actionlint violations in existing workflows (if needed)
style: fix markdownlint violations in existing files (if needed)
chore: add markdownlint config
style: fix yamllint violations in existing files (if needed)
chore: add yamllint config
style: format existing files with prettier
chore: add prettier config
chore: add mise config with linting and formatting tools
docs: update AGENTS.md with code quality tooling
```

- [ ] **Step 3: Verify lefthook hook works end-to-end**

Make a trivial change to a Markdown file (e.g., add a trailing space), stage it, and attempt a commit. Verify that lefthook's pre-commit hook runs prettier (which removes the trailing space) and the commit succeeds with the auto-fixed file.

Run:
```bash
echo "test  " >> README.md
git add README.md
git commit -m "test: verify lefthook hook"
```

Expected: lefthook runs, prettier removes trailing spaces, commit succeeds. Then revert the test:

```bash
git reset --soft HEAD~1
git checkout README.md
```
