# q-dependabot

A user-driven dependency monitoring solution powered by Amazon Q Developer CLI that generates intelligent package release digests for your projects.

## Overview

q-dependabot is an automation solution that leverages Amazon Q Developer to monitor package updates across your projects and repositories. Unlike traditional dependency monitoring tools that are repository-centric, q-dependabot is user-centric, allowing you to monitor any repositories and projects that matter to you, regardless of ownership.

## Quick Install

Make sure you have [Amazon Q Developer CLI](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line-installing.html) and [GitHub CLI](https://cli.github.com/) installed.

### One-line Installation

```bash
curl -s https://raw.githubusercontent.com/gabrielkoo/q-dependabot/main/scripts/install.sh | bash
```

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/gabrielkoo/q-dependabot.git
cd q-dependabot

# Run the installer
chmod +x scripts/install.sh
./scripts/install.sh
```

The installer will:

1. Install the `q-dependabot` command globally
2. Create a configuration directory at `~/.qdependabot`
3. Set up the initial configuration file
4. Configure Amazon Q with the necessary context rules

## Configuration

After installation, edit your configuration:

```bash
q-dependabot config
```

This will open your default editor with the configuration file located at `~/.qdependabot/config.json`.

The configuration uses a simple JSON structure:

```json
{
  "dependent-repositories": [
    {
      "path": "/path/to/your/local/repo",
      "manifests": ["requirements.txt", "Dockerfile", "package.json"]
    }
  ],
  "monitored-projects": [
    "owner/repo-name"
  ]
}
```

This flexible configuration allows you to:
- Monitor any GitHub repository for releases
- Specify exactly which local repositories to check for updates
- Define which manifest files to scan in each repository
- Support any file type, including Dockerfiles, shell scripts, and more

## Usage

Simply run:

```bash
q-dependabot
```

This will:
1. Load your configuration from `~/.qdependabot/config.json`
2. Check for updates in your monitored projects
3. Scan your local repositories for dependencies that need updating
4. Generate a comprehensive digest with actionable information

### Additional Commands

```bash
q-dependabot update    # Update to the latest version
q-dependabot config    # Edit configuration file
q-dependabot uninstall # Remove q-dependabot from your system
q-dependabot help      # Show help message
```

## q-dependabot vs. GitHub's Dependabot

| Feature | q-dependabot | GitHub's Dependabot |
|---------|-----------------|-------------------|
| **Focus** | User-centric (monitor what YOU care about) | Repository-centric (only monitors repositories you own) |
| **Configuration** | Flexible JSON with support for any file type | Limited to specific package managers and manifest files |
| **Scope** | Monitor any public GitHub repository | Only repositories where Dependabot is configured |
| **Control** | Full control over what gets updated | Limited configuration options |
| **Analysis** | GenAI-powered analysis of release notes | Basic version comparison |
| **Non-package dependencies** | Supports Docker images, shell scripts, etc. | Limited to package managers |
| **Local repositories** | Works with local repositories | Requires GitHub hosting |
| **Free text configs** | Supports parsing dependencies from any text file | Limited to structured manifest files |
| **Integration** | Integrates with your local development workflow | Requires GitHub integration |
| **Privacy** | Runs locally, no data shared | Runs in GitHub's cloud |

## How Does This Work?

Amazon Q Developer CLI is configured to read the rules in the `.amazonq/rules/` directory, which contains instructions on how to:

1. Parse the `config.json` file
2. Check GitHub repositories for new releases
3. Analyze release notes for important changes
4. Scan local repositories for dependencies
5. Generate comprehensive digests
6. Create pull requests for updates

The rules are organized into the following categories:
- `core/`: Core functionality and configuration
- `manifests/`: Package manifest parsing rules
- `workflows/`: GitHub and PR creation workflows

These rules are loaded into Amazon Q's context during initialization, enabling it to perform these specialized tasks.

## Example Output

```
📦 DEPENDENCY UPDATE DIGEST (July 20, 2025)

📌 MONITORED PROJECTS:
-----------------------
✨ aws-samples/bedrock-chat (v2.3.0)
  Released: July 18, 2025

  🔑 Key Changes:
  - Added support for Claude 3.5 Sonnet
  - Improved streaming response handling
  - Fixed token counting for multi-modal inputs

  🚨 BREAKING CHANGE: Updated minimum Python requirement to 3.9

  Documentation: https://github.com/aws-samples/bedrock-chat/blob/main/CHANGELOG.md

✨ boto/boto3 (v1.34.0)
  Released: July 15, 2025

  🔑 Key Changes:
  - Added support for new S3 Express features
  - Enhanced SageMaker client capabilities
  - Performance improvements for large file uploads

  Documentation: https://github.com/boto/boto3/releases/tag/1.34.0

📂 LOCAL REPOSITORIES NEEDING UPDATES:
--------------------------------------
📁 /Users/username/Documents/some-repo
  - boto3: 1.33.6 → 1.34.0 (requirements.txt)
  - boto3: 1.33.6 → 1.34.0 (Dockerfile)

📁 /Users/username/Documents/another-repo
  - bedrock-chat: 2.2.1 → 2.3.0 (requirements.txt)
  ⚠️ Breaking change detected! Python 3.9+ now required.
```

## Why This Matters

Traditional dependency monitoring tools like Dependabot are limited to structured manifest files and only work with repositories you own. q-dependabot breaks these limitations by:

1. **Supporting any text-based configuration**: Parse dependencies from Dockerfiles, shell scripts, and custom configurations
2. **Monitoring any public repository**: Track updates for any project you depend on, regardless of ownership
3. **Providing intelligent analysis**: Get AI-powered summaries of what actually matters in updates
4. **Integrating with your local workflow**: No need to push to GitHub to check for updates

This user-driven approach puts you in control of your dependency management, saving time and reducing the risk of missing critical updates.

## Security Considerations

When using q-dependabot, keep these security best practices in mind:

### Local Repository Security
- The tool only reads from your local repositories and does not modify them unless you explicitly use the PR creation feature
- No repository data is sent to external servers; all analysis happens locally through Amazon Q Developer

### GitHub API Usage
- The tool uses GitHub CLI for authentication, which follows GitHub's security best practices
- Make sure your GitHub CLI is authenticated with appropriate scopes (read-only access is sufficient for monitoring)
- Consider using a Personal Access Token with limited scope if you're concerned about security

### Dependency Update Safety
- Always review the generated digests carefully before applying updates
- Pay special attention to breaking changes highlighted in the digest
- Consider running tests after applying updates to ensure compatibility
- For critical systems, test updates in a staging environment first

### Configuration Security
- The configuration file at `~/.qdependabot/config.json` may contain paths to sensitive repositories
- Ensure this file has appropriate permissions (readable only by your user)
- Do not include sensitive tokens or credentials in your configuration file

### Manifest File Handling
- The tool parses various manifest files but does not execute any code within them
- Be cautious when monitoring repositories from untrusted sources

## How Amazon Q Developer Helped Create This Solution

Amazon Q Developer was instrumental in developing this automation tool by:

1. Creating the specialized context rules that power the intelligent package monitoring
2. Implementing GitHub CLI integration for fetching release information
3. Developing the manifest parsing logic to scan and analyze dependency files
4. Implementing the automated PR creation workflow
5. Identifying and resolving issues in the implementation

---

*This project was created for the Amazon Q Developer Challenge: "Digital Assistant Protocol: Automating Your Daily Tasks"*
