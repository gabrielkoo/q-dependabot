# Pull Request Template

If the user has requested to make a pull request to one/more projects to be updated in some of the local repositories, please follow the steps below:

```bash
DEFAULT_BRANCH=$(gh repo view --json defaultBranch -q .defaultBranch)
git checkout $DEFAULT_BRANCH
git pull origin $DEFAULT_BRANCH
git checkout -b deps/package-name-to-version-here
# (Make the manifest changes in the local repository first)
git add .
git commit -m "deps: update package xxx to v#.#.#"
gh pr create --title "deps: update package xxx to v#.#.#" --body "This PR updates the following projects: [list of projects]." --base $DEFAULT_BRANCH --head deps/package-name-to-version-here
```
