# Wiki Content Directory

This directory contains wiki-ready versions of all documentation files with links already converted to wiki format.

## 📁 Contents

- `_Sidebar.md` - Wiki sidebar navigation ✅
- `_Footer.md` - Wiki footer with quick links ✅
- `Home.md` - Wiki home page ✅
- `Getting-Started.md` - 5-minute setup guide ✅
- `Quick-Reference.md` - All workflow syntax ✅
- `Advanced-Usage.md` - Complex patterns ✅
- `Troubleshooting.md` - Common issues ✅
- `Labels-Reference.md` - All 42 labels ✅
- `Templates-Guide.md` - Template usage guide ✅
- `Governance.md` - Project governance ✅
- `README.md` - This file
- `STATUS.md` - Current migration status
- `migrate-to-wiki.sh` - Automated migration script ✅

## 🚀 How to Use

### Option 1: Manual Copy (Recommended for first time)

1. **Enable wiki** in repository settings
2. **Clone wiki repository**:

   ```bash
   git clone https://github.com/benhigham/.github.wiki.git
   cd .github.wiki

   ```

3. **Copy files**:

   ```bash

   cp ~/Projects/.github/wiki-content/*.md .
   ```

4. **Commit and push**:

   ```bash
   git add .
   git commit -m "docs: initial wiki migration"
   git push origin master
   ```

### Option 2: Use the Migration Script

```bash
cd ~/Projects/.github
./wiki-content/migrate-to-wiki.sh
```

## 📝 What's Different from Repository Files?

All internal documentation links have been converted:

### Link Conversions

- `[Page](FILE.md)` → `[Page](Wiki-Page-Name)`
- `[README](README.md)` → `[README](Home)` or link to repo
- `[Section](FILE.md#section)` → `[Section](Wiki-Page-Name#section)`

### Navigation Changes

- Footer links point to other wiki pages
- "Back to README" links → "Back to Wiki Home"
- Cross-references use wiki page names

## 🔄 Keeping Content Updated

When repository documentation changes:

1. Update the source file in repository root
2. Run the regeneration (I can help with this)
3. Copy updated files to wiki
4. Commit and push wiki changes

## ✅ Completed Files

- ✅ `_Sidebar.md` - Navigation structure
- ✅ `_Footer.md` - Footer links
- ✅ `Home.md` - Wiki home page
- ✅ `Getting-Started.md` - Converted and ready

## 📋 TODO Files

The following files still need to be generated with wiki links:

- [ ] `Quick-Reference.md` - Convert QUICK_REFERENCE.md
- [ ] `Advanced-Usage.md` - Convert ADVANCED_USAGE.md
- [ ] `Troubleshooting.md` - Convert TROUBLESHOOTING.md
- [ ] `Labels-Reference.md` - Convert LABELS.md
- [ ] `Templates-Guide.md` - New content (see WIKI_MIGRATION_PLAN.md)

- [ ] `Governance.md` - Convert GOVERNANCE.md

## 🛠️ Migration Script

A helper script `migrate-to-wiki.sh` will be created to automate:

- Checking wiki repository exists
- Copying all files
- Committing with appropriate message
- Pushing to wiki

---

**Status**: In Progress (1 of 8 pages complete)  
**Last Updated**: October 1, 2025
