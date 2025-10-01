# Repository Improvement Tasks

**Created**: 2025-10-01  
**Based on**: ANALYSIS.md  
**Status**: In Progress  

---

## 🔴 Phase 1: Critical Fixes (Today - 45 minutes)

### Task 1.1: Use Custom Action in CI Workflow ⚠️ CRITICAL

**Problem**: The `setup-node-pnpm` action exists but is unused. Setup steps are duplicated 4 times in ci.yml.

**Files to modify**: `.github/workflows/ci.yml`

**Changes needed**:

- [ ] Replace setup steps in `lint` job (lines ~84-102)
- [ ] Replace setup steps in `typecheck` job (lines ~114-132)
- [ ] Replace setup steps in `test` job (lines ~144-162)
- [ ] Replace setup steps in `build` job (lines ~182-200)

**Before** (repeated 4 times):

```yaml
- name: Checkout repository
  uses: actions/checkout@v4
- name: Setup pnpm
  uses: pnpm/action-setup@v4
  with:
    version: ${{ inputs.pnpm-version }}
    run_install: false
- name: Setup Node.js
  uses: actions/setup-node@v4
  with:
    node-version: ${{ inputs.node-version }}
    node-version-file: package.json
    cache: pnpm
    cache-dependency-path: "**/pnpm-lock.yaml"
- name: Install dependencies
  run: pnpm install --frozen-lockfile
  timeout-minutes: 5
```

**After** (single line):

```yaml
- name: Setup Node.js with pnpm
  uses: benhigham/.github/.github/actions/setup-node-pnpm@main
  with:
    node-version: ${{ inputs.node-version }}
    pnpm-version: ${{ inputs.pnpm-version }}
```

**Impact**:

- Eliminates ~80 lines of duplicate code
- Single source of truth for setup
- Easier maintenance

**Estimated time**: 15 minutes  
**Priority**: 🔴 Critical  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

### Task 1.2: Use Custom Action in Release Workflow ⚠️ CRITICAL

**Problem**: The `setup-node-pnpm` action exists but is unused. Setup steps are duplicated in release-changesets.yml.

**Files to modify**: `.github/workflows/release-changesets.yml`

**Changes needed**:

- [ ] Replace setup steps in `release` job (lines ~77-96)

**Before**:

```yaml
- name: Checkout repository
  uses: actions/checkout@v5
- name: Setup pnpm
  uses: pnpm/action-setup@v4
  with:
    version: ${{ inputs.pnpm-version }}
    run_install: false
- name: Setup Node.js
  id: setup-node
  uses: actions/setup-node@v5
  with:
    node-version: ${{ inputs.node-version }}
    node-version-file: package.json
    cache: pnpm
    cache-dependency-path: "**/pnpm-lock.yaml"
- name: Install dependencies
  run: pnpm install --frozen-lockfile
  timeout-minutes: 5
```

**After**:

```yaml
- name: Setup Node.js with pnpm
  id: setup-node
  uses: benhigham/.github/.github/actions/setup-node-pnpm@main
  with:
    node-version: ${{ inputs.node-version }}
    pnpm-version: ${{ inputs.pnpm-version }}
```

**Note**: Keep the `id: setup-node` as it's referenced in outputs.

**Impact**:

- Eliminates ~20 lines of duplicate code
- Consistency with CI workflow

**Estimated time**: 5 minutes  
**Priority**: 🔴 Critical  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

### Task 1.3: Add Missing Dependency Labels 🏷️ CRITICAL

**Problem**: 5 Dependabot ecosystems lack corresponding labels.

**Files to modify**: `.github/labels.yml`

**Changes needed**:

- [ ] Add `docker` label after `npm` label
- [ ] Add `terraform` label
- [ ] Add `devcontainers` label
- [ ] Add `git-submodules` label
- [ ] Add `go` label
- [ ] Update LABELS.md to document new labels

