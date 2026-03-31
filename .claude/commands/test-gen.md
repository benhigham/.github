Find source files changed in this PR that lack adequate test coverage. $ARGUMENTS

## Context

- !`gh pr diff --name-only`

## Steps

For each changed source file:

1. Check if a co-located test file exists (e.g., `foo.test.ts` next to `foo.ts`)
2. If no test file exists, or existing tests don't cover the changes, generate tests
3. Follow project testing patterns — read existing test files for conventions

## Testing Conventions

- Co-locate tests next to source files
- Use the project's test framework (check package.json)
- Test behaviour, not implementation
- Cover edge cases and error paths
- Use descriptive test names

Commit generated tests on the PR branch with message:
`test: add tests for [component/module]`
