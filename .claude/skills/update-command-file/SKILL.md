---
name: update-command-file
description: >
  Create or update a .claude/commands/*.md command file for use with the claude-invoke composite
  action. Use whenever the user wants to create a new Claude command, add a command file, update
  an existing command, or define how Claude should handle a specific task type (review, audit,
  triage, generation, etc.). Also use when the user mentions "command file" or asks to set up
  automated Claude workflows for a repo.
---

# Update Command File

Create or update `.claude/commands/*.md` files that work with the `claude-invoke` composite action.
Command files in this repo are **reference implementations** — other repos copy and customise them.
This means they should be general enough to work across different tech stacks while being specific
enough to produce consistent, high-quality results.

## Before You Start

Read 2-3 existing command files in `.claude/commands/` to absorb the conventions. Good
representatives that cover different patterns:

- `security-review.md` — focused PR review (context extraction → checklist → inline comments)
- `quality-audit.md` — complex multi-step audit (multiple categories → branch → atomic commits → PR)
- `dependency-audit.md` — tool detection, multi-factor assessment, conditional output

These files are the ground truth for conventions. Match their style and structure.

## Naming

The filename (without `.md`) becomes the command name. It **must** match:

```text
^[a-zA-Z0-9_-]+$
```

Only letters, numbers, hyphens, and underscores. The `claude-invoke` action validates this at
runtime and rejects invalid names. Use **kebab-case** by convention (e.g., `code-review`,
`docs-sync`).

## Structure

Command files generally follow up to four sections. Include whichever are relevant to the
command. No YAML frontmatter — just markdown.

### 1. Opening Line

A single imperative sentence describing the command's purpose. No heading.

**Examples:**

```text
Review the current PR for code quality, security, and convention adherence.
```

```text
Audit project dependencies for security vulnerabilities and maintenance concerns.
```

### 2. Context Section

Gather information Claude needs before starting the task. Use `!` backtick syntax to run
shell commands — these execute when the command is invoked and their output becomes part of
Claude's context.

```markdown
## Context

- !`gh pr view --json title,body,baseRefName,headRefName,additions,deletions`
- !`gh pr diff`
```

Common context patterns:

| Scope          | Commands                                                    |
| -------------- | ----------------------------------------------------------- |
| PR review      | `gh pr view --json ...`, `gh pr diff`                       |
| Issue triage   | `gh issue view --json ...`                                  |
| Tool detection | `ls pnpm-lock.yaml yarn.lock package-lock.json 2>/dev/null` |
| History        | `git log --oneline -20`                                     |
| Conventions    | "Read CLAUDE.md for project conventions."                   |

### 3. Steps Section

Numbered or bulleted procedures. Be specific enough that Claude produces consistent results,
but general enough that the command works across repos with different stacks.

```markdown
## Review Checklist

- Correctness and edge cases
- Type safety (no unnecessary `any`, non-null assertions justified)
- Security implications (injection, secrets, auth)
- Convention adherence per CLAUDE.md
- Test coverage for changed code paths
```

### 4. Output Section

Define what Claude produces and under what conditions. Commands that create artifacts (branches,
PRs, issues) should specify naming conventions and labels.

```markdown
## Output

- If vulnerabilities found: create GitHub issue with `security` and `dependencies`
  labels, listing all findings with remediation steps
- If clean: comment on the most recent commit or output to stdout
```

## Conventions Across Command Files

| Pattern           | Convention                                                                 |
| ----------------- | -------------------------------------------------------------------------- |
| Dynamic arguments | `$ARGUMENTS` placeholder — passed via `command-args` in claude-invoke      |
| Severity levels   | CRITICAL / HIGH / MEDIUM / LOW / INFO (standardised across audit commands) |
| Branch naming     | `chore/TYPE-DATE` or `docs/TYPE-DATE`                                      |
| Commit messages   | Conventional Commits (`docs:`, `test:`, `chore:`, etc.)                    |
| Labels            | Primary + secondary (e.g., `security` + `dependencies`)                    |
| Superseding       | Close older PRs/issues with the same label before creating new ones        |

## How claude-invoke Uses These Files

Understanding the invocation flow helps you write better commands:

1. Caller passes `command: foo` to the `claude-invoke` composite action
2. Action checks if `.claude/commands/foo.md` exists in the **calling repo**
3. If found → Claude is invoked with `/foo {command-args}`
4. If not found → falls back to the `prompt` input (fails if that's also empty)

This means repos get zero-config onboarding (inline `prompt:`) with a clean migration path
to command files. When writing reference commands for this repo, keep them stack-agnostic
where possible so they work as starting points for any consumer.
