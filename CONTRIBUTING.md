# Contributing

When contributing to this repository, please first discuss the change you wish to make by raising an issue.

Note: we have a [Code of Conduct](CODE_OF_CONDUCT.md), please follow it in all your interactions with the project.

## Development Environment Setup

This repository contains templates, workflows, and configurations. No traditional "installation" is needed, but here's how to work with it:

### Prerequisites

- **Git**: [Latest version](https://git-scm.com/)
- **GitHub CLI** (optional): For testing workflows and labels
- **VS Code** (recommended): For markdown editing and YAML validation
- **yamllint** (optional): For validating YAML files

### Setup

1. **Clone the repository**

   ```sh
   git clone git@github.com:benhigham/.github.git
   cd .github
   ```

2. **Validate YAML files** (optional)

   ```sh
   # Install yamllint
   brew install yamllint  # macOS
   # or
   pip install yamllint   # Python

   # Validate all YAML files
   yamllint .github/
   ```

3. **Test label configuration** (optional)

   ```sh
   # Using github-label-sync (requires Node.js)
   npx github-label-sync --dry-run --labels .github/labels.yml benhigham/.github
   ```

### Making Changes

- Edit workflow files in `.github/workflows/`
- Edit label configuration in `.github/labels.yml`
- Edit documentation in markdown files
- Test workflows in a separate test repository before merging

### Validating Changes

Before submitting a PR:

1. **Validate YAML syntax** - Use your IDE or yamllint
2. **Check markdown formatting** - Use a markdown linter or preview
3. **Test workflows** - Create a test repository and call the workflows
4. **Review documentation** - Ensure all examples are accurate
5. **Update CHANGELOG.md** - Document user-facing changes

### Testing Workflows

To test a reusable workflow:

1. Create a test repository
2. Create a workflow that calls the reusable workflow
3. Push and verify it runs correctly
4. Check logs for errors or warnings

Example test workflow:

```yaml
# .github/workflows/test-ci.yml in your test repository
name: Test CI
on: [push]

jobs:
  test:
    uses: benhigham/.github/.github/workflows/ci.yml@main
    with:
      node-version: '20'
      run-lint: true
      run-test: true
```

### Project Structure

```
.github/
├── workflows/          # Reusable workflow definitions
├── actions/            # Custom composite actions
├── ISSUE_TEMPLATE/     # Issue form templates
├── PULL_REQUEST_TEMPLATE/  # PR templates
└── DISCUSSION_TEMPLATE/    # Discussion templates
```

See [AGENTS.md](AGENTS.md) for comprehensive AI coding assistant guidance.

## Issues and Feature Requests

You've found a bug in the source code, a mistake in the documentation, or maybe you'd like a new feature? You can help us by submitting an issue on GitHub. Before you create an issue, make sure to search the issue archive -- your issue may have already been addressed!

Please try to create bug reports that are:

- _Reproducible._ Include steps to reproduce the problem.
- _Specific._ Include as much detail as possible: which version, what environment, etc.
- _Unique._ Do not duplicate existing opened issues.
- _Scoped to a single bug._ One bug per report.

**Even better: Submit a pull request with a fix or new feature!**

### How To Submit a Pull Request

1. Search our repository for open or closed Pull Requests that relate to your submission. You don't want to duplicate effort.
2. Fork the project
3. Create your feature branch (`git checkout -b feat/amazing-feature`)
4. Commit your changes (`git commit -m 'feat: Add amazing-feature'`) This Project uses [conventional commits](https://www.conventionalcommits.org), please follow the specification in your commit messages.
5. Push to the branch (`git push origin feat/amazing-feature`)
6. Open a Pull Request
