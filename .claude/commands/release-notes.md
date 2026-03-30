Generate release notes for the latest release (or tag $ARGUMENTS if specified).

Gather context:
- !`gh release view --json tagName,name,isDraft,isPrerelease 2>/dev/null || echo "No release context"`
- !`git log $(git describe --tags --abbrev=0 HEAD~1 2>/dev/null || echo "HEAD~20")..HEAD --oneline --no-merges`

Categorise commits:
- **Features** — `feat:` commits, new capabilities
- **Fixes** — `fix:` commits, bug fixes
- **Breaking Changes** — commits with `BREAKING CHANGE` or `!:` suffix
- **Other** — `chore:`, `docs:`, `refactor:`, `perf:`, `test:` (group by type)

Write user-facing release notes — translate commit messages into plain language. Skip internal refactors unless they affect behaviour.

If this is running in CI on a release event, update the release body using `gh release edit`.
If running locally, output the notes to stdout.
