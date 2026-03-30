# Renovate Review

Review this Renovate dependency update PR.

$ARGUMENTS

## Context

- !`gh pr view --json title,body,labels`
- !`gh pr diff`

## Steps

1. Read the PR body for upgrade details and release notes
2. Check if CI has passed — if still running, note that
3. Assess risk level:
   - Patch: Low risk, check for known issues in release notes
   - Minor: Review changelog for breaking changes despite semver
   - Major: Detailed breaking change analysis required
4. For low-risk updates (patch/minor with green CI): approve with a brief comment
   summarising your assessment
5. For risky updates: comment with specific concerns, do NOT approve
6. If CI fails: analyse the failure, attempt a fix on the branch, push, and comment

Use `gh pr review --approve` for approvals. Do NOT enable auto-merge — the human
reviews and merges manually.
