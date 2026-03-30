Perform a security-focused review of the current PR.

Read CLAUDE.md for project context.

Gather context:
- !`gh pr diff`
- !`gh pr view --json title,body,changedFiles`

OWASP-aligned review checklist:
- **Injection:** SQL, XSS, command injection, template injection
- **Authentication/Authorisation:** Access control changes, session handling
- **Data exposure:** Secrets in code, PII handling, error messages leaking internals
- **Configuration:** Security headers, CORS, CSP changes
- **Dependencies:** New dependencies with known vulnerabilities
- **Cryptography:** Weak algorithms, hardcoded keys, insecure random
- **Input validation:** Missing or inadequate validation on user input

Rate each finding: CRITICAL / HIGH / MEDIUM / LOW / INFO

Post findings as inline comments with severity tags. Post a summary comment with overall security assessment.