**Labels to add** (after line 95, in the dependency labels section):

```yaml
- name: 'docker'
  color: '0db7ed'
  description: 'Docker image updates'

- name: 'terraform'
  color: '7b42bc'
  description: 'Terraform dependency updates'

- name: 'devcontainers'
  color: '2496ed'
  description: 'Development container updates'

- name: 'git-submodules'
  color: '6e5494'
  description: 'Git submodule updates'

- name: 'go'
  color: '00add8'
  description: 'Go module updates'
```

**Impact**:

- Complete label coverage for all Dependabot ecosystems
- Better organization of dependency PRs

**Estimated time**: 10 minutes  
**Priority**: 🔴 Critical  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

### Task 1.4: Update LABELS.md with New Labels 📖

**Problem**: Documentation needs to include new dependency labels.

**Files to modify**: `LABELS.md`

**Changes needed**:

- [ ] Add new labels to Dependency Labels table
- [ ] Update label count from 37 to 42
- [ ] Update README.md label count from 37 to 42

**Location**: In the "Dependency Labels" section (around line 235)

**Estimated time**: 5 minutes  
**Priority**: 🔴 Critical  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

### Task 1.5: Add Timeout to sync-labels Workflow ⏱️

**Problem**: sync-labels.yml workflow lacks job timeout.

**Files to modify**: `.github/workflows/sync-labels.yml`

**Changes needed**:

- [ ] Add `timeout-minutes: 5` to `sync` job (after line 17)

**Before**:

```yaml
jobs:
  sync:
    name: Sync Repository Labels
    runs-on: ubuntu-latest
    steps:
```

**After**:

```yaml
jobs:
  sync:
    name: Sync Repository Labels
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
```

**Impact**:

- Prevents hung workflows
- Consistent with other workflows

**Estimated time**: 2 minutes  
**Priority**: 🔴 Critical  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

### Task 1.6: Add Timeout to first-time-contributor Workflow ⏱️

**Problem**: first-time-contributor.yml workflow lacks job timeout.

**Files to modify**: `.github/workflows/first-time-contributor.yml`

**Changes needed**:

- [ ] Add `timeout-minutes: 5` to `greeting` job (after line 15)

**Before**:

```yaml
jobs:
  greeting:
    name: Greet First-Time Contributors
    runs-on: ubuntu-latest
    steps:
```

**After**:

```yaml
jobs:
  greeting:
    name: Greet First-Time Contributors
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
```

**Impact**:

- Prevents hung workflows
- Consistent with other workflows

**Estimated time**: 2 minutes  
**Priority**: 🔴 Critical  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

### Task 1.7: Update CHANGELOG.md 📋

**Problem**: Changes need to be documented.

**Files to modify**: `CHANGELOG.md`

**Changes needed**:

- [ ] Add new entries under [Unreleased] > Changed section

**Content to add**:

```markdown
### Changed

- Refactored all workflows to use custom setup-node-pnpm action, eliminating code duplication
- Added missing dependency labels for docker, terraform, devcontainers, git-submodules, and go
- Added timeout constraints to sync-labels and first-time-contributor workflows
```

**Estimated time**: 3 minutes  
**Priority**: 🔴 Critical  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

## 🟡 Phase 2: Consistency Improvements (This Week - 1 hour)

### Task 2.1: Standardize Action Versions 🔧

**Problem**: Mix of v4 and v5 action versions.

**Files to modify**: `.github/workflows/release-changesets.yml`

**Decision needed**: Keep v4 or upgrade to v5?

**Option A - Downgrade to v4 (Recommended for consistency)**:

- [ ] Change `actions/checkout@v5` to `actions/checkout@v4` (line 77)
- [ ] Change `actions/setup-node@v5` to `actions/setup-node@v4` (line 87)

**Option B - Upgrade all to v5**:

