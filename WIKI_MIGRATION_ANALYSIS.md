# Wiki Migration Analysis

**Date**: October 1, 2025  
**Context**: Evaluating whether to migrate documentation from repository root to GitHub Wiki

---

## 📊 Current State Assessment

### Documentation Overview

We now have **17 markdown files** (~5,000 lines) in the repository root:

| Category | Files | Total Lines | Purpose |
|----------|-------|-------------|---------|
| **User Guides** | 4 | 1,575 | GETTING_STARTED, QUICK_REFERENCE, TROUBLESHOOTING, ADVANCED_USAGE |
| **Reference** | 2 | 804 | README, LABELS |
| **Templates** | 3 | 1,097 | ARCHITECTURE, DEVELOPMENT, RELEASING |
| **Community** | 5 | 435 | CODE_OF_CONDUCT, CONTRIBUTING, SECURITY, SUPPORT, GOVERNANCE |
| **Meta** | 3 | 722 | AGENTS, CHANGELOG, LICENSE |

### ✅ Goals We Achieved

1. **Progressive Disclosure** ✅
   - Clear path: Getting Started → Quick Reference → Advanced → Troubleshooting
   - Each doc serves a specific audience/need

2. **Improved Navigation** ✅
   - Cross-references and footer links in all major docs
   - Mermaid decision trees for workflow selection
   - Table of contents in long documents

3. **Actionable Templates** ✅
   - TODO comments guide customization
   - "Choose one and delete others" instructions
   - Multiple examples for different scenarios

4. **Visual Aids** ✅
   - Workflow selection decision tree (README)
   - Release process timeline (RELEASING)
   - Label selection flow (LABELS)

5. **Reduced Verbosity** ✅ (partially)
   - Split 717-line QUICK_REFERENCE into 4 focused docs
   - But individual docs still substantial (581, 517, 248 lines)

### ⚠️ Remaining Challenges

1. **Root Directory Clutter**
   - 17 markdown files compete for attention
   - Mixed purposes (guides, templates, meta, community)
   - Harder to find what you need quickly

2. **Discoverability**
   - File-based navigation requires knowing filenames
   - No built-in search across documentation
   - Can't easily browse documentation hierarchy

3. **Maintenance**
   - Every doc edit requires PR + review
   - Higher friction for quick fixes/updates
   - Docs treated as code (good/bad tradeoff)

4. **Still Verbose**
   - QUICK_REFERENCE: 581 lines (still not "quick")
   - ADVANCED_USAGE: 517 lines (comprehensive but long)
   - Combined workflow guides: ~1,600 lines

---

## 🔍 GitHub Wiki Evaluation

### What is GitHub Wiki?

- Git-backed documentation system built into GitHub repositories
- Separate git repo (`.wiki` clone)
- Built-in sidebar navigation and search
- Web-based editing with preview
- Markdown support with GitHub-flavored extensions

### Advantages

| Benefit | Description | Impact |
|---------|-------------|--------|
| **Cleaner Repository** | Move user guides out of root | High - Reduces clutter |
| **Better Navigation** | Built-in sidebar + search | High - Easier discovery |
| **Easier Editing** | Edit in browser, no PR needed | Medium - Lower friction |
| **Proper Separation** | Code vs. documentation contexts | High - Semantic correctness |
| **History Tracking** | Git-based with visual diff | Medium - Track doc evolution |
| **Browse Experience** | Wiki UX optimized for reading | High - Better UX |

### Disadvantages

| Concern | Description | Severity | Mitigation |
|---------|-------------|----------|------------|
| **No PR Review** | Changes don't require approval | Medium | Keep critical docs in repo |
| **No CI Validation** | Can't lint/validate automatically | Low | Manual review process |
| **Link Breakage** | Existing .md links would break | High | Add redirects in README |
| **Separate Search** | Wiki search isolated from code | Low | Cross-link appropriately |
| **Offline Access** | Need separate wiki clone | Low | Document wiki clone process |
| **Community Expectations** | Some users expect docs in repo | Medium | Keep README comprehensive |

---

## 🎯 Recommended Approach: Hybrid Model

### Keep in Repository Root

**Community Health Files** (GitHub requires these locations):

- ✅ CODE_OF_CONDUCT.md
- ✅ CONTRIBUTING.md  
- ✅ SECURITY.md
- ✅ SUPPORT.md
- ✅ LICENSE.md
- ✅ CODEOWNERS

**Standard Repository Files**:

- ✅ README.md (overview + links to wiki)
- ✅ CHANGELOG.md (standard practice)

**Templates** (need to be copyable):

- ✅ ARCHITECTURE.md
- ✅ DEVELOPMENT.md
- ✅ RELEASING.md

