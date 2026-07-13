# Best Working Practices for GitHub

Code

Guidelines and conventions for using GitHub effectively in our organization

This page documents the conventions and best practices we follow when working with GitHub at the OSC. Following these guidelines ensures consistency across our repositories, makes collaboration smoother, and helps maintain a clean project history.

------------------------------------------------------------------------

## Creating and setting up repositories

When setting up a new repository under the [lmu-osc](https://github.com/lmu-osc) organization, use **kebab-case** for the name — lowercase letters, numbers, and hyphens only. For example, `lmu-osc.github.io` rather than `lmu_osc.github.io`, and `tutorial-template` rather than `tutorial_template`. This ensures consistency and avoids issues with case-sensitive filesystems and URL parsing.

Every repository must include a `README.md` with a clear description of its purpose, contents, and how to use it — start with a one-paragraph summary, include a table of contents for longer READMEs, document setup and usage, add a “Contributing” section, and list any dependencies. Every repository also needs a `LICENSE` file. For content (text, images, documentation) we use **CC BY-SA 4.0**; for code snippets within tutorials we use **CC0 1.0**. Standalone software projects should consider licenses like Apache 2.0 or AGPLv3. See the [licensing page](../misc-topics/our-licensing-choices.llms.md) for a full explanation of our choices.

As for visibility, all content repositories (tutorials, documentation, the main website) should be **public**, aligning with our commitment to open science. Private repositories are reserved for internal tools, drafts not yet ready for public release, or configurations containing sensitive information.

**Tutorials** should always be created from the [tutorial-template](https://github.com/lmu-osc/tutorial-template) repository, which provides a consistent directory structure, Quarto configuration, and styling. For other types of repositories, check if a suitable template already exists in the organization before starting from scratch. Finally, when creating a repository, always provide a short description and relevant topic tags (e.g., `tutorial`, `quarto`, `documentation`) to make it discoverable.

------------------------------------------------------------------------

## Making changes to a repository

These guidelines apply to any repository with more than one contributor. Before making significant changes, **create an issue** to document what you plan to do. This gives others a chance to provide feedback before you invest time in implementation, creates a record of the rationale behind changes, helps avoid duplicated effort, and can attract collaborators. For very small changes (fixing a typo, updating a single number), you can skip the issue and go straight to a pull request.

The `main` branch should always be in a deployable or publishable state, so **never commit directly to `main`**. Always create a new branch for your work — even for small changes — and open a pull request when you’re ready to merge. This allows for review and keeps the history clean. If you accidentally commit to `main`, don’t panic. The safest option is `git revert HEAD`, which creates a new commit that undoes the last one and preserves history. If the commit hasn’t been pushed yet, you can use `git reset --hard HEAD~1` to remove it. If it has been pushed, you’ll need `git push --force-with-lease`, but be careful — this rewrites history and can cause issues for others who have pulled the branch. When in doubt, ask a team member for help.

Use descriptive branch names that make it clear what the branch is for. A good convention is `fix/description` for bug fixes, `feature/description` for new features, `docs/description` for documentation updates, and `refactor/description` for code restructuring — for example, `fix/broken-link-in-readme` or `feature/add-search-to-website`.

A pull request should address a **single concern**. If you find yourself fixing multiple unrelated things, split them into separate PRs. This makes reviews faster, reduces the risk of conflicts, and keeps the project history easier to follow.

Write **meaningful commit messages** that explain *why* a change was made, not just *what* was changed. A widely-used convention is a short summary line (50 characters or less) written in the imperative mood — “Fix bug in data processing” rather than “Fixed” or “Fixes” — followed by a blank line and a more detailed body wrapped at about 72 characters. Reference any related issues (e.g., “Closes \#42”). It’s less important to follow this format strictly on development branches, but the final commit message for a PR should be clear and informative. The [Git and GitHub Review](../github/review.llms.md) page has additional resources on this topic.

Always request at least **one review** before merging a PR. Even if you’re eager to get something merged, a fresh pair of eyes can catch issues you’ve missed. Reviews are about improving the code, not criticizing the author — be open to feedback and constructive in your own reviews.

------------------------------------------------------------------------

## Solo projects

For personal projects or repositories where you are the sole contributor, you can commit directly to `main` if you prefer. However, it’s still worth using branches and PRs for significant changes: they keep a clear history of why changes were made, allow for review by others (collaborators, your future self, or someone who takes over the project), and serve as documentation of the development process.

------------------------------------------------------------------------

## Keeping repositories healthy

Regularly update dependencies in your repositories. For Quarto-based projects, this means updating Quarto itself and any extensions. For software projects, keep package dependencies current and address security advisories promptly.

Every repository should have a `.gitignore` file that prevents committing build artifacts, system files (like `.DS_Store`), environment-specific files (`.env`, `venv/`, `node_modules/`), and editor/IDE files (`.vscode/`, `.idea/`). Quarto projects, for example, should generally ignore the `_site/` output directory since it is generated from source files.

If a repository is no longer actively maintained, consider **archiving** it on GitHub. This makes it clear to visitors that the project is read-only, prevents new issues and pull requests from being opened, and preserves the repository for reference. Add a note to the README explaining why it was archived and, if applicable, where development has moved.

------------------------------------------------------------------------

## Working with forks

Most OSC work happens in shared repositories using branches (since team members have write access). However, you may occasionally need to work with forks when contributing to a project outside the OSC organization, or when an external contributor wants to contribute to our projects. When reviewing PRs from forks, be aware that external contributors may not have the same context about our conventions — provide clear, constructive guidance.

------------------------------------------------------------------------

## Quick reference

| Scenario | Recommended workflow |
|----|----|
| Creating a new repo | Use kebab-case, add README + LICENSE, use a template if applicable |
| Making a small fix | Create a branch, commit, open a PR |
| Making a significant change | Create an issue first, then branch → commit → PR |
| Solo project | Can commit to `main`, but branches + PRs still recommended for major changes |
| Reviewing a PR | Be constructive, focus on the code not the author |
| Repository no longer active | Archive it, add a note to the README |