- [ ] Change all `actions/checkout@v4` to `@v5` across all workflows (9 occurrences)
- [ ] Change all `actions/setup-node@v4` to `@v5` across all workflows (5 occurrences)
- [ ] Update AGENTS.md to recommend v5

**Note**: If using custom action (Task 1.1-1.2), this only affects the action itself and non-Node workflows.

**Impact**:

- Version consistency
- Easier maintenance

**Estimated time**: 5 minutes (Option A) or 30 minutes (Option B)  
**Priority**: 🟡 Medium  
**Assigned to**: -  
**Status**: ⬜ Not Started  
**Recommendation**: Option A (stay on v4)

---

### Task 2.2: Complete CONTRIBUTING.md 📝

**Problem**: Development setup section is empty/incomplete.

**Files to modify**: `CONTRIBUTING.md`

**Changes needed**:

- [ ] Remove TODO comment
- [ ] Add actual development setup instructions

**Content to add** (around line 13):

```markdown
## Development Environment Setup

This repository contains templates, workflows, and configurations. No traditional "installation" is needed, but here's how to work with it:

### Prerequisites

- **Git**: [Latest version](https://git-scm.com/)
- **GitHub CLI** (optional): For testing workflows and labels
- **VS Code** (optional): For markdown editing and YAML validation
- **yamllint** (optional): For validating YAML files

### Setup

1. **Clone the repository**

   ```bash
   git clone git@github.com:benhigham/.github.git
   cd .github
   ```

2. **Validate YAML files** (optional)

   ```bash
   # Install yamllint
   brew install yamllint  # macOS
   # or
   pip install yamllint   # Python

   # Validate all YAML files
   yamllint .github/
   ```

3. **Test label configuration** (optional)

   ```bash
   # Using github-label-sync (requires Node.js)
   npx github-label-sync --dry-run --labels .github/labels.yml benhigham/.github
   ```

### Making Changes

- Edit workflow files in `.github/workflows/`
- Edit label configuration in `.github/labels.yml`
- Edit documentation in markdown files
- Test workflows in a separate repository before merging

### Validating Changes

Before submitting a PR:

1. **Validate YAML syntax** - Use your IDE or yamllint
2. **Check markdown formatting** - Use a markdown linter
3. **Test workflows** - Create a test repository and call the workflows
4. **Review documentation** - Ensure all examples are accurate

### Testing Workflows

To test a workflow:

1. Create a test repository
2. Create a workflow that calls the reusable workflow
3. Push and verify it runs correctly
4. Check logs for errors

Example:

```yaml
# .github/workflows/test-ci.yml in your test repo
name: Test CI
on: [push]

jobs:
  test:
    uses: benhigham/.github/.github/workflows/ci.yml@main
    with:
      run-lint: true
      run-test: true
```

```

**Impact**: 
- Clear guidance for contributors
- Professional documentation

**Estimated time**: 20 minutes  
**Priority**: 🟡 Medium  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

### Task 2.3: Add Concurrency Groups to Workflows 🔄

**Problem**: 5 workflows lack concurrency groups, which can lead to overlapping runs.

**Files to modify**:
- `.github/workflows/auto-merge-dependabot.yml`
- `.github/workflows/stale.yml`
- `.github/workflows/labeler.yml`
- `.github/workflows/sync-labels.yml`
- `.github/workflows/first-time-contributor.yml`

**Changes needed**: Add concurrency configuration after `permissions:` block in each workflow.

**For auto-merge-dependabot.yml** (after line 34):
```yaml
concurrency:
  group: auto-merge-${{ github.workflow }}-${{ github.event.pull_request.number }}
  cancel-in-progress: false
```

**For stale.yml** (after line 67):

```yaml
concurrency:
  group: stale-${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```

**For labeler.yml** (after line 20):

```yaml
concurrency:
  group: labeler-${{ github.workflow }}-${{ github.event.pull_request.number }}
  cancel-in-progress: true
```

**For sync-labels.yml** (after line 13):

