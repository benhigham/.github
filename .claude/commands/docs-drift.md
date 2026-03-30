# Documentation Drift

Verify all documentation is current and accurate. $ARGUMENTS

## Steps

1. Read all documentation files (README.md, docs/, content/ if applicable)
2. For each documented feature/API/pattern, verify the code still matches
3. Check for undocumented public exports, new features, or changed behaviour
4. Verify code examples in docs actually compile/run
5. Check for broken internal links

## Output

- If drift found: create branch `docs/drift-fix-YYYY-MM-DD`, fix issues, open PR
- If clean: output confirmation to stdout
