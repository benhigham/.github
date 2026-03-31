---
name: workflow-scaffold
description: >
  Scaffold a new GitHub Actions reusable workflow or composite action following org conventions.
  Use whenever the user wants to create a new workflow, composite action, or CI/CD automation in
  the .github directory. Also use when asked to add a GitHub Actions workflow, set up CI, create
  an action, or automate a repo task — even if they don't say "scaffold" explicitly.
---

# Workflow Scaffold

Create reusable workflows and composite actions that follow this repository's conventions.
This repo provides shared automation for all `benhigham` GitHub repositories, so correctness
and convention adherence matter — downstream repos inherit what you build here.

## Before You Start

1. Read CLAUDE.md for the full conventions (it is the canonical source; this skill summarises
   the key points but CLAUDE.md wins on any conflict)
2. Ask the user which type they need if not obvious from context:
   - **Reusable workflow** (`workflow_call`) — called by other repos' workflows
   - **Composite action** (`using: composite`) — reusable steps embedded in a caller's job

## Conventions

These rules exist because downstream repos depend on this repo's workflows and actions.
Breaking them can silently affect every consumer.

### Both Types

- Input names use **kebab-case**
- Inputs have descriptive `description` fields
- External actions pinned to **full commit SHAs** with a version comment:
  `owner/repo@<40-char-sha> # vX`
- Shell scripts start with `set -euo pipefail`
- Use **environment variables** (not `${{ inputs }}` or `${{ github.event }}` directly) in
  `run:` blocks — this prevents script injection from user-controlled values like PR titles
  or branch names
- Secrets are passed explicitly (composite actions cannot inherit secrets)

### Reusable Workflows

- Triggered by `workflow_call` with typed inputs
- Every job has `timeout-minutes`
- Permissions are minimal — declare only what's needed, never `write-all`
- Concurrency group is **prefixed** to namespace separately from the caller:
  `group: <prefix>-${{ github.workflow }}-${{ github.ref }}`
- Set `cancel-in-progress` appropriately (true for lint/test, false for releases)

### Composite Actions

- `using: composite` in the `runs:` block
- **Input validation as the first step** — fail fast on missing or invalid input
- `shell: bash` on every `run:` step (composite actions don't inherit the caller's shell)
- Env vars passed via `env:` block on each step (no global env in composite actions)

## Templates

### Reusable Workflow

```yaml
name: <Descriptive Name>

on:
  workflow_call:
    inputs:
      example-input:
        description: What this input controls
        type: string
        required: true

concurrency:
  group: <prefix>-${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

permissions:
  contents: read

jobs:
  example:
    name: <Descriptive job name>
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - name: Checkout repository
        uses: actions/checkout@<sha> # v6

      - name: Run task
        shell: bash
        run: |
          set -euo pipefail
          echo "Running with input: $EXAMPLE_INPUT"
        env:
          EXAMPLE_INPUT: ${{ inputs.example-input }}
```

### Composite Action

```yaml
name: "<Action Name>"
description: "What this action does — one sentence."

inputs:
  example-input:
    description: "What this input controls"
    required: true

runs:
  using: composite
  steps:
    - name: Validate inputs
      shell: bash
      run: |
        set -euo pipefail
        if [ -z "$EXAMPLE_INPUT" ]; then
          echo "::error::<action-name>: example-input is required"
          exit 1
        fi
      env:
        EXAMPLE_INPUT: ${{ inputs.example-input }}

    - name: Do the thing
      shell: bash
      run: |
        set -euo pipefail
        echo "Processing: $EXAMPLE_INPUT"
      env:
        EXAMPLE_INPUT: ${{ inputs.example-input }}
```

## File Placement

- Reusable workflows → `.github/workflows/<name>.yml`
- Composite actions → `.github/actions/<name>/action.yml`

## Real Examples in This Repo

Read these for patterns beyond the templates:

- `.github/workflows/lint.yml` — minimal workflow (checkout → mise → run tasks)
- `.github/workflows/release-changesets.yml` — reusable workflow with multiple inputs, OIDC
  publishing, and `cancel-in-progress: false`
- `.github/actions/setup-terraform/action.yml` — minimal composite action (single step, no inputs)
- `.github/actions/setup-node-pnpm/action.yml` — conditional step execution and boolean input
  validation
- `.github/actions/claude-invoke/action.yml` — complex input validation with regex, multi-step
  prompt resolution, and step output piping
