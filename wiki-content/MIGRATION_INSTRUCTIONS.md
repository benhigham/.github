# Wiki Migration - Final Steps

The wiki content is ready! Since GitHub's API doesn't support wiki creation, you need to initialize the wiki manually first.

## 🚀 Quick Migration (5 minutes)

### Step 1: Initialize Wiki (1 minute)

1. Visit: https://github.com/benhigham/.github/wiki
2. Click "Create the first page"
3. Title: `Home`
4. Paste content from: `~/Projects/.github/wiki-content/Home.md`
5. Click "Save Page"

### Step 2: Upload All Wiki Pages (2 minutes)

Once the wiki is initialized, clone and upload all pages:

```bash
cd ~/Projects
git clone git@github.com:benhigham/.github.wiki.git .github.wiki
cd .github.wiki

# Copy all wiki pages
cp ~/Projects/.github/wiki-content/*.md .

# Remove helper files
rm -f README.md STATUS.md COMPLETION.md OPTIMIZED_MIGRATION.md MIGRATION_INSTRUCTIONS.md

# Commit and push
git add .
git commit -m "docs: migrate all documentation to wiki"
git push origin master
```

### Step 3: Update Repository (2 minutes)

Run the automated update script:

```bash
cd ~/Projects/.github
./wiki-content/update-repository-and-create-pr.sh
```

This will:
- ✅ Create a new branch
- ✅ Update README with wiki links
- ✅ Update CONTRIBUTING with wiki references
- ✅ Update CHANGELOG
- ✅ Archive old documentation files
- ✅ Create a PR with all changes

## 📋 Manual Alternative

If you prefer to do it manually:

1. **Initialize wiki** (as above)
2. **Upload pages one by one** through the web UI:
   - Go to https://github.com/benhigham/.github/wiki
   - Click "New Page"
   - Copy content from each file in `wiki-content/`
   - Save each page

3. **Update repository files** (see the script for what to change)

## ✅ Verification

After migration, verify:

- [ ] All wiki pages are accessible
- [ ] Sidebar navigation works
- [ ] All internal links work
- [ ] Mermaid diagrams render
- [ ] README has wiki links
- [ ] Old files are archived

## 🎉 Done!

Once complete, your documentation will be:
- ✅ In the wiki with better navigation
- ✅ Repository focused on templates and code
- ✅ Easier to browse and discover
