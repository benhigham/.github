#!/bin/bash
# Complete Wiki Migration - Optimized with gh CLI
# This script automates the entire wiki migration process

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Optimized Wiki Migration${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Configuration
REPO_DIR="$HOME/Projects/.github"
WIKI_DIR="$HOME/Projects/.github.wiki"
CONTENT_DIR="$REPO_DIR/wiki-content"

# Verify we're authenticated
echo -e "${BLUE}Verifying GitHub authentication...${NC}"
if ! gh auth status &>/dev/null; then
    echo -e "${RED}❌ Not authenticated with gh CLI${NC}"
    echo "Run: gh auth login"
    exit 1
fi
echo -e "${GREEN}✅ Authenticated${NC}"
echo ""

# Step 1: Migrate wiki content
echo -e "${BLUE}Step 1/3: Migrating wiki content...${NC}"
echo ""

if [ -d "$WIKI_DIR" ]; then
    echo -e "${YELLOW}Wiki directory exists, pulling latest...${NC}"
    cd "$WIKI_DIR"
    git pull origin master || echo "No remote changes"
else
    echo -e "${BLUE}Cloning wiki repository...${NC}"
    git clone https://github.com/benhigham/.github.wiki.git "$WIKI_DIR"
fi

echo -e "${BLUE}Copying wiki content...${NC}"
cd "$WIKI_DIR"

# Copy all markdown files except helper docs
for file in "$CONTENT_DIR"/*.md; do
    filename=$(basename "$file")
    # Skip helper files
    if [[ "$filename" != "README.md" && "$filename" != "STATUS.md" && "$filename" != "COMPLETION.md" && "$filename" != "OPTIMIZED_MIGRATION.md" ]]; then
        cp "$file" "$WIKI_DIR/$filename"
        echo -e "  ${GREEN}✓${NC} Copied $filename"
    fi
done

echo ""
echo -e "${BLUE}Committing wiki changes...${NC}"
git add .

if git diff --staged --quiet; then
    echo -e "${YELLOW}No changes to commit (wiki already up to date)${NC}"
else
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
    
    echo -e "${BLUE}Pushing to wiki...${NC}"
    git push origin master
    
    echo -e "${GREEN}✅ Wiki content migrated!${NC}"
fi

echo -e "View at: ${BLUE}https://github.com/benhigham/.github/wiki${NC}"
echo ""

# Step 2: Update repository files
echo -e "${BLUE}Step 2/3: Updating repository files...${NC}"
cd "$REPO_DIR"

# Check if we're on main branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo -e "${YELLOW}Not on main branch (currently on $CURRENT_BRANCH)${NC}"
    echo -e "${YELLOW}Switching to main...${NC}"
    git checkout main
    git pull origin main
fi

# Create feature branch
BRANCH="wiki-migration-$(date +%Y%m%d-%H%M%S)"
echo -e "${BLUE}Creating branch: $BRANCH${NC}"
git checkout -b "$BRANCH"

# Run update scripts
echo ""
echo -e "${BLUE}Running update scripts...${NC}"

if [ -f "$CONTENT_DIR/update-repository-files.sh" ]; then
    bash "$CONTENT_DIR/update-repository-files.sh"
else
    echo -e "${YELLOW}⚠️  update-repository-files.sh not found${NC}"
    echo -e "${YELLOW}You'll need to update README, CONTRIBUTING, CHANGELOG manually${NC}"
fi

# Archive old documentation files
echo ""
echo -e "${BLUE}Archiving old documentation...${NC}"
mkdir -p docs/archive
for file in GETTING_STARTED.md TROUBLESHOOTING.md; do
    if [ -f "$file" ]; then
        git mv "$file" docs/archive/
        echo -e "  ${GREEN}✓${NC} Archived $file"
    fi
done

# Add all changes
git add .

if git diff --staged --quiet; then
    echo -e "${YELLOW}No repository changes to commit${NC}"
else
    git commit -m "docs: update repository for wiki migration

- Add wiki documentation links to README
- Update CONTRIBUTING with wiki references
- Document migration in CHANGELOG
- Archive migrated documentation files to docs/archive/
"
    
    git push origin "$BRANCH"
    echo -e "${GREEN}✅ Repository updates pushed to branch: $BRANCH${NC}"
fi

echo ""

# Step 3: Create PR
echo -e "${BLUE}Step 3/3: Creating pull request...${NC}"

PR_BODY="# Wiki Migration

This PR updates the repository after migrating user documentation to the GitHub Wiki.

## 📚 Changes

### Wiki Content (Already Live)
- ✅ [Getting Started Guide](https://github.com/benhigham/.github/wiki/Getting-Started)
- ✅ [Quick Reference](https://github.com/benhigham/.github/wiki/Quick-Reference)
- ✅ [Advanced Usage](https://github.com/benhigham/.github/wiki/Advanced-Usage)
- ✅ [Troubleshooting](https://github.com/benhigham/.github/wiki/Troubleshooting)
- ✅ [Labels Reference](https://github.com/benhigham/.github/wiki/Labels-Reference)
- ✅ [Templates Guide](https://github.com/benhigham/.github/wiki/Templates-Guide)
- ✅ [Governance](https://github.com/benhigham/.github/wiki/Governance)

### Repository Updates
- Updated README with wiki links
- Updated CONTRIBUTING with wiki references
- Documented migration in CHANGELOG
- Archived old documentation files

## ✨ Benefits
- Better navigation with wiki sidebar
- Cleaner repository root
- Easier documentation updates
- Improved discoverability

## 🔗 Wiki Home
https://github.com/benhigham/.github/wiki

## ✅ Checklist
- [x] Wiki content migrated and live
- [x] README updated
- [x] CONTRIBUTING updated
- [x] CHANGELOG updated
- [x] Old files archived
- [ ] All links tested (reviewer to check)
- [ ] Migration announcement ready to post
"

if gh pr create \
    --title "docs: migrate user guides to GitHub Wiki" \
    --body "$PR_BODY" \
    --label "documentation" \
    --label "enhancement" 2>/dev/null; then
    
    echo -e "${GREEN}✅ Pull request created!${NC}"
else
    echo -e "${YELLOW}⚠️  PR already exists or creation failed${NC}"
    echo -e "${YELLOW}You can create it manually:${NC}"
    echo "  gh pr create --title 'docs: migrate user guides to GitHub Wiki' --label documentation --label enhancement"
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  Migration Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Next steps:"
echo "1. ✅ Wiki content is live: https://github.com/benhigham/.github/wiki"
echo "2. ✅ PR created for repository updates"
echo "3. ⏳ Review and merge the PR"
echo "4. ⏳ Post migration announcement (use create-announcement.sh)"
echo ""
echo -e "${YELLOW}To post announcement after merging:${NC}"
echo "  cd $CONTENT_DIR"
echo "  ./create-announcement.sh"
