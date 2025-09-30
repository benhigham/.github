# Release Process

> **Note**: This is a template file. When creating a new repository, copy this file and customize it for your specific project.

This document outlines the release process for this project.

## Release Philosophy

We follow [Semantic Versioning](https://semver.org/) (SemVer) for all releases:

- **MAJOR** version when you make incompatible API changes (X.0.0)
- **MINOR** version when you add functionality in a backward compatible manner (0.X.0)
- **PATCH** version when you make backward compatible bug fixes (0.0.X)

## Release Schedule

- **Major releases**: As needed, typically quarterly
- **Minor releases**: Monthly or as features are completed
- **Patch releases**: As needed for bug fixes
- **Security releases**: Immediately upon discovery

## Using Changesets

This project uses [Changesets](https://github.com/changesets/changesets) to manage versions and changelogs.

### Adding a Changeset

When you make changes that should be included in a release:

1. **Create a changeset**

   ```bash
   pnpm changeset
   ```

2. **Follow the prompts**
   - Select the type of change (major, minor, or patch)
   - Provide a description of the change
   - The tool will create a markdown file in `.changeset/`

3. **Commit the changeset**

   ```bash
   git add .changeset/*.md
   git commit -m "chore: add changeset for feature X"
   ```

### Changeset Guidelines

**When to create a changeset:**

- ✅ New features
- ✅ Bug fixes
- ✅ Breaking changes
- ✅ Performance improvements
- ✅ Dependency updates that affect users

**When NOT to create a changeset:**

- ❌ Internal refactoring
- ❌ Documentation updates
- ❌ Test changes
- ❌ CI/CD updates
- ❌ Dev dependency updates

**Writing good changeset descriptions:**

- Be concise but descriptive
- Focus on user impact, not implementation
- Use present tense ("Add feature" not "Added feature")
- Include migration steps for breaking changes

### Changeset Examples

**Feature (Minor)**

```markdown
---
"package-name": minor
---

Add support for custom themes. You can now pass a `theme` prop to customize colors.
```

**Bug Fix (Patch)**

```markdown
---
"package-name": patch
---

Fix crash when clicking button rapidly
```

**Breaking Change (Major)**

```markdown
---
"package-name": major
---

BREAKING: Rename `onClick` prop to `onPress` for consistency. 

Migration: Replace all instances of `onClick` with `onPress`.
```

## Release Process

### Automated Release (Recommended)

We use GitHub Actions to automate releases:

1. **Create changesets** for your changes (as described above)
2. **Merge PR to main branch**
3. **Changeset bot creates a "Version Packages" PR**
   - This PR updates version numbers
   - Updates CHANGELOG.md
   - Removes processed changeset files
4. **Review and merge the "Version Packages" PR**
5. **GitHub Actions automatically publishes** the new version to npm
6. **GitHub release is created** automatically

### Manual Release (If needed)

If you need to release manually:

1. **Ensure you're on the main branch and up to date**

   ```bash
   git checkout main
   git pull origin main
   ```

2. **Update versions**

   ```bash
   pnpm changeset version
   ```

   This will:
   - Update version in `package.json`
   - Update `CHANGELOG.md`
   - Delete processed changeset files

3. **Commit version changes**

   ```bash
   git add .
   git commit -m "chore(release): bump package versions"
   git push origin main
   ```

4. **Create a git tag**

   ```bash
   git tag -a v1.2.3 -m "Release v1.2.3"
   git push origin v1.2.3
   ```

5. **Publish to npm**

   ```bash
   pnpm run build
   pnpm changeset publish
   ```

6. **Create GitHub Release**
   - Go to [Releases](https://github.com/benhigham/[repository-name]/releases)
   - Click "Draft a new release"
   - Select the tag you created
   - Copy changelog entries from CHANGELOG.md
   - Publish the release

## Pre-release Versions

For alpha, beta, or release candidate versions:

1. **Enter pre-release mode**

   ```bash
   pnpm changeset pre enter alpha
   ```

2. **Create changesets and version as normal**

   ```bash
   pnpm changeset
   pnpm changeset version
   ```

   This creates versions like `1.0.0-alpha.0`

3. **Publish with a tag**

   ```bash
   pnpm changeset publish --tag alpha
   ```

4. **Exit pre-release mode** when ready for stable release

   ```bash
   pnpm changeset pre exit
   ```

## Release Checklist

Before creating a release, ensure:

- [ ] All CI checks are passing
- [ ] All tests are passing locally
- [ ] Documentation is up to date
- [ ] CHANGELOG.md is complete and accurate
- [ ] Breaking changes are clearly documented
- [ ] Migration guide is provided (for breaking changes)
- [ ] Dependencies are up to date
- [ ] Security vulnerabilities are addressed
- [ ] Version number follows SemVer

## Post-Release

After a release is published:

1. **Verify the release**
   - Check npm package is published
   - Verify GitHub release is created
   - Test installation in a fresh project

2. **Announce the release**
   - Post in GitHub Discussions
   - Update project website/blog
   - Share on social media
   - Notify relevant stakeholders

3. **Monitor for issues**
   - Watch for bug reports
   - Check CI/CD for failures
   - Monitor npm download stats

## Hotfix Releases

For urgent bug fixes:

1. **Create a hotfix branch** from the latest release tag

   ```bash
   git checkout -b hotfix/v1.2.4 v1.2.3
   ```

2. **Make the fix and add a changeset**

   ```bash
   pnpm changeset
   # Select patch version
   ```

3. **Version and commit**

   ```bash
   pnpm changeset version
   git add .
   git commit -m "chore(release): hotfix v1.2.4"
   ```

4. **Create tag and push**

   ```bash
   git tag -a v1.2.4 -m "Hotfix v1.2.4"
   git push origin v1.2.4
   ```

5. **Publish**

   ```bash
   pnpm changeset publish
   ```

6. **Merge back to main**

   ```bash
   git checkout main
   git merge hotfix/v1.2.4
   git push origin main
   ```

## Rollback Procedure

If a release needs to be rolled back:

1. **Deprecate the bad version on npm**

   ```bash
   npm deprecate package-name@1.2.3 "This version has critical bugs. Please upgrade to 1.2.4"
   ```

2. **Publish a patch/fixed version immediately**

3. **Update GitHub release** to mark it as problematic

4. **Notify users** through all channels

## Version Support

- **Latest major version**: Full support
- **Previous major version**: Security fixes only for 6 months
- **Older versions**: No support (users should upgrade)

## NPM Tags

- `latest`: Current stable release
- `next`: Pre-release versions
- `alpha`: Alpha releases
- `beta`: Beta releases
- `canary`: Bleeding edge builds from main

## Security Releases

For security vulnerabilities:

1. **DO NOT** create a public issue
2. Follow [SECURITY.md](SECURITY.md) to report
3. Patch is developed privately
4. Coordinate disclosure with reporters
5. Release patch ASAP
6. Publish security advisory
7. Notify users through security mailing list

## Useful Commands

```bash
# Check what would be released
pnpm changeset status

# Preview changelog
pnpm changeset version --dry-run

# View current version
pnpm version

# Check if package can be published
pnpm publish --dry-run

# View all tags
git tag -l

# View releases on npm
npm view package-name versions
```

## Troubleshooting

### Failed publish

If publish fails:

1. Check npm credentials
2. Verify version doesn't already exist
3. Check package.json for errors
4. Try publishing with `--verbose` flag

### Wrong version published

1. Deprecate the version
2. Publish correct version
3. Update documentation

### Missing changelog entries

1. Manually update CHANGELOG.md
2. Create supplementary release notes
3. Amend GitHub release description

## Resources

- [Semantic Versioning](https://semver.org/)
- [Keep a Changelog](https://keepachangelog.com/)
- [Changesets Documentation](https://github.com/changesets/changesets)
- [npm Publishing Guide](https://docs.npmjs.com/packages-and-modules/contributing-packages-to-the-registry)

## Questions?

If you have questions about the release process:

- Open a [GitHub Discussion](https://github.com/benhigham/[repository-name]/discussions)
- Contact the maintainers
- Check the [Contributing Guide](CONTRIBUTING.md)
