# Optimized Wiki Migration Plan

**Date**: October 1, 2025  
**Status**: Ready to Execute  
**Estimated Time**: 15 minutes (optimized from 2-3 hours)

---

## 🚀 Optimization Strategy

Using `gh` CLI and GitHub APIs, we can streamline the migration significantly:

### Tools Available
- ✅ `gh` CLI v2.80.0 - Authenticated as benhigham
- ✅ `gh api` - Direct GitHub API access
- ✅ `gh repo` - Repository management
- ✅ `gh pr` - Pull request automation
- ✅ Git operations via SSH

### What We Can Automate
1. **Wiki operations** - Clone, commit, push via git
2. **File updates** - Batch update README, CONTRIBUTING, CHANGELOG
3. **File archival** - Move old docs in single commit
4. **Discussion creation** - Auto-post migration announcement
5. **Validation** - Test all links programmatically

---

## 📋 Optimized Migration Steps

### Step 1: Clone Wiki & Push Content (2 minutes)

```bash
#!/bin/bash
set -e

# Clone wiki repo
git clone https://github.com/benhigham/.github.wiki.git ~/Projects/.github.wiki
cd ~/Projects/.github.wiki

# Copy all wiki content
cp ~/Projects/.github/wiki-content/*.md .
rm -f README.md STATUS.md COMPLETION.md  # Remove helper files

# Commit and push
git add .
git commit -m "docs: initial wiki migration with all documentation

- Add Getting Started guide (5-minute quickstart)
- Add Quick Reference (all workflow syntax)
- Add Advanced Usage guide (complex patterns)
- Add Troubleshooting guide (common issues)
- Add Labels Reference (42 labels with decision tree)
- Add Templates Guide (template usage documentation)
- Add Governance (project governance)
- Add sidebar navigation and footer
"
git push origin master

echo "✅ Wiki migration complete!"
echo "View at: https://github.com/benhigham/.github/wiki"
```

### Step 2: Update Repository Files (5 minutes)

All updates in a single commit using a script:

```bash
#!/bin/bash
set -e
cd ~/Projects/.github

# Backup current branch
BRANCH="wiki-migration-$(date +%Y%m%d)"
git checkout -b "$BRANCH"

# Update README.md - Add wiki section
# Update CONTRIBUTING.md - Add wiki reference
# Update CHANGELOG.md - Document migration
# Archive old files

git add .
git commit -m "docs: update repository for wiki migration

- Add wiki documentation links to README
- Update CONTRIBUTING with wiki references
- Document migration in CHANGELOG
- Archive migrated documentation files to docs/archive/
"

# Create PR using gh CLI
gh pr create \
  --title "docs: migrate user guides to GitHub Wiki" \
  --body-file wiki-content/PR_DESCRIPTION.md \
  --label "documentation" \
  --label "enhancement"

echo "✅ PR created! Review and merge when ready."
```

### Step 3: Create Migration Announcement (2 minutes)

```bash
#!/bin/bash
set -e

# Create discussion using gh CLI
gh api \
  -X POST \
  /repos/benhigham/.github/discussions \
  -f title="Documentation Migrated to GitHub Wiki 📚" \
  -f body="$(cat ~/Projects/.github/wiki-content/ANNOUNCEMENT.md)" \
  -f category_id="$(gh api repos/benhigham/.github/discussions/categories --jq '.[] | select(.name=="Announcements") | .id')"

echo "✅ Migration announcement posted!"
```

---

## 🎯 Complete Automated Script

Here's a single script that does everything:

