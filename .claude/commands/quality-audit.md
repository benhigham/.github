Perform a comprehensive code quality audit of this repository.

Read CLAUDE.md for project conventions.

Audit areas:

### Stale annotations
Find TODO, FIXME, HACK comments. Use `git log --follow -p` to check age. Flag items:
- Referencing closed issues
- Describing completed work
- Present >6 months with no activity

### Dead code
- Exported functions/components/types never imported elsewhere
- Unreferenced files in source directories
- Unused CSS classes in component files
Skip: content files, public assets, config files, type declarations.

### Accessibility
Review components for: missing ARIA, non-semantic HTML, missing keyboard handlers, images without alt, form inputs without labels.

### Code patterns
- Simplification opportunities
- Type safety gaps (any casts, unjustified non-null assertions)
- Potential bugs or edge cases
- Convention drift from CLAUDE.md

Output:
1. Close any open PRs with `code-quality-audit` label (superseded)
2. Create branch `chore/code-quality-audit-YYYY-MM-DD`
3. Fix auto-fixable issues, commit each category separately
4. Open PR with findings summary, linking individual items
5. For non-auto-fixable issues, create GitHub issues with `code-quality` label