```yaml
concurrency:
  group: sync-labels-${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```

**For first-time-contributor.yml** (after line 12):

```yaml
concurrency:
  group: greeting-${{ github.workflow }}-${{ github.event.number }}
  cancel-in-progress: false
```

**Impact**:

- Prevents multiple concurrent runs
- Saves CI time and resources
- Prevents race conditions

**Estimated time**: 15 minutes  
**Priority**: 🟡 Medium  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

### Task 2.4: Update Documentation for New Patterns 📚

**Problem**: Documentation should reflect the use of custom action.

**Files to modify**:

- `QUICK_REFERENCE.md`
- `README.md`
- `AGENTS.md`

**Changes needed**:

**QUICK_REFERENCE.md**:

- [ ] Update CI workflow example to show custom action is used internally
- [ ] Add note about the custom action being used automatically

**README.md**:

- [ ] Update "Using Shared Actions" section with current best practices
- [ ] Update label count from 37 to 42

**AGENTS.md**:

- [ ] Update workflow patterns section to emphasize action usage
- [ ] Update label count from 37 to 42

**Estimated time**: 15 minutes  
**Priority**: 🟡 Medium  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

## 🟢 Phase 3: Future Enhancements (Next Month - 2-4 hours)

### Task 3.1: Add Dependency Review Workflow 🔍

**Problem**: No automated dependency security review in PRs.

**Files to create**: `.github/workflows/dependency-review.yml`

**Implementation**:

```yaml
name: Dependency Review

on:
  pull_request:

permissions:
  contents: read
  pull-requests: write

jobs:
  dependency-review:
    name: Review Dependencies
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Dependency Review
        uses: actions/dependency-review-action@v4
        with:
          fail-on-severity: moderate
          comment-summary-in-pr: always
```

**Additional tasks**:

- [ ] Create workflow file
- [ ] Test in a PR
- [ ] Document in README.md
- [ ] Document in QUICK_REFERENCE.md
- [ ] Add to CHANGELOG.md

**Impact**:

- Automatic security review of dependencies
- Catches vulnerabilities before merge

**Estimated time**: 30 minutes  
**Priority**: 🟢 Low  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

### Task 3.2: Add PR Description Generator Workflow 📝

**Problem**: PR descriptions could be auto-generated from conventional commits.

**Files to create**: `.github/workflows/pr-description.yml`

**Implementation**: Use a tool like `release-drafter` or custom action to generate PR descriptions.

**Additional tasks**:

- [ ] Research best tool for this
- [ ] Create workflow file
- [ ] Create configuration file
- [ ] Test in a PR
- [ ] Document in README.md

**Impact**:

- Consistent PR descriptions
- Less manual work for contributors

**Estimated time**: 1 hour  
**Priority**: 🟢 Low  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

### Task 3.3: Add Branch Protection Checker Workflow 🛡️

**Problem**: No validation that branch protection rules are correctly configured.

**Files to create**: `.github/workflows/branch-protection-check.yml`

**Implementation**: Create a workflow that validates branch protection settings via GitHub API.

**Additional tasks**:

- [ ] Research GitHub API for branch protection
- [ ] Create workflow file
- [ ] Create validation script
- [ ] Test workflow
- [ ] Document in README.md

**Impact**:

- Ensures consistent branch protection
- Catches configuration drift

**Estimated time**: 1 hour  
**Priority**: 🟢 Low  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

### Task 3.4: Add Parallel Execution to CI Workflow ⚡

**Problem**: CI jobs run sequentially by default, could run in parallel for faster feedback.

**Files to modify**: `.github/workflows/ci.yml`

**Changes needed**:

- [ ] Research if jobs are already running in parallel (they should be by default)
- [ ] Add matrix strategy for multiple Node versions if desired
- [ ] Test performance improvements

**Note**: GitHub Actions jobs run in parallel by default unless `needs:` is specified. Verify current behavior first.

