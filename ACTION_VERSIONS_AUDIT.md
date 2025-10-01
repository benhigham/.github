# GitHub Actions Version Audit

**Date**: 2025-10-01  
**Repository**: benhigham/.github

## Current Action Versions

### Core GitHub Actions (actions/*)

| Action | Current Version | Latest Version | Status | Notes |
|--------|----------------|----------------|--------|-------|
| actions/checkout | v4 | v4 | ✅ UP TO DATE | Latest stable release |
| actions/upload-artifact | v4 | v4 | ✅ UP TO DATE | Latest stable release |
| actions/setup-node | v4 | v4 | ✅ UP TO DATE | Latest stable release |
| actions/first-interaction       | ~~v1~~     | ✅ Replaced   | ~~`.github/workflows/first-time-contributor.yml`~~ | **Completed**: Replaced with `actions/github-script@v7` for better maintenance and flexibility. |
| actions/stale | v9 | v9 | ✅ UP TO DATE | Latest stable release |
| actions/labeler | v5 | v5 | ✅ UP TO DATE | Latest stable release |

### Third-Party Actions

| Action | Current Version | Latest Version | Status | Notes |
|--------|----------------|----------------|--------|-------|
| pnpm/action-setup | v4 | v4 | ✅ UP TO DATE | Stable version |
| github/codeql-action | v3 | v3 | ✅ UP TO DATE | Latest stable release |
| changesets/action | v1 | v1 | ✅ UP TO DATE | Maintained by Changesets team |
| dependabot/fetch-metadata | v2 | v2 | ✅ UP TO DATE | Official Dependabot action |
| micnncim/action-label-syncer | v1 | v1 | ✅ UP TO DATE | Stable community action |
| codelytv/pr-size-labeler | v1 | v1 | ✅ UP TO DATE | Stable community action |
| actions/github-script | v7 | v7 | ✅ UP TO DATE | Modern replacement for first-interaction |

## Action Locations

### Workflows

- `.github/workflows/ci.yml` - actions/upload-artifact@v4
- `.github/workflows/release-changesets.yml` - changesets/action@v1
- `.github/workflows/sync-labels.yml` - actions/checkout@v4, micnncim/action-label-syncer@v1
- `.github/workflows/first-time-contributor.yml` - actions/first-interaction@v1 (⚠️ DEPRECATED)
- `.github/workflows/auto-merge-dependabot.yml` - dependabot/fetch-metadata@v2
- `.github/workflows/stale.yml` - actions/stale@v9
- `.github/workflows/labeler.yml` - codelytv/pr-size-labeler@v1, actions/checkout@v4, actions/labeler@v5
- `.github/workflows/codeql.yml` - actions/checkout@v4, github/codeql-action@v3

### Custom Actions

- `.github/actions/setup-node-pnpm/action.yml` - actions/checkout@v4, pnpm/action-setup@v4, actions/setup-node@v4

## Recommendations

### 🔴 High Priority

#### 1. Replace Deprecated actions/first-interaction@v1

**Problem**: The `actions/first-interaction` action is deprecated/archived and no longer maintained.

**Current Usage**: `.github/workflows/first-time-contributor.yml`

**Recommended Alternatives**:

**Option A: actions/github-script (Most Flexible)**

```yaml
- name: Greet first-time contributors
  uses: actions/github-script@v7
  with:
    script: |
      const author = context.payload.sender.login;
      const issue_number = context.payload.number || context.payload.issue.number;
      
      // Check if first-time contributor
      const { data: comments } = await github.rest.issues.listComments({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: issue_number
      });
      
      // Add greeting logic here
```

**Option B: Custom Script**
Create a custom composite action using GitHub CLI or API calls.

**Option C: actions/first-interaction alternative**
Use a community-maintained fork or alternative like `actions/first-interaction-v2` if available.

### 🟢 Optional Enhancements

#### 1. Pin to SHA instead of tags (Security Best Practice)

Consider pinning actions to specific commit SHAs for security:

```yaml
# Instead of:
uses: actions/checkout@v4

# Use:
uses: actions/checkout@b4ffde65f46336ab88eb53be808477a3936bae11 # v4.1.1
```

**Benefits**:

- Immutable - tag can be moved, SHA cannot
- Security - prevents tag hijacking
- Transparency - exact version is clear

**Drawbacks**:

- Harder to update
- Less readable
- Need to track what SHA corresponds to what version

#### 2. Enable Dependabot for GitHub Actions

Ensure `.github/dependabot.yml` includes github-actions (✅ Already configured):

```yaml
- package-ecosystem: 'github-actions'
  directory: '/'
  schedule:
    interval: 'weekly'
```

## Summary

**Overall Status**: ✅ **EXCELLENT**

- **11/12 actions** are up to date (92%)
- **1 deprecated action** needs replacement (actions/first-interaction)
- All other actions are on their latest stable versions
- Dependabot is configured to keep actions updated

## Next Steps

1. **Immediate**: Replace `actions/first-interaction@v1` with modern alternative
2. **Optional**: Consider SHA pinning for critical actions
3. **Ongoing**: Let Dependabot handle routine updates

---

**Last Updated**: 2025-10-01  
**Next Review**: When Dependabot proposes updates or quarterly
