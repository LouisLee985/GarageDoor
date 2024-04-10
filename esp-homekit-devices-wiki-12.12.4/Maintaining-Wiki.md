Below are my notes on the development environment and the tools used to
maintain the wiki.

# Development Tools

All development of the wiki is done using [Visual Studio Code](https://code.visualstudio.com)

The following list of Extensions are used to make life easy in linting and
spell checking etc.

| Extension | Description |
|-----------|-------------|
| [Git Graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph) | View a git graph of the repository
| [TODO Highlighter](https://marketplace.visualstudio.com/items?itemName=wayou.vscode-todo-highlight) | Useful TODO management extension
| [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint) | Markdown file linter
| [Markdown Preview Github Styling](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-preview-github-styles) | Make your markdown look like github
| [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker) | A basic spell checker
| [JSON Tools](https://marketplace.visualstudio.com/items?itemName=eriklynd.json-tools) | JSON formatter & beautifier
| [Bracket Pair Colorizer](https://marketplace.visualstudio.com/items?itemName=eriklynd.json-tools) | Bracket colorizer

## Markdown Linter

Check out the `.markdownlint.json` file for details of the rules disabled.

## Workflow

I clone the `https://github.com/RavenSystem/esp-homekit-devices.wiki.git`
locally and edit directly using Visual Studio Code.

In developing and maintaining the wiki I use the following workflow:

### Editing

I keep a separate git branch called `develop` for making all the current edits.
All changes are done on this branch and validated using the builtin
Visual Studio Code `Markdown: Open Preview to Side` command (`CMD-K V`).

Using the Markdown Preview Github Styling enables you to see exactly what your
edits will look like when pushed to Github.

### Preview on GitHub

In order to preview on Github before pushing to the main repository I have forked
the repo to my own Github account.
I have then set up an additional remote repository in my clone, as follows:

```shell
git remote add githubtest https://github.com/WizBangCrash/esp-homekit-devices.wiki.git
```

When I am ready to review exactly how Github renders my results before pushing
them to the master branch of `https://github.com/RavenSystem/esp-homekit-devices.wiki.git`
I use the following git command to push my `develop` branch to the `master`
branch of my own fork.

```shell
git push --force githubtest develop:master
```

I am then able to review the results on Github at
`https://github.com/WizBangCrash/esp-homekit-devices/wiki`

### Pushing Latest Changes

Once reviewed, the latest changes in develop can be merged into master and then
pushed to the master branch of
`https://github.com/RavenSystem/esp-homekit-devices.wiki.git` using the
following commands:

```shell
git checkout master
git pull
git merge develop
git push
```
The `git pull` in the above is to ensure we pull any changes made by other
members working on the Wiki repo.