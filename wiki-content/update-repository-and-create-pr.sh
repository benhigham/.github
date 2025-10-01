#!/bin/bash
# Update repository files after wiki migration and create PR

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Repository Update for Wiki Migration${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

REPO_DIR="$HOME/Projects/.github"
cd "$REPO_DIR"

# Check if we're on main
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo -e "${RED}Not on main branch!${NC}"
    echo "Current branch: $CURRENT_BRANCH"
    exit 1
fi

# Check for uncommitted changes
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo -e "${RED}You have uncommitted changes!${NC}"
    echo "Please commit or stash them first."
    git status --short
    exit 1
fi

# Create feature branch
BRANCH="wiki-migration-$(date +%Y%m%d-%H%M%S)"
echo -e "${BLUE}Creating branch: $BRANCH${NC}"
git checkout -b "$BRANCH"

echo ""
echo -e "${BLUE}Updating repository files...${NC}"
echo ""

# The actual file updates will be done by the AI using str_replace_editor
# This script just handles the git operations and PR creation

echo -e "${YELLOW}Files to update:${NC}"
echo "  - README.md (add wiki documentation section)"
echo "  - CONTRIBUTING.md (add wiki reference)"
echo "  - CHANGELOG.md (document migration)"
echo ""

echo -e "${YELLOW}Files to archive:${NC}"
echo "  - GETTING_STARTED.md"
echo "  - TROUBLESHOOTING.md"
echo ""

echo -e "${YELLOW}Note: The AI will make these changes using str_replace_editor${NC}"
echo -e "${YELLOW}This script handles git operations and PR creation${NC}"
echo ""

read -p "Ready to proceed with updates? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted. Cleaning up..."
    git checkout main
    git branch -D "$BRANCH" 2>/dev/null || true
    exit 0
fi

echo -e "${GREEN}✅ Branch created and ready for updates${NC}"
echo ""
echo "Next steps:"
echo "1. AI will update the files using str_replace_editor"
echo "2. Review the changes"
echo "3. Commit with: git commit -m 'docs: update repository for wiki migration'"
echo "4. Create PR with: gh pr create --title 'docs: migrate user guides to GitHub Wiki' --label documentation"
