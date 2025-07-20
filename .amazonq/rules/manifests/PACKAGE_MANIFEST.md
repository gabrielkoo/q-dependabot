# Package Manifest

When processing the configuration file at `~/.qdependabot/config.json`, use the following guidelines:

## Configuration Structure

The configuration file should have the following structure:

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

## Manifest File Types

When scanning the manifest files specified in the configuration, look for dependencies in the following formats:

### Python

- `requirements.txt`: Look for lines with `package==version` or `package>=version`
- `Pipfile`: Look in the `[packages]` section for package names and versions
- `pyproject.toml`: Look in the `[tool.poetry.dependencies]` or `[project.dependencies]` sections
- `setup.py`: Look for `install_requires=[]` lists and package versions

### JavaScript/TypeScript

- `package.json`: Look in the `dependencies` and `devDependencies` sections

### Docker

- `Dockerfile*`: Look for lines with `FROM image:tag` or `RUN pip install package==version` in any Dockerfile variant (Dockerfile, Dockerfile.local, Dockerfile.dev, etc.)
- `docker-compose.yml`: Look for `image: name:tag` entries

### AWS SAM

- Look for Lambda layers with dependencies in their respective directories

### Free Text

- For any other file type, use intelligent parsing to identify package references and versions
- Look for patterns like `package@version`, `package-version`, or any other common format
- If the user explicitly requests, parse non-standard files or custom formats for dependencies
- Support custom regex patterns provided by the user for specialized dependency extraction

## Version Comparison

When comparing versions:

1. Parse semantic versioning (MAJOR.MINOR.PATCH)
2. Consider pre-release tags (alpha, beta, rc)
3. Handle version ranges appropriately (>=, ^, ~)

## Output Format

When reporting dependencies that need updates:

- Group by repository
- For each repository, list the dependencies that need updates
- Include the file path where the dependency was found
- Show the current version and the latest version
- Highlight any breaking changes or important notes

## Extra Note

If you found any manifest files are actually empty, you should remove them from the configuration file to avoid unnecessary processing in future runs.