**Configuration** (if added):

- ✅ AGENTS.md (AI agent instructions - optional)

### Migrate to Wiki

**User Documentation** (browsable guides):

- 📚 **Home** - Overview + quick navigation
- 📚 **Getting Started** - 5-minute setup guide
- 📚 **Workflows**
  - Quick Reference
  - Advanced Usage
  - Troubleshooting
- 📚 **Labels Reference** - Complete label guide
- 📚 **Templates Guide** - How to use template files
- 📚 **Governance** - Project governance (or keep in repo)

### Updated README Structure

```markdown
# benhigham/.github

Brief overview (3-4 sentences)

## 📚 Documentation

**Quick Start**: [Getting Started Guide](wiki/Getting-Started) (5 minutes)

**Workflows**: 
- [Quick Reference](wiki/Quick-Reference) - Copy-paste examples
- [Advanced Usage](wiki/Advanced-Usage) - Complex patterns
- [Troubleshooting](wiki/Troubleshooting) - Common issues

**Reference**:
- [Labels Guide](wiki/Labels-Reference) - All 42 labels explained
- [Templates Guide](wiki/Templates-Guide) - Using ARCHITECTURE.md, etc.

## 📋 What's Included

[Keep current "What's Included" section with checkboxes]

## 🤖 Using Reusable Workflows

[Keep decision tree mermaid diagram]
[Keep workflow badges section]
[Link to wiki for detailed docs]

...rest of README
```

---

## 📋 Migration Plan

### Phase 1: Prepare (30 minutes)

1. **Create wiki sidebar structure**

   ```markdown
   **Getting Started**
   - [Home](Home)
   - [Getting Started](Getting-Started)
   
   **Workflows**
   - [Quick Reference](Quick-Reference)
   - [Advanced Usage](Advanced-Usage)
   - [Troubleshooting](Troubleshooting)
   
   **Reference**
   - [Labels](Labels-Reference)
   - [Templates](Templates-Guide)
   - [Governance](Governance)
   ```

2. **Review and update cross-references**
   - Note all internal links in docs to be migrated
   - Prepare updated links for wiki paths

### Phase 2: Migrate Content (1 hour)

1. **Create wiki pages** (in order):
   - Home (overview + navigation)
   - Getting-Started (copy from GETTING_STARTED.md)
   - Quick-Reference (copy from QUICK_REFERENCE.md)
   - Advanced-Usage (copy from ADVANCED_USAGE.md)
   - Troubleshooting (copy from TROUBLESHOOTING.md)
   - Labels-Reference (copy from LABELS.md)
   - Templates-Guide (new page explaining template usage)
   - Governance (copy from GOVERNANCE.md - optional)

2. **Update internal links**
   - Change `.md` links to wiki links
   - Update navigation footers
   - Fix any broken references

3. **Test all mermaid diagrams**
   - Verify they render correctly in wiki
   - Adjust syntax if needed

### Phase 3: Update Repository (30 minutes)

1. **Update README.md**
   - Add prominent wiki links at top
   - Simplify overview
   - Add "Documentation moved to wiki" notice
   - Keep decision tree and essential info

2. **Update CONTRIBUTING.md**
   - Add link to wiki
   - Keep contribution guidelines in repo

3. **Create _Sidebar.md in wiki**
   - Define wiki navigation structure

### Phase 4: Clean Up (15 minutes)

1. **Archive or remove migrated files**
   - Option A: Delete GETTING_STARTED.md, QUICK_REFERENCE.md, etc.
   - Option B: Move to `docs/archive/` folder with deprecation notice
   - Option C: Replace content with redirect notice

2. **Update CHANGELOG.md**

   ```markdown
   ## [Unreleased]
   
   ### Changed
   - Migrated user documentation to GitHub Wiki for better discoverability
   - Moved GETTING_STARTED, QUICK_REFERENCE, TROUBLESHOOTING, ADVANCED_USAGE, LABELS to wiki
   - Simplified README.md with links to wiki documentation
   ```

3. **Test all links**
   - Verify wiki pages load
   - Check README links work
   - Ensure templates still accessible

### Phase 5: Announce (5 minutes)

1. **Create discussion post**
   - Announce wiki migration
   - Explain benefits
   - Provide wiki links

2. **Update any external references**
   - Blog posts, tweets, etc.

---

## 🤔 Decision Criteria

### Migrate to Wiki If

- ✅ You want cleaner repository root
- ✅ Users need better browsing/search experience  
- ✅ Documentation changes frequently (wiki easier to edit)
- ✅ You have 5+ documentation files
- ✅ You want to separate user docs from code

### Keep in Repository If

