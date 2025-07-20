# Configuration Guide

This document provides guidelines for working with the q-dependabot configuration file.

## Configuration File Location

The configuration file is located at `~/.qdependabot/config.json`.

## Configuration Structure

The configuration file has the following structure:

```json
{
  "dependent-repositories": [
    {
      "path": "/path/to/your/repo",
      "manifests": ["requirements.txt", "Dockerfile", "package.json"]
    }
  ],
  "monitored-projects": [
    "owner/repo-name"
  ]
}
```

## Configuration Validation

When validating the configuration file:

1. Check that the file exists and is valid JSON
2. Verify that all repository paths exist on the local filesystem
3. Check that the monitored projects are valid GitHub repositories
4. Ensure that the manifest files specified for each repository are supported

## Configuration Updates

When updating the configuration:

1. Use the `q-dependabot config` command to open the configuration file in the default editor
2. Make changes to the configuration file
3. Save the file and exit the editor
4. The changes will be applied the next time q-dependabot is run

## Security Considerations

1. The configuration file contains paths to local repositories
2. Ensure that the configuration file has appropriate permissions (readable only by the user)
3. Do not include sensitive tokens or credentials in the configuration file
