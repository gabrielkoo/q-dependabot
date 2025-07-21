# Routines

Note that routine B depends on routine A, so make sure to run routine A first.

## A. Monitored projects Digest Routine

1. Load the configuration from `~/.qdependabot/config.json`.
2. Loop through the list of monitored projects from the `monitored-projects` array.
3. For each project, check the latest releases from the specified date (1 week from now if not specified).
4. If new release(s) is/are found, generate a digest for that release.
   In particular, focus on the following:
   - The release tag/date/notes
   - Any new features, bug fixes, or breaking changes
   - Any relevant links to documentation or migration guides
5. Print out the summary of the digest

## B. Local Repositories Digest Routine

1. Load the configuration from `~/.qdependabot/config.json`.
2. For each repository in the `dependent-repositories` array, check the specified manifest files for dependencies.
3. Compare the dependencies with the latest releases from the monitored projects.
4. If a dependency needs to be updated, mark it down with the to/from versions.
5. Print out the summary for each monitored package, as well as the list of dependent repositories that need to be updated.
6. Highlight any breaking changes that might affect the repositories.

## C. PR Creation Routine

If the user requests to create a PR for updating dependencies:

1. Identify the repository and dependencies to update.
2. Create a new branch with a descriptive name.
3. Update the manifest files with the new dependency versions.
4. Commit the changes with a descriptive message.
5. Create a PR using the GitHub CLI.
6. Provide a summary of the changes in the PR description.

---

## Sample Output

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

This output should be just echo-ed back to the user unless specified. Do not create any local files or make any changes to the user's repositories unless explicitly requested.
