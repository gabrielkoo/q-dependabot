# q-dependabot Rules

This directory contains the rules used by q-dependabot to monitor dependencies and generate digests.

## Directory Structure

- `core/`: Core functionality and configuration rules
  - `CONFIG.md`: Guidelines for working with the configuration file
  - `ROUTINES.md`: Defines the main routines for dependency checking
  - `SECURITY.md`: Security guidelines for working with q-dependabot

- `manifests/`: Package manifest parsing rules
  - `PACKAGE_MANIFEST.md`: Guidelines for parsing different types of manifest files

- `workflows/`: GitHub and PR creation workflows
  - `GITHUB.md`: Guide for checking GitHub repositories
  - `PR_TEMPLATE.md`: Template for creating pull requests

## How Rules Are Used

These rules are loaded into Amazon Q's context during initialization, enabling it to perform specialized tasks related to dependency monitoring and updating.

When you run `q-dependabot`, the tool will:

1. Load these rules into Amazon Q's context
2. Execute the routines defined in `ROUTINES.md`
3. Generate a comprehensive digest of dependency updates

## Adding Custom Rules

You can add custom rules to extend the functionality of q-dependabot. Simply create a new Markdown file in the appropriate directory and it will be loaded automatically when you run `q-dependabot`.