**Impact**:

- Faster CI feedback
- Better test coverage with multiple versions

**Estimated time**: 30 minutes  
**Priority**: 🟢 Low  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

### Task 3.5: Add Node Version Matrix Testing 🧪

**Problem**: Only testing with a single Node version.

**Files to modify**: `.github/workflows/ci.yml`

**Implementation**: Add matrix strategy to test multiple Node versions.

**Changes needed**:

- [ ] Add strategy.matrix to jobs
- [ ] Test with Node 18, 20, 22 (LTS versions)
- [ ] Document in README.md

**Example**:

```yaml
jobs:
  test:
    name: Test (Node ${{ matrix.node-version }})
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [18, 20, 22]
    steps:
      - uses: benhigham/.github/.github/actions/setup-node-pnpm@main
        with:
          node-version: ${{ matrix.node-version }}
      - run: pnpm test
```

**Impact**:

- Better compatibility testing
- Catches version-specific issues

**Estimated time**: 30 minutes  
**Priority**: 🟢 Low  
**Assigned to**: -  
**Status**: ⬜ Not Started  

---

## 📊 Progress Tracking

### Overall Status

- **Phase 1 (Critical)**: 0/7 tasks complete (0%)
- **Phase 2 (Medium)**: 0/4 tasks complete (0%)
- **Phase 3 (Future)**: 0/5 tasks complete (0%)
- **Total**: 0/16 tasks complete (0%)

### Time Estimates

- **Phase 1**: ~45 minutes (HIGH ROI)
- **Phase 2**: ~60 minutes (MEDIUM ROI)
- **Phase 3**: ~3-4 hours (LOW ROI)
- **Total**: ~5-6 hours

### Priority Order

1. ✅ Task 1.1 - Use custom action in CI workflow (15 min)
2. ✅ Task 1.2 - Use custom action in release workflow (5 min)
3. ✅ Task 1.3 - Add missing dependency labels (10 min)
4. ✅ Task 1.4 - Update LABELS.md (5 min)
5. ✅ Task 1.5 - Add timeout to sync-labels (2 min)
6. ✅ Task 1.6 - Add timeout to first-time-contributor (2 min)
7. ✅ Task 1.7 - Update CHANGELOG (3 min)
8. ⚠️ Task 2.1 - Standardize action versions (5-30 min)
9. ⚠️ Task 2.2 - Complete CONTRIBUTING.md (20 min)
10. ⚠️ Task 2.3 - Add concurrency groups (15 min)
11. ⚠️ Task 2.4 - Update documentation (15 min)
12. 🔵 Task 3.1-3.5 - Future enhancements (3-4 hours)

---

## 🎯 Quick Start Guide

**To complete Phase 1 today (45 minutes):**

```bash
# 1. Create a branch
git checkout -b refactor/eliminate-duplication

# 2. Complete tasks 1.1 through 1.7 (refer to details above)

# 3. Test changes (if possible)

# 4. Commit with conventional commits
git add .
git commit -m "refactor: eliminate code duplication and improve consistency

- Use custom setup-node-pnpm action in all workflows
- Add missing dependency labels for 5 ecosystems
- Add timeouts to sync-labels and first-time-contributor workflows
- Update CHANGELOG.md and LABELS.md"

# 5. Push and create PR
git push origin refactor/eliminate-duplication
```

**To complete Phase 2 this week (1 hour):**

Follow the same pattern for tasks 2.1 through 2.4.

---

## 📝 Notes

- All tasks are based on the comprehensive analysis in ANALYSIS.md
- Tasks are ordered by priority and dependencies
- Each task includes specific file locations and code examples
- Time estimates are conservative
- Phase 1 provides the highest ROI and should be completed first
- Phase 2 improves consistency and documentation
- Phase 3 adds nice-to-have features for the future

---

**Last Updated**: 2025-10-01  
**Next Review**: After Phase 1 completion