- ✅ Documentation rarely changes (prefer PR review)
- ✅ You want docs in code search results
- ✅ Contributors need docs offline in repo clone
- ✅ You have strong CI/CD for doc validation
- ✅ Community expects docs in repository

---

## 💡 Recommendation

**I recommend the hybrid approach** for your `.github` repository:

### Rationale

1. **Special Repository Purpose**
   - This is a meta-repository (community health files + workflows)
   - Users come here to copy files and understand workflows
   - Different use case than typical project documentation

2. **Current State Analysis**
   - We successfully achieved progressive disclosure
   - Navigation is good with footer links
   - Main issue is clutter (17 files) and discoverability

3. **User Benefit**
   - Wiki provides better browsing for workflow guides
   - Repository keeps copyable templates accessible
   - README becomes cleaner entry point

4. **Low Risk**
   - Can migrate iteratively (start with getting started guide)
   - Easy to revert if it doesn't work
   - Keep critical docs in repo (CONTRIBUTING, templates)

### Next Steps

1. **Quick Win**: Create wiki with just "Getting Started" page
2. **Evaluate**: See if users find it helpful (track wiki views)
3. **Iterate**: Migrate more docs if successful
4. **Keep Templates**: Always keep ARCHITECTURE, DEVELOPMENT, RELEASING in repo

---

## 📊 Success Metrics

After migration, track:

- Wiki page views (GitHub provides analytics)
- Issues/discussions about "can't find documentation"
- Contribution activity (PRs for doc updates vs. wiki edits)
- User feedback in discussions

**Target**: 80% reduction in "where is X documented?" questions

---

## ❓ FAQs

**Q: Will this break existing links to documentation?**  
A: Yes, but we can add redirect notices in README and keep file stubs with links to wiki.

**Q: Can I still edit wiki docs with PRs?**  
A: Yes! Clone the wiki repo (`git clone https://github.com/benhigham/.github.wiki.git`) and submit PRs.

**Q: What about search engines indexing docs?**  
A: GitHub wiki pages are indexed by search engines. May actually improve SEO.

**Q: Should AGENTS.md go to wiki?**  
A: Probably keep in repo since it's for AI tools that read repository files.

**Q: Can I migrate incrementally?**  
A: Absolutely! Start with Getting Started, evaluate, then migrate others.

---

## 📝 Draft Wiki Home Page

```markdown
# benhigham/.github Wiki

Welcome! This wiki contains comprehensive documentation for using the reusable workflows, templates, and configurations from the [benhigham/.github](https://github.com/benhigham/.github) repository.

## 🚀 Quick Start

**New here?** Start with the [Getting Started Guide](Getting-Started) (5 minutes).

## 📚 Documentation Sections

### Workflows
- **[Quick Reference](Quick-Reference)** - Copy-paste examples for all 11 workflows
- **[Advanced Usage](Advanced-Usage)** - Matrix testing, complex patterns, custom combinations
- **[Troubleshooting](Troubleshooting)** - Common issues and solutions

### Reference Guides
- **[Labels](Labels-Reference)** - All 42 standard labels with usage guidelines
- **[Templates](Templates-Guide)** - How to use ARCHITECTURE.md, DEVELOPMENT.md, RELEASING.md

### Project Information
- **[Governance](Governance)** - Project structure and decision-making process

## 🔗 Repository Files

Some files remain in the repository root for easy access:

- [README.md](https://github.com/benhigham/.github#readme) - Repository overview
- [CONTRIBUTING.md](https://github.com/benhigham/.github/blob/main/CONTRIBUTING.md) - How to contribute
- [CHANGELOG.md](https://github.com/benhigham/.github/blob/main/CHANGELOG.md) - Version history
- Template files: [ARCHITECTURE.md](https://github.com/benhigham/.github/blob/main/ARCHITECTURE.md), [DEVELOPMENT.md](https://github.com/benhigham/.github/blob/main/DEVELOPMENT.md), [RELEASING.md](https://github.com/benhigham/.github/blob/main/RELEASING.md)

## 💬 Get Help

- **Questions?** [Start a discussion](https://github.com/benhigham/.github/discussions)
- **Found a bug?** [Open an issue](https://github.com/benhigham/.github/issues)
- **Want to contribute?** See [CONTRIBUTING.md](https://github.com/benhigham/.github/blob/main/CONTRIBUTING.md)
```

---

## ✅ Final Recommendation

**Start with a pilot migration:**

1. Create wiki with "Getting Started" page only
2. Add prominent link in README
3. Track usage for 2 weeks
4. If successful, migrate remaining docs
5. If not, keep current structure (it's already quite good!)

The current documentation structure is **functional and well-organized**. Wiki migration is an **optimization**, not a necessity. The hybrid approach gives you the best of both worlds.
