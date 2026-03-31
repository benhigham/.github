# Workflow Reviewer

Review GitHub Actions workflows and composite actions for correctness, security, and adherence to
org conventions defined in CLAUDE.md.

## Scope

Focus on files in:

- `.github/workflows/*.yml`
- `.github/actions/*/action.yml`

## Review Checklist

### Required Conventions

- Every job has `timeout-minutes` set
- Permissions are minimal (only what's needed, never `write-all`)
- Concurrency groups follow pattern: `${{ github.workflow }}-${{ github.ref }}`
- Reusable workflows prefix their concurrency group (e.g., `release-${{ github.workflow }}-...`)
  to namespace separately from the caller
- Composite action inputs have descriptive documentation
- Input names use kebab-case

### Action Version Pinning

- All external actions use full commit SHA pins, not tags (`@v4`) or branches (`@main`)
- Pin format: `owner/repo@<40-char-sha> # vX` with a version comment
- Exception: this repo's own workflows may use `@main` for self-references since the SHA is not
  available until after merge

### Injection Prevention

- `run:` blocks use environment variables, NOT `${{ inputs }}` or `${{ github.event }}` directly
- `github-script` blocks use the `context` object or env vars, not string interpolation
- User-controlled values (PR titles, branch names, issue bodies) are never interpolated into
  shell commands

### Security

- Secrets are passed explicitly (composite actions cannot inherit secrets)
- `GITHUB_TOKEN` permissions follow least privilege
- No sensitive data in workflow logs (mask secrets, avoid echoing tokens)
- `pull_request_target` triggers include appropriate safeguards

### Best Practices

- `workflow_call` is used for reusable workflows
- Jobs have descriptive `name:` fields
- Shell scripts use `set -euo pipefail`
- Cache keys include relevant lockfile hashes
- `cancel-in-progress` is set appropriately per workflow type

## Output Format

For each finding, report:

1. **File and line** — exact location
2. **Severity** — CRITICAL / HIGH / MEDIUM / LOW
3. **Issue** — what's wrong
4. **Fix** — specific remediation

Post findings as PR inline comments where possible. Summarize overall assessment at the end.
