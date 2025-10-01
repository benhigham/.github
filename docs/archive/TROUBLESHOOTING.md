# Troubleshooting Guide

Common issues and solutions when using the reusable workflows.

## 📋 Table of Contents

- [CI Workflow Issues](#ci-workflow-issues)
- [Release Workflow Issues](#release-workflow-issues)
- [Dependency Review Issues](#dependency-review-issues)
- [Auto-merge Not Working](#auto-merge-not-working)
- [Workflow Configuration Issues](#workflow-configuration-issues)
- [CodeQL Issues](#codeql-issues)
- [Getting More Help](#getting-more-help)

---

## CI Workflow Issues

### Problem: "Module not found" errors

```
Error: Cannot find module 'package-name'
```

**Solution:**

- Ensure `pnpm-lock.yaml` is committed and up-to-date
- Run `pnpm install` locally and commit any lockfile changes
- Check that the package is listed in `package.json` dependencies

### Problem: Timeout on test job

```
Error: The operation was canceled.
```

**Solution:**

- Increase `timeout-minutes` in your workflow call
- Optimize your tests (split into smaller suites, remove unnecessary waits)
- Check for infinite loops or hanging promises

### Problem: Cache not working

```
Cache not found for input keys: ...
```

**Solution:**

- Verify the cache key pattern in setup-node action
- Check if you've recently changed Node.js or pnpm versions
- First run after version change won't have cache (expected)

---

## Release Workflow Issues

### Problem: "No permission to publish to npm"

```
Error: 403 Forbidden - PUT https://registry.npmjs.org/package-name
```

**Solution:**

- Verify `NPM_TOKEN` is set in repository secrets
- Ensure the token has publish permissions
- Check the package name isn't taken (for first publish)
- Verify you're a collaborator on existing package

### Problem: "No changesets found"

```
Error: No changesets present
```

**Solution:**

- Run `pnpm changeset` before committing changes
- Ensure `.changeset/*.md` files are committed
- Check that `.changeset/config.json` is properly configured

### Problem: Build step failing during release

```
Error: Command failed: pnpm run build
```

**Solution:**

- Test build locally first: `pnpm run build`
- Ensure all dependencies are in `dependencies`, not `devDependencies`
- Check that build outputs are in `.npmignore` or `files` in package.json

---

## Dependency Review Issues

### Problem: False positives on vulnerability scan

```
Error: Dependency review detected vulnerabilities
```

**Solution:**

- Review the vulnerability details in the PR comment
- If false positive, adjust `fail-on-severity` to `high` or `critical`
- Use `allow-licenses` to permit specific packages if needed
- Consider adding to allow list if it's a known safe dependency

---

## Auto-merge Not Working

### Problem: Dependabot PRs not merging automatically

```
No auto-merge triggered
```

**Solution:**

- Ensure required status checks are passing
- Verify branch protection allows auto-merge
- Check that `auto-merge-patch`, `auto-merge-minor`, or `auto-merge-major` is `true`
- Ensure the PR is from `dependabot[bot]` (check actor)

### Problem: "Required reviews not met"

```
Error: Pull request is not mergeable
```

**Solution:**

- Configure branch protection to not require reviews for Dependabot
- Or set up code owners to auto-approve Dependabot PRs
- Or manually approve before auto-merge can trigger

---

## Workflow Configuration Issues

### Problem: "Workflow file is invalid"

```
Error: Invalid workflow file
```

**Solution:**

- Validate YAML syntax (use a YAML linter)
- Check indentation (YAML is whitespace-sensitive)
- Ensure all required fields are present
- Review GitHub Actions documentation for correct syntax

### Problem: "Workflow not triggering"

```
No workflow runs appearing
```

**Solution:**

- Check that the trigger event matches (e.g., `pull_request` vs `pull_request_target`)
- Verify the workflow file is in `.github/workflows/`
- Ensure the workflow file has `.yml` or `.yaml` extension
- Check if workflow is disabled in repository settings
- Review branch filters if specified

### Problem: "Secret not found"

```
Error: Secret NPM_TOKEN not found
```

**Solution:**

- Add the secret in repository Settings → Secrets and variables → Actions
- Ensure secret name matches exactly (case-sensitive)
- For organization secrets, verify repository has access
- Check that you're passing secrets correctly in workflow call

---

## CodeQL Issues

### Problem: "No code found to analyze"

```
Error: No source code was found
```

**Solution:**

- Verify the `languages` input includes your project's language
- Check that source files are in standard locations
- For compiled languages, ensure build commands are correct
- Review CodeQL configuration for path filters

### Problem: Build failing for compiled languages

```
Error: Build failed
```

**Solution:**

- Customize `build-command` input with correct build steps
- Ensure all build dependencies are available
- Check that the build environment matches your local setup

---

## Getting More Help

If you're still stuck:

1. **Check workflow logs** - Click on the failed run to see detailed logs
2. **Enable debug logging** - Add `ACTIONS_STEP_DEBUG: true` to secrets
3. **Search GitHub Discussions** - Others may have had similar issues
4. **Review GitHub Actions documentation** - [docs.github.com/actions](https://docs.github.com/actions)
5. **Open an issue** - If you think there's a bug in the workflow

---

## 🔗 Related Documentation

- [Quick Reference](QUICK_REFERENCE.md) - Basic workflow syntax
- [Advanced Usage](ADVANCED_USAGE.md) - Complex configurations
- [README](README.md) - Overview and getting started

---

**Last Updated**: 2025-10-01

---

## 🔗 Navigation

- [← Back to Quick Reference](QUICK_REFERENCE.md)
- [← Back to README](README.md)
- [Getting Started Guide →](GETTING_STARTED.md)
- [Advanced Usage →](ADVANCED_USAGE.md)
- [Labels Reference →](LABELS.md)
- [Contributing Guide →](CONTRIBUTING.md)
