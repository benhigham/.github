#!/bin/bash

# Wiki Migration Helper Script
# This script helps copy wiki-ready files to the GitHub wiki repository

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  GitHub Wiki Migration Helper${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Configuration
WIKI_REPO="https://github.com/benhigham/.github.wiki.git"
WIKI_DIR="$HOME/Projects/.github.wiki"
CONTENT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo -e "${YELLOW}Configuration:${NC}"
echo "  Wiki Repository: $WIKI_REPO"
echo "  Wiki Directory: $WIKI_DIR"
echo "  Content Directory: $CONTENT_DIR"
echo ""

# Check if wiki content is ready
echo -e "${BLUE}Checking wiki content...${NC}"
REQUIRED_FILES=("_Sidebar.md" "_Footer.md" "Home.md" "Getting-Started.md")
MISSING_FILES=()

for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$CONTENT_DIR/$file" ]; then
        MISSING_FILES+=("$file")
    fi
done

if [ ${#MISSING_FILES[@]} -gt 0 ]; then
    echo -e "${RED}❌ Missing required files:${NC}"
    for file in "${MISSING_FILES[@]}"; do
        echo "   - $file"
    done
    echo ""
    echo -e "${YELLOW}Please generate all wiki content first.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ All required files found${NC}"
echo ""

# Check if wiki repository exists
if [ ! -d "$WIKI_DIR" ]; then
    echo -e "${YELLOW}Wiki repository not found locally.${NC}"
    echo -e "${BLUE}Cloning wiki repository...${NC}"

    git clone "$WIKI_REPO" "$WIKI_DIR"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Wiki repository cloned successfully${NC}"
    else
        echo -e "${RED}❌ Failed to clone wiki repository${NC}"
        echo -e "${YELLOW}Make sure the wiki is enabled in repository settings:${NC}"
        echo "   https://github.com/benhigham/.github/settings"
        exit 1
    fi
else
    echo -e "${GREEN}✅ Wiki repository found${NC}"

    # Pull latest changes
    echo -e "${BLUE}Pulling latest wiki changes...${NC}"
    cd "$WIKI_DIR"
    git pull origin master
fi

echo ""

# Copy files
echo -e "${BLUE}Copying wiki files...${NC}"
cd "$WIKI_DIR"

COPIED_FILES=0
for file in "$CONTENT_DIR"/*.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")

        # Skip README.md (it's for the content directory)
        if [ "$filename" = "README.md" ]; then
            continue
        fi

        cp "$file" "$WIKI_DIR/$filename"
        echo -e "  ${GREEN}✓${NC} Copied $filename"
        COPIED_FILES=$((COPIED_FILES + 1))
    fi
done

echo -e "${GREEN}✅ Copied $COPIED_FILES files${NC}"
echo ""

# Show git status
echo -e "${BLUE}Git status:${NC}"
git status --short

echo ""

# Ask for confirmation
echo -e "${YELLOW}Ready to commit and push changes?${NC}"
echo -e "This will:"
echo "  1. Stage all new/modified files"
echo "  2. Commit with message: 'docs: migrate documentation to wiki'"
echo "  3. Push to wiki repository"
echo ""
read -p "Continue? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Aborted. Files are copied but not committed.${NC}"
    echo -e "To commit manually:"
    echo "  cd $WIKI_DIR"
    echo "  git add ."
    echo "  git commit -m 'docs: migrate documentation to wiki'"
    echo "  git push origin master"
    exit 0
fi

# Commit and push
echo -e "${BLUE}Committing changes...${NC}"
git add .
git commit -m "docs: migrate documentation to wiki"

echo -e "${BLUE}Pushing to wiki repository...${NC}"
git push origin master

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  ✅ Wiki Migration Complete!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "Visit your wiki: ${BLUE}https://github.com/benhigham/.github/wiki${NC}"
    echo ""
else
    echo -e "${RED}❌ Failed to push to wiki repository${NC}"
    echo -e "${YELLOW}You may need to push manually:${NC}"
    echo "  cd $WIKI_DIR"
    echo "  git push origin master"
    exit 1
fi
