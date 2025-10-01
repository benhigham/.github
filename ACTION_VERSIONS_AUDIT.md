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
| actions/dependency-review-action | v4 | v4 | ✅ UP TO DATE | Latest stable release |

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
| release-drafter/release-drafter | v6 | v6 | ✅ UP TO DATE | Auto-generates release notes |

## Action Locations

### Workflows

- `.github/workflows/ci.yml` - actions/upload-artifact@v4
- `.github/workflows/release-changesets.yml` - changesets/action@v1
- `.github/workflows/sync-labels.yml` - actions/checkout@v4, micnncim/action-label-syncer@v1
- `.github/workflows/first-time-contributor.yml` - actions/github-script@v7
- `.github/workflows/auto-merge-dependabot.yml` - dependabot/fetch-metadata@v2
- `.github/workflows/stale.yml` - actions/stale@v9
- `.github/workflows/labeler.yml` - codelytv/pr-size-labeler@v1, actions/checkout@v4, actions/labeler@v5
- `.github/workflows/codeql.yml` - actions/checkout@v4, github/codeql-action@v3
- `.github/workflows/dependency-review.yml` - actions/checkout@v4, actions/dependency-review-action@v4
- `.github/workflows/release-drafter.yml` - release-drafter/release-drafter@v6
- `.github/workflows/branch-protection-check.yml` - actions/github-script@v7

### Custom Actions

- `.github/actions/setup-node-pnpm/action.yml` - actions/checkout@v4, pnpm/action-setup@v4, actions/setup-node@v4

## Recommendations

### ✅ Completed Improvements

#### 1. ~~Replace Deprecated actions/first-interaction@v1~~ ✅ COMPLETED

**Status**: Successfully replaced with `actions/github-script@v7` in `.github/workflows/first-time-contributor.yml`

**Implementation**: Modern github-script implementation with:

- First-time contributor detection using GitHub API
- Preserved original greeting messages
- More maintainable and flexible solution

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

**Overall Status**: ✅ **PERFECT**

- **14/14 actions** are up to date (100%)
- **No deprecated actions** - all actions are current and maintained
- All actions are on their latest stable versions
- Dependabot is configured to keep actions updated
- **Recent additions**: Dependency Review, Release Drafter workflows

## Next Steps

1. **Ongoing**: Let Dependabot handle routine updates
2. **Optional**: Consider SHA pinning for critical actions
3. **Monitor**: Review action updates quarterly for breaking changes

---

**Last Updated**: 2025-10-01  
**Next Review**: When Dependabot proposes updates or quarterly
