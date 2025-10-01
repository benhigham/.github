# Label Reference Guide

This document describes all the standardized labels used across repositories under the `benhigham` organization.

## 📋 Table of Contents

- [Label Selection Decision Tree](#label-selection-decision-tree)
- [Type Labels](#type-labels)
- [Priority Labels](#priority-labels)
- [Status Labels](#status-labels)
- [Size Labels](#size-labels)
- [Area Labels](#area-labels)
- [Dependency Labels](#dependency-labels)
- [Special Labels](#special-labels)
- [Triage Labels](#triage-labels)
- [How to Use Labels](#how-to-use-labels)
  - [For Issues](#for-issues)
  - [For Pull Requests](#for-pull-requests)
  - [Labeling Workflow](#labeling-workflow)
- [Syncing Labels](#syncing-labels)
  - [To This Repository](#to-this-repository)
  - [To Other Repositories](#to-other-repositories)
- [Best Practices](#best-practices)

---

## Label Selection Decision Tree

```mermaid
graph TD
    A[New Issue/PR] --> B{What type?}
    B -->|Bug| C[bug]
    B -->|Feature| D[enhancement]
    B -->|Docs| E[documentation]
    B -->|Other| F[refactoring/performance/testing]
    
    C --> G{How urgent?}
    D --> G
    E --> G
    F --> G
    
    G -->|Critical/Blocks Release| H[priority: critical]
    G -->|Important| I[priority: high]
    G -->|Can Wait| J[priority: medium/low]
    
    H --> K{Size?}
    I --> K
    J --> K
    
    K -->|Auto-labeled| L[size: xs/s/m/l/xl/xxl]
    
    L --> M{What area?}
    M -->|CI/CD| N[area: ci/cd]
    M -->|Security| O[area: security]
    M -->|API/UI| P[area: api/ui]
    
    N --> Q{Status?}
    O --> Q
    P --> Q
    
    Q -->|Waiting| R[status: blocked]
    Q -->|Active| S[status: in progress]
    Q -->|Done| T[status: ready]
    
    style C fill:#d73a4a,color:#fff
    style D fill:#a2eeef
    style E fill:#0075ca,color:#fff
    style H fill:#b60205,color:#fff
    style I fill:#d93f0b,color:#fff
```

---

## Type Labels

These labels categorize the **type** of work being done.

| Label | Color | Description | When to Use |
|-------|-------|-------------|-------------|
| `bug` | ![#d73a4a](https://img.shields.io/badge/-d73a4a-d73a4a?style=flat-square) | Something isn't working | Use for issues reporting bugs or PRs fixing bugs |
| `enhancement` | ![#a2eeef](https://img.shields.io/badge/-a2eeef-a2eeef?style=flat-square) | New feature or request | Use for feature requests or PRs adding new features |
| `documentation` | ![#0075ca](https://img.shields.io/badge/-0075ca-0075ca?style=flat-square) | Improvements or additions to documentation | Use for documentation updates, fixes, or additions |
| `refactoring` | ![#fbca04](https://img.shields.io/badge/-fbca04-fbca04?style=flat-square) | Code refactoring without changing functionality | Use when restructuring code without changing behavior |
| `performance` | ![#ff6b6b](https://img.shields.io/badge/-ff6b6b-ff6b6b?style=flat-square) | Performance improvements | Use for optimizations and performance enhancements |
| `testing` | ![#1d76db](https://img.shields.io/badge/-1d76db-1d76db?style=flat-square) | Adding or updating tests | Use when adding new tests or improving test coverage |

---

## Priority Labels

These labels indicate the **urgency** or **importance** of an issue or PR.

| Label | Color | Description | When to Use |
|-------|-------|-------------|-------------|
| `priority: critical` | `#b60205` ![](https://img.shields.io/badge/-b60205-b60205?style=flat-square) | Critical priority - needs immediate attention | Production issues, security vulnerabilities, complete blockers |
| `priority: high` | `#d93f0b` ![](https://img.shields.io/badge/-d93f0b-d93f0b?style=flat-square) | High priority | Important features, significant bugs affecting many users |
| `priority: medium` | `#fbca04` ![](https://img.shields.io/badge/-fbca04-fbca04?style=flat-square) | Medium priority | Standard features and bug fixes |
| `priority: low` | `#0e8a16` ![](https://img.shields.io/badge/-0e8a16-0e8a16?style=flat-square) | Low priority | Nice-to-have features, minor improvements |

---

## Status Labels

These labels track the **current state** of an issue or PR.

| Label | Color | Description | When to Use |
|-------|-------|-------------|-------------|
| `status: blocked` | `#d73a4a` ![](https://img.shields.io/badge/-d73a4a-d73a4a?style=flat-square) | Blocked by another issue or external dependency | Cannot proceed until blocker is resolved |
| `status: in progress` | `#fbca04` ![](https://img.shields.io/badge/-fbca04-fbca04?style=flat-square) | Currently being worked on | Someone is actively working on this |
| `status: needs review` | `#0e8a16` ![](https://img.shields.io/badge/-0e8a16-0e8a16?style=flat-square) | Needs code review | PR is ready for review |
| `status: needs testing` | `#1d76db` ![](https://img.shields.io/badge/-1d76db-1d76db?style=flat-square) | Needs testing before merge | Code is written but needs QA/testing |
| `status: ready` | `#0e8a16` ![](https://img.shields.io/badge/-0e8a16-0e8a16?style=flat-square) | Ready to be worked on | Issue is well-defined and ready for implementation |

---

## Size Labels

These labels indicate the **size/complexity** of a PR based on lines changed. These are typically auto-assigned by the PR Size Labeler workflow.

| Label | Color | Lines Changed | Description |
|-------|-------|---------------|-------------|
| `size: xs` | `#3cbf00` ![](https://img.shields.io/badge/-3cbf00-3cbf00?style=flat-square) | 1-10 | Trivial changes, typo fixes |
| `size: s` | `#5d9801` ![](https://img.shields.io/badge/-5d9801-5d9801?style=flat-square) | 11-50 | Small changes, minor bug fixes |
| `size: m` | `#7f7203` ![](https://img.shields.io/badge/-7f7203-7f7203?style=flat-square) | 51-200 | Medium-sized feature or refactor |
| `size: l` | `#a14c05` ![](https://img.shields.io/badge/-a14c05-a14c05?style=flat-square) | 201-500 | Large feature or significant refactor |
| `size: xl` | `#c32607` ![](https://img.shields.io/badge/-c32607-c32607?style=flat-square) | 501-1000 | Very large changes |
| `size: xxl` | `#e50009` ![](https://img.shields.io/badge/-e50009-e50009?style=flat-square) | 1000+ | Extremely large - consider splitting |

**Note:** PRs labeled `size: xl` or `size: xxl` should ideally be broken down into smaller, more reviewable chunks.

---

## Area Labels

These labels categorize which **part of the codebase** is affected.

| Label | Color | Description | When to Use |
|-------|-------|-------------|-------------|
| `area: ci/cd` | `#f9d0c4` ![](https://img.shields.io/badge/-f9d0c4-f9d0c4?style=flat-square) | Related to CI/CD pipelines | Changes to GitHub Actions, build processes, deployment |
| `area: security` | `#ee0701` ![](https://img.shields.io/badge/-ee0701-ee0701?style=flat-square) | Related to security | Security fixes, vulnerability patches, security features |
| `area: api` | `#c5def5` ![](https://img.shields.io/badge/-c5def5-c5def5?style=flat-square) | Related to API | API endpoints, API documentation, API contracts |
| `area: ui` | `#bfdadc` ![](https://img.shields.io/badge/-bfdadc-bfdadc?style=flat-square) | Related to user interface | UI components, styling, user experience |

---

## Dependency Labels

These labels indicate **dependency-related** changes.

| Label | Color | Description | When to Use |
|-------|-------|-------------|-------------|
| `dependencies` | `#0366d6` ![](https://img.shields.io/badge/-0366d6-0366d6?style=flat-square) | Pull requests that update a dependency file | Any dependency updates |
| `npm` | `#e99695` ![](https://img.shields.io/badge/-e99695-e99695?style=flat-square) | npm dependency updates | Specifically for npm package updates |
| `github-actions` | `#000000` ![](https://img.shields.io/badge/-000000-000000?style=flat-square) | GitHub Actions workflow updates | Updates to GitHub Actions versions |
| `docker` | `#0db7ed` ![](https://img.shields.io/badge/-0db7ed-0db7ed?style=flat-square) | Docker/container dependency updates | Updates to Docker images or container dependencies |
| `terraform` | `#844fba` ![](https://img.shields.io/badge/-844fba-844fba?style=flat-square) | Terraform dependency updates | Updates to Terraform providers or modules |
| `devcontainers` | `#2496ed` ![](https://img.shields.io/badge/-2496ed-2496ed?style=flat-square) | Development container dependency updates | Updates to devcontainer features or images |
| `git-submodules` | `#fbca04` ![](https://img.shields.io/badge/-fbca04-fbca04?style=flat-square) | Git submodule updates | Updates to Git submodule references |
| `go` | `#00add8` ![](https://img.shields.io/badge/-00add8-00add8?style=flat-square) | Go module dependency updates | Updates to Go module dependencies |

---

## Special Labels

These labels mark **special characteristics** of an issue or PR.

| Label | Color | Description | When to Use |
|-------|-------|-------------|-------------|
| `breaking change` | `#d73a4a` ![](https://img.shields.io/badge/-d73a4a-d73a4a?style=flat-square) | Introduces breaking changes | Changes that break backward compatibility |
| `backport` | `#c5def5` ![](https://img.shields.io/badge/-c5def5-c5def5?style=flat-square) | Should be backported to a previous version | Fixes that need to be applied to older release branches |
| `chore` | `#fef2c0` ![](https://img.shields.io/badge/-fef2c0-fef2c0?style=flat-square) | Maintenance tasks | Routine maintenance, dependency updates, tooling |

---

## Triage Labels

These labels help with **issue management** and **community engagement**.

| Label | Color | Description | When to Use |
|-------|-------|-------------|-------------|
| `triage` | `#ededed` ![](https://img.shields.io/badge/-ededed-ededed?style=flat-square) | Needs triage and investigation | New issues that need review and categorization |
| `duplicate` | `#cfd3d7` ![](https://img.shields.io/badge/-cfd3d7-cfd3d7?style=flat-square) | This issue or pull request already exists | Duplicate of another issue |
| `invalid` | `#e4e669` ![](https://img.shields.io/badge/-e4e669-e4e669?style=flat-square) | This doesn't seem right | Not a valid issue or out of scope |
| `wontfix` | `#ffffff` ![](https://img.shields.io/badge/-ffffff-ffffff?style=flat-square) | This will not be worked on | Intentionally not fixing this |
| `good first issue` | `#7057ff` ![](https://img.shields.io/badge/-7057ff-7057ff?style=flat-square) | Good for newcomers | Suitable for first-time contributors |
| `help wanted` | `#008672` ![](https://img.shields.io/badge/-008672-008672?style=flat-square) | Extra attention is needed | Looking for community help on this |

---

## How to Use Labels

### For Issues

1. **Always start with a type label**: Choose from `bug`, `enhancement`, `documentation`, etc.
2. **Add a priority label**: Indicate urgency with `priority: critical`, `priority: high`, etc.
3. **Add status as work progresses**: Use `status: ready`, `status: in progress`, etc.
4. **Add area labels if relevant**: Tag which part of the codebase is affected
5. **Add triage labels if needed**: Use `good first issue`, `help wanted`, etc.

**Example combinations:**

- `bug` + `priority: critical` + `area: security` = Critical security bug
- `enhancement` + `priority: low` + `good first issue` = Nice-to-have feature, good for beginners
- `documentation` + `priority: medium` + `status: ready` = Documentation task ready to be worked on

### For Pull Requests

1. **Type labels are inherited from the issue** (if linked)
2. **Size labels are auto-assigned** by the PR Size Labeler workflow
3. **Add status labels**: Use `status: needs review`, `status: needs testing`, etc.
4. **Add special labels if needed**: `breaking change`, `dependencies`, etc.

**Example combinations:**

- `bug` + `size: s` + `status: needs review` = Small bug fix awaiting review
- `enhancement` + `size: xl` + `breaking change` = Large feature with breaking changes
- `dependencies` + `npm` + `size: xs` = Small npm dependency update

### Labeling Workflow

```mermaid
graph TD
    A[New Issue/PR Created] --> B{Type?}
    B -->|Bug| C[Add 'bug']
    B -->|Feature| D[Add 'enhancement']
    B -->|Docs| E[Add 'documentation']
    C --> F[Add Priority Label]
    D --> F
    E --> F
    F --> G[Add Area Labels if applicable]
    G --> H[Add Status Labels]
    H --> I[Add Special Labels if needed]
```

---

## Syncing Labels

### To This Repository

Labels are automatically synced to this repository when `.github/labels.yml` is updated via the Sync Labels workflow.

### To Other Repositories

You can sync these labels to any other repository using one of these methods:

#### Method 1: Using github-label-sync CLI

```bash
# Install globally
npm install -g github-label-sync

# Sync to a repository
github-label-sync --access-token $(gh auth token) \
  --labels .github/labels.yml \
  benhigham/your-repo-name
```

#### Method 2: Using GitHub Actions

Create a workflow in your target repository:

```yaml
# .github/workflows/sync-labels.yml
name: Sync Labels

on:
  schedule:
    - cron: '0 0 * * 0' # Weekly
  workflow_dispatch:

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout labels config
        uses: actions/checkout@v4
        with:
          repository: benhigham/.github
          path: .github-templates

      - name: Sync labels
        uses: micnncim/action-label-syncer@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          manifest: .github-templates/.github/labels.yml
```

#### Method 3: Manual via GitHub CLI

```bash
# For each label, create it
gh label create "priority: critical" \
  --repo benhigham/your-repo \
  --color "b60205" \
  --description "Critical priority - needs immediate attention"
```

---

## Best Practices

1. **Be consistent**: Use the same labels across all repositories for easier filtering and searching
2. **Don't over-label**: 3-5 labels per issue/PR is usually sufficient
3. **Update labels as work progresses**: Keep status labels current
4. **Use size labels for scoping**: If a PR gets `size: xl` or larger, consider breaking it down
5. **Prioritize appropriately**: Not everything is `priority: critical`
6. **Auto-label when possible**: Use GitHub Actions to automatically apply labels based on patterns

---

## Questions?

If you have questions about labeling or want to suggest new labels, please [open an issue](https://github.com/benhigham/.github/issues)!

---

## 🔗 Navigation

- [← Back to Home](Home)
- [Getting Started Guide →](Getting-Started)
- [Quick Reference →](Quick-Reference)
- [Troubleshooting →](Troubleshooting)
- [Advanced Usage →](Advanced-Usage)
- [Contributing Guide](https://github.com/benhigham/.github/blob/main/CONTRIBUTING.md)