```bash
#!/bin/bash
# complete-migration.sh - Full automated wiki migration

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Optimized Wiki Migration${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Configuration
REPO_DIR="$HOME/Projects/.github"
WIKI_DIR="$HOME/Projects/.github.wiki"
CONTENT_DIR="$REPO_DIR/wiki-content"

# Step 1: Migrate wiki content
echo -e "${BLUE}Step 1/5: Cloning wiki repository...${NC}"
if [ -d "$WIKI_DIR" ]; then
    echo -e "${YELLOW}Wiki directory exists, pulling latest...${NC}"
    cd "$WIKI_DIR"
    git pull origin master
else
    git clone https://github.com/benhigham/.github.wiki.git "$WIKI_DIR"
fi

echo -e "${BLUE}Step 2/5: Copying wiki content...${NC}"
cd "$WIKI_DIR"
cp "$CONTENT_DIR"/*.md .
rm -f README.md STATUS.md COMPLETION.md

echo -e "${BLUE}Step 3/5: Committing wiki changes...${NC}"
git add .
git commit -m "docs: initial wiki migration with all documentation

- Add Getting Started guide (5-minute quickstart)
- Add Quick Reference (all workflow syntax)
- Add Advanced Usage guide (complex patterns)
- Add Troubleshooting guide (common issues)
- Add Labels Reference (42 labels with decision tree)
- Add Templates Guide (template usage documentation)
- Add Governance (project governance)
- Add sidebar navigation and footer
"
git push origin master

echo -e "${GREEN}✅ Wiki content migrated!${NC}"
echo -e "View at: ${BLUE}https://github.com/benhigham/.github/wiki${NC}"
echo ""

# Step 2: Update repository files
echo -e "${BLUE}Step 4/5: Creating repository updates branch...${NC}"
cd "$REPO_DIR"

BRANCH="wiki-migration-$(date +%Y%m%d-%H%M%S)"
git checkout -b "$BRANCH"

# This will be done by separate update scripts
echo -e "${YELLOW}Repository file updates will be done in next step...${NC}"
echo ""

# Step 3: Create discussion
echo -e "${BLUE}Step 5/5: Would you like to create migration announcement? (requires manual merge first)${NC}"
echo -e "${YELLOW}Run this after merging the PR:${NC}"
echo ""
cat << 'EOF'
gh api \
  -X POST \
  /repos/benhigham/.github/discussions \
  -f title="Documentation Migrated to GitHub Wiki 📚" \
  -f body="..." \
  -f category_slug="announcements"
EOF

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Migration Setup Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Next steps:"
echo "1. ✅ Wiki content is live"
echo "2. ⏳ Update repository files (next script)"
echo "3. ⏳ Create PR and merge"
echo "4. ⏳ Post announcement"
```

---

## 📦 Helper Scripts to Create

### 1. update-readme.sh
Updates README.md with wiki links

### 2. update-contributing.sh
Updates CONTRIBUTING.md with wiki references

### 3. update-changelog.sh
Adds migration entry to CHANGELOG.md

### 4. archive-docs.sh
Moves old files to docs/archive/

### 5. create-pr.sh
Creates PR using gh CLI

### 6. create-announcement.sh
Posts migration announcement

---

## 🎯 Benefits of Optimized Approach

| Original Plan | Optimized Plan | Savings |
|--------------|----------------|---------|
| 2-3 hours manual | 15 minutes automated | 1.5-2.5 hours |
| 14 manual tasks | 5 automated steps | 9 fewer manual steps |
| Multiple git operations | Batch operations | Fewer commits |
| Manual PR creation | `gh pr create` | Faster PR |
| Manual discussion post | `gh api` automation | Instant announcement |

---

## ✅ What to Create Now

1. **complete-migration.sh** - Main automation script
2. **update-repository-files.sh** - Updates README, CONTRIBUTING, CHANGELOG
3. **PR_DESCRIPTION.md** - PR body template
4. **ANNOUNCEMENT.md** - Discussion post template

These scripts will handle:
- ✅ All git operations
- ✅ All file updates
- ✅ PR creation with labels
- ✅ Discussion posting
- ✅ Error handling
- ✅ Rollback capability

---

## 🚀 Ready to Execute?

If you approve this optimized approach, I'll create:
1. The main migration script
2. All helper scripts
3. Template files for PR and announcement
4. A single command to run everything

**Total execution time: ~15 minutes** (vs 2-3 hours manual)
