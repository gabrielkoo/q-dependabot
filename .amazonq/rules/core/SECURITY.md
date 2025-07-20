# Security Guidelines

This document provides security guidelines for working with q-dependabot.

## Local Repository Security

- The tool only reads from local repositories and does not modify them unless explicitly requested
- No repository data is sent to external servers; all analysis happens locally through Amazon Q Developer
- Be cautious when monitoring repositories from untrusted sources

## GitHub API Usage

- The tool uses GitHub CLI for authentication, which follows GitHub's security best practices
- Make sure your GitHub CLI is authenticated with appropriate scopes (read-only access is sufficient for monitoring)
- Consider using a Personal Access Token with limited scope if you're concerned about security

## Dependency Update Safety

- Always review the generated digests carefully before applying updates
- Pay special attention to breaking changes highlighted in the digest
- Consider running tests after applying updates to ensure compatibility
- For critical systems, test updates in a staging environment first

## Configuration Security

- The configuration file at `~/.qdependabot/config.json` may contain paths to sensitive repositories
- Ensure this file has appropriate permissions (readable only by your user)
- Do not include sensitive tokens or credentials in your configuration file

## Manifest File Handling

- The tool parses various manifest files but does not execute any code within them
- Be cautious when monitoring repositories from untrusted sources
- Always review the changes before applying updates
