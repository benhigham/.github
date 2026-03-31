Check if documentation is still accurate after the changes in this PR. $ARGUMENTS

## Context

- !`gh pr diff --name-only`
- !`gh pr diff`

## Steps

1. Identify changed source files that have corresponding documentation
   (README, JSDoc, inline docs, content/ files)
2. Check if the documentation still accurately describes the code
3. Update any documentation that has drifted
4. If the PR adds new public API, exports, or features — check if they need documenting

Commit documentation updates on the PR branch with message:
`docs: update documentation for [changed area]`
