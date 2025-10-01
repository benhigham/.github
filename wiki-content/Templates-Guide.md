# Documentation Templates Guide

This guide explains how to use the documentation templates provided in this repository.

## 📋 Table of Contents

- [Available Templates](#available-templates)
- [Template Overview](#template-overview)
  - [ARCHITECTURE.md](#architecturemd)
  - [DEVELOPMENT.md](#developmentmd)
  - [RELEASING.md](#releasingmd)
- [How to Use Templates](#how-to-use-templates)
- [Customization Guide](#customization-guide)
- [Template Placeholders](#template-placeholders)
- [Best Practices](#best-practices)

---

## Available Templates

This repository provides three documentation templates for new projects:

1. **[ARCHITECTURE.md](https://github.com/benhigham/.github/blob/main/ARCHITECTURE.md)** - Technical architecture documentation
2. **[DEVELOPMENT.md](https://github.com/benhigham/.github/blob/main/DEVELOPMENT.md)** - Development environment and workflow
3. **[RELEASING.md](https://github.com/benhigham/.github/blob/main/RELEASING.md)** - Release process and versioning

These templates are designed to be copied to your project repository and customized for your specific needs.

---

## Template Overview

### ARCHITECTURE.md

**Purpose**: Document the technical architecture of your project

**Sections included:**

- Project Overview
- System Architecture (with Mermaid diagram placeholder)
- Tech Stack
- Project Structure
- Key Components
- Design Patterns
- Data Flow
- Security Considerations
- Scalability & Performance
- Deployment Architecture
- Development Workflow
- Testing Strategy

**When to use:**

- New projects that need architecture documentation
- Existing projects lacking architecture docs
- Projects with complex technical decisions to document

**Key features:**

- Includes Mermaid diagram example for architecture visualization
- TODO comments for sections requiring customization
- Example tech stack table
- Common design patterns section

### DEVELOPMENT.md

**Purpose**: Guide developers on setting up and working with the project

**Sections included:**

- Prerequisites
- Installation
- Project Structure
- Development Workflow
- Available Scripts
- Environment Variables
- Coding Standards
- Testing
- Common Tasks
- Troubleshooting

**When to use:**

- Any project with external contributors
- Projects requiring specific development setup
- Teams needing standardized development practices

**Key features:**

- Step-by-step installation instructions
- Script documentation template
- Environment variables table
- Common task examples
- Built-in troubleshooting section

### RELEASING.md

**Purpose**: Document the release process and version management

**Sections included:**

- Release Process Overview
- Versioning Strategy (Semantic Versioning)
- Creating a Release
- Changeset Guidelines
- Release Checklist
- Hotfix Process
- Release Channels
- Post-Release Tasks
- Troubleshooting Releases

**When to use:**

- Projects using Changesets for releases
- npm packages requiring documented release process
- Teams needing consistent release procedures

**Key features:**

- Changesets-focused workflow
- Semantic versioning guidance
- Example changeset files
- Pre-release checklist
- Hotfix process documentation

---

## How to Use Templates

### Step 1: Copy to Your Repository

```bash
# Clone or navigate to your project
cd your-project

# Copy templates from the .github repository
curl -O https://raw.githubusercontent.com/benhigham/.github/main/ARCHITECTURE.md
curl -O https://raw.githubusercontent.com/benhigham/.github/main/DEVELOPMENT.md
curl -O https://raw.githubusercontent.com/benhigham/.github/main/RELEASING.md
```

Or manually:

1. Browse to [https://github.com/benhigham/.github](https://github.com/benhigham/.github)
2. Click on the template file (e.g., `ARCHITECTURE.md`)
3. Click "Raw" button
4. Copy content and create file in your repository

### Step 2: Search and Replace Placeholders

Use find-and-replace to customize:

```bash
# Replace repository name
sed -i '' 's/\[repository-name\]/my-awesome-project/g' ARCHITECTURE.md DEVELOPMENT.md RELEASING.md

# Replace package name
sed -i '' 's/\[package-name\]/@myorg\/my-package/g' ARCHITECTURE.md DEVELOPMENT.md RELEASING.md

# Replace username/org
sed -i '' 's/\[username\]/myusername/g' ARCHITECTURE.md DEVELOPMENT.md RELEASING.md
```

Or manually find and replace in your editor:

- `[repository-name]` → Your repository name
- `[package-name]` → Your npm package name (if applicable)
- `[username]` → Your GitHub username or organization

### Step 3: Fill in TODO Sections

Each template includes `<!-- TODO: ... -->` comments indicating sections that need customization:

```markdown
<!-- TODO: Add your actual architecture diagram -->
<!-- TODO: List your actual prerequisites -->
<!-- TODO: Document your specific scripts -->
```

Search for "TODO" in each file and replace with your project-specific information.

### Step 4: Remove Unused Sections

Not every section applies to every project:

- **Architecture**: Skip "Deployment Architecture" for libraries
- **Development**: Skip "Environment Variables" if not needed
- **Releasing**: Skip "Release Channels" if not using preview/canary releases

### Step 5: Keep Templates Updated

Templates evolve as projects grow:

- Revisit quarterly to ensure accuracy
- Update when architecture or processes change
- Add new sections as needed
- Keep examples current with actual code

---

## Customization Guide

### ARCHITECTURE.md Customization

1. **System Architecture Diagram**
   - Replace example Mermaid diagram with your actual architecture
   - Show key components, services, and data flow
   - Keep diagram simple and focused

2. **Tech Stack**
   - List actual technologies used
   - Include versions where important
   - Link to official documentation

3. **Project Structure**
   - Show your actual directory structure
   - Explain purpose of each major directory
   - Keep it updated as structure evolves

4. **Design Patterns**
   - Document patterns actually used in your code
   - Explain why each pattern was chosen
   - Provide code examples when helpful

### DEVELOPMENT.md Customization

1. **Prerequisites**
   - List actual required tools and versions
   - Test installation steps on a fresh machine
   - Include links to download pages

2. **Available Scripts**
   - Document all scripts from package.json
   - Explain what each script does
   - Include common options/flags

3. **Environment Variables**
   - List all required and optional variables
   - Provide example values
   - Explain what each variable controls

4. **Coding Standards**
   - Link to your linting configuration
   - Document project-specific conventions
   - Include formatting requirements

### RELEASING.md Customization

1. **Release Process**
   - Adjust for your specific workflow
   - Document CI/CD integration
   - Include deployment steps if applicable

2. **Versioning Strategy**
   - Modify if not using semantic versioning
   - Document any custom versioning rules
   - Explain breaking change policy

3. **Changeset Guidelines**
   - Customize changeset types if needed
   - Add project-specific examples
   - Document what level changes trigger what version bump

---

## Template Placeholders

### Common Placeholders

All templates use these placeholders:

| Placeholder | Replace With | Example |
|-------------|--------------|---------|
| `[repository-name]` | Your repository name | `my-awesome-app` |
| `[package-name]` | Your npm package name | `@myorg/my-package` |
| `[username]` | Your GitHub username/org | `benhigham` |

### ARCHITECTURE.md Specific

- Architecture diagram example → Your actual diagram
- Example tech stack → Your actual stack
- Generic project structure → Your actual structure

### DEVELOPMENT.md Specific

- Generic prerequisites → Your actual requirements
- Example scripts → Your actual package.json scripts
- Placeholder environment variables → Your actual variables

### RELEASING.md Specific

- Generic release schedule → Your actual schedule
- Example changesets → Your actual changeset examples
- Placeholder version strategy → Your actual strategy

---

## Best Practices

### For All Templates

1. **Keep it current**: Review and update quarterly
2. **Be specific**: Replace all placeholders with actual values
3. **Add examples**: Include real code examples from your project
4. **Link externally**: Link to related docs (README, CONTRIBUTING, etc.)
5. **Use visuals**: Add diagrams, screenshots, or code samples where helpful

### For ARCHITECTURE.md

- Update diagram when architecture changes
- Document major technical decisions with reasoning
- Include performance considerations for critical paths
- Link to detailed design docs for complex components

### For DEVELOPMENT.md

- Test installation steps on a fresh machine
- Document all non-obvious setup requirements
- Keep script documentation in sync with package.json
- Add common troubleshooting items as they arise

### For RELEASING.md

- Document the full release process, not just the happy path
- Include rollback procedures
- Document hotfix process separately
- Keep changelog format consistent

---

## Common Customization Examples

### Adding a Section

If templates don't include something you need:

```markdown
## Your New Section

Your content here...

---
```

Add it in a logical location and update the table of contents.

### Removing a Section

If a section doesn't apply:

1. Delete the section content
2. Remove from table of contents
3. Update any cross-references

### Adapting for Different Languages

Templates are Node.js-focused but adaptable:

**For Python:**

- Prerequisites: Python version, pip, virtualenv
- Scripts: Update to use setup.py or pyproject.toml commands
- Environment variables: Document .env file usage

**For Go:**

- Prerequisites: Go version, go modules
- Scripts: Document go commands (build, test, run)
- Structure: Show standard Go project layout

**For Rust:**

- Prerequisites: Rust version, cargo
- Scripts: Document cargo commands
- Structure: Show Cargo workspace layout

---

## Questions?

If you have questions about using templates or suggestions for improvements, please [open an issue](https://github.com/benhigham/.github/issues)!

---

**Last Updated**: 2025-10-01

---

## 🔗 Navigation

- [← Back to Home](Home)
- [Getting Started Guide →](Getting-Started)
- [Repository Templates](https://github.com/benhigham/.github#templates)
- [ARCHITECTURE.md Template](https://github.com/benhigham/.github/blob/main/ARCHITECTURE.md)
- [DEVELOPMENT.md Template](https://github.com/benhigham/.github/blob/main/DEVELOPMENT.md)
- [RELEASING.md Template](https://github.com/benhigham/.github/blob/main/RELEASING.md)
