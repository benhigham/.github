Audit project dependencies for security vulnerabilities and maintenance concerns.

Gather context:
- !`cat package.json | head -5` (detect package manager)

Steps:
1. Run the appropriate audit command (`pnpm audit`, `npm audit`, `pip audit`, etc.)
2. Check for known CVEs in the dependency tree
3. Identify unmaintained dependencies (no release in >1 year, archived repo)
4. Check for dependencies with restrictive or changed licenses
5. Review transitive dependency tree depth for supply chain risk

For each finding, assess:
- **Severity:** CRITICAL / HIGH / MEDIUM / LOW
- **Exploitability:** Is this reachable from our code?
- **Fix available:** Is there a patched version?

Output:
- If vulnerabilities found: create GitHub issue with `security` and `dependencies` labels, listing all findings with remediation steps
- If clean: comment on the most recent commit or output to stdout
