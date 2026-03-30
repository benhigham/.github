# Code Review

Review the current PR for code quality, security, and convention adherence.

Read CLAUDE.md for project conventions.

## Context

- !`gh pr view --json title,body,baseRefName,headRefName,additions,deletions`
- !`gh pr diff`

## Review Checklist

- Correctness and edge cases
- Type safety (no unnecessary `any`, non-null assertions justified)
- Security implications (injection, secrets, auth)
- Convention adherence per CLAUDE.md
- Test coverage for changed code paths
- Performance considerations

Post specific findings as inline comments. Post a summary comment covering overall
assessment, key changes, and any concerns.
