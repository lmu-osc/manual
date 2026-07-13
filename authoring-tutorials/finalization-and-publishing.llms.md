# Finalizing and Publishing Your Tutorial

Code

Final steps for cleaning up, submitting for review, and publishing your tutorial via the OSC GitHub Org

## Overview

Once you have created your tutorial content (using the [`tutorial-template`](../authoring-tutorials/tutorial-template.llms.md) as described in the previous chapter) and are ready to publish, there are a few important steps to take to ensure your tutorial is polished, properly licensed, and ready for public consumption. This chapter covers everything you need to do to go from a draft tutorial to a live, citable publication on the OSC website. It includes:

- A **review process** overview for getting feedback on your content
- A **pre-publication checklist** of tasks to complete before publishing
- Instructions for **making your tutorial live** on the website
- Guidance on **setting up a DOI** via Zenodo and GitHub releases

This chapter is intended primarily for OSC staff who are responsible for creating and maintaining tutorials, though much of the information will also be relevant to external contributors.

------------------------------------------------------------------------

## The Review Process

Before a tutorial is published, it goes through a review period with OSC staff (and optionally with other stakeholders). This ensures the content meets our quality standards and is consistent with the rest of the website.

### How review typically works

1.  **Share your draft.** Make your tutorial repository accessible to reviewers (either within the `lmu-osc` organization or by inviting collaborators).
2.  **Collect feedback.** Reviewers provide feedback by opening **GitHub issues** or **pull requests** in your tutorial repository. This keeps the entire process transparent and documented.
3.  **Discuss and revise.** Work through the feedback, make revisions, and discuss any open questions directly in the issues or PRs.
4.  **Get approval.** Once all parties are satisfied, the tutorial is approved for publication.

> **IMPORTANT:**
>
> The exact review workflow may vary depending on the tutorial and the preferences of the people involved. What matters is that you and your reviewers agree on a process upfront and **document it in the repository** — for example in the `README.md` or in a `CONTRIBUTING.md` file. This avoids confusion about how feedback should be submitted and who is responsible for what.
>
> At minimum, your documented process should specify:
>
> - **Who** the reviewers will be (e.g., one other OSC staff member, or the entire team)
> - **How** feedback should be submitted (GitHub issues, PRs, or both)
> - **Timeline** — how long reviewers have to provide feedback (e.g., two weeks)
> - **Definition of done** — what constitutes approval (e.g., all issues resolved, or a formal sign-off)

------------------------------------------------------------------------

## Pre-Publication Checklist

Before your tutorial can go live, work through the following tasks. Some are required in all cases; others are only necessary if your tutorial uses R code. Checking off these items will help ensure a smooth publication process.

### 0. Verify your content

Before diving into the technical checklist, do a final review of your tutorial content itself:

- **Read through the entire tutorial** as if you were a learner. Are there any gaps, unclear instructions, or broken flow?
- **Check all links** — internal links (to other pages within your tutorial) and external links (to websites, documentation, etc.). Broken links frustrate readers and undermine credibility.
- **Verify images and figures** — do all images load correctly? Are the file paths correct? (Remember: use **absolute paths** from the project root, e.g., `/assets/images/my-figure.png`.)
- **Test code chunks** — if your tutorial includes code, run all code chunks fresh (clear your environment and re-execute) to confirm they produce the expected output without errors.
- **Check spelling and grammar** — consider using a spell-checker or reading your text aloud to catch awkward phrasing.

> **TIP:**
>
> Quarto’s built-in preview is your friend here. Run `quarto preview` in your project directory and navigate through the rendered site as a visitor would. This catches many issues that are invisible when looking at the raw `.qmd` files.

### 1. Update the `CITATION.cff` file

The `CITATION.cff` file contains machine-readable citation metadata for your tutorial. It allows others to cite your work correctly and can be automatically imported into reference managers like Zotero or EndNote.

Edit this file to include:

- **Author names** — list all contributors who should be credited, in the order you want them to appear in the citation
- **ORCID iDs** — unique researcher identifiers (see [orcid.org](https://orcid.org)). If an author does not have an ORCID, you can leave this field out or note “none”
- **Affiliations** — institutional affiliations for each author (e.g., “Open Science Center, LMU Munich”)
- **Version number** — should match the version tag you will use for your GitHub release (see [Zenodo Integration](#zenodo-integration-and-dois) below)
- **Title** — make sure the title matches your tutorial’s title as shown on the website
- **License** — the template defaults to `CC-BY-SA-4.0` for content and `CC0-1.0` for code; only change these if you have a specific reason

If you are unsure about the format, refer to the [official CITATION.cff documentation](https://citation-file-format.github.io/) for guidance and examples.

> **TIP:**
>
> The template repository includes a `CITATION.cff` file with placeholder values. Start by editing that file rather than creating one from scratch. Pay attention to the YAML formatting — indentation matters, and incorrect indentation can cause the file to be unreadable by citation tools.

### 2. Check your Quarto project (useful if using code chunks)

If your tutorial includes **R code chunks**, you need to take two additional steps to ensure your code will build correctly in the deployment pipeline.

#### a) Run `quarto check`

This command validates your Quarto project and checks that all code chunks are properly formatted. It helps catch errors early, before they cause build failures during deployment.

``` bash
quarto check
```

#### b) Set up `renv` for reproducible R environments

The deployment pipeline relies on `renv` to restore the exact R package versions used in your tutorial. This ensures your code remains reproducible even as packages are updated over time.

Open an R session in your project directory and run:

``` r
renv::init()
renv::snapshot()
```

This will create a lockfile (`renv.lock`) that captures the precise versions of all R packages your tutorial depends on. Commit this file to your repository.

If your tutorial does **not** contain any R code chunks, you can skip this step entirely. The deployment pipeline will still work without `renv` for Python- or Markdown-only tutorials.

### 3. Understand the built-in CI/CD workflows

The tutorial template comes with several **GitHub Actions workflows** that automate quality checks and deployment. Understanding what these do will help you interpret build results and troubleshoot issues.

The key workflows included in the template are:

| Workflow | Trigger | Purpose |
|----|----|----|
| **Render Quarto Site** | Push to `main` | Builds the site with Quarto and deploys to GitHub Pages |
| **Check for Broken Links** | Push to any branch | Scans all pages for broken internal and external links |
| **Check File Names** | Push to any branch | Validates that all file and directory names use lowercase kebab-case |

These workflows run automatically on GitHub when you push changes. You can monitor them in the **Actions** tab of your repository on GitHub. If a workflow fails, click on the failed run to inspect the logs — they usually include a clear description of what went wrong.

For a more detailed explanation of each workflow, refer to the [Tutorial Template Walkthrough](../authoring-tutorials/tutorial-template.llms.md).

### 4. Activate GitHub Pages (one-time setup)

The OSC website is built and deployed using GitHub Pages via the **Render Quarto Site** workflow mentioned above. Before the automated deployment can work, you need to activate GitHub Pages for your repository by running a one-time command.

From your local project folder, run:

``` bash
quarto publish gh-pages
```

This command does three things:

1.  **Renders** the entire site locally using Quarto
2.  **Creates** a `gh-pages` branch in your repository (this branch contains the static HTML files that GitHub Pages serves)
3.  **Pushes** that branch to GitHub

Once the `gh-pages` branch exists on GitHub, the **Render Quarto Site** workflow (included in the template) will automatically deploy your tutorial whenever changes are merged into the `main` branch.

> **TIP:**
>
> We recommend running `quarto publish gh-pages` at the **start** of your project, not at the end. This lets you verify that the site is rendering correctly on the live URL as you develop, rather than discovering issues only at publication time.

> **WARNING:**
>
> If you are unsure about this step or run into errors, reach out to an OSC staff member for assistance. Also note that GitHub Pages **cannot** be activated for private repositories — your repository must be public.

------------------------------------------------------------------------

## Making the Site Live

Once you have completed the checklist above and your tutorial has been approved through the review process, it is time to publish.

### Final checks before merging

Before your tutorial is merged into the main tutorials repository, take a moment to confirm the following:

All review feedback has been addressed and the corresponding issues/PRs are closed

The `CITATION.cff` file has accurate author information

`quarto render` completes without errors in your local environment

The `gh-pages` branch exists on GitHub (from running `quarto publish gh-pages`)

All files use lowercase kebab-case names (the **Check File Names** workflow will verify this)

No broken links remain

The repository is **public** (GitHub Pages does not work with private repositories)

### Merging into the tutorials repository

Currently, all published OSC tutorials live in the [`tutorials`](https://github.com/lmu-osc/tutorials) repository. Your tutorial repository must be merged into `tutorials` for it to appear on the live website. An OSC staff member can help coordinate this merge.

### Automated deployment

After the merge, every push to the `main` branch of the `tutorials` repository automatically triggers the **Render Quarto Site** GitHub Actions workflow, which:

1.  Checks out the latest code
2.  Restores the R environment (if using `renv`)
3.  Renders the site with Quarto
4.  Deploys the output to GitHub Pages

Your tutorial will then be live.

You can monitor the progress of any workflow run in the **Actions** tab of your repository on GitHub. If a step fails, inspect the logs — they often include helpful error messages. If you are unsure what to do after a failure, open an issue in your repository and paste the error or a screenshot.

------------------------------------------------------------------------

## Zenodo Integration and DOIs

We strongly recommend generating a **DOI** (Digital Object Identifier) for your tutorial. DOIs make your tutorial easier to cite and allow you to track its impact through citation metrics. We use **Zenodo** for this purpose.

### What is Zenodo?

[Zenodo](https://zenodo.org) is a free, open-access repository for research outputs — including datasets, software, and publications — developed and maintained by CERN. It provides a simple way to share and preserve research outputs and generates DOIs for every deposit.

### What is a GitHub release?

A **GitHub release** is a way to package and distribute a specific version of your code or content. When you create a release, you can:

- Include **release notes** describing what changed
- Attach **binary files** (if needed)
- Generate a **tag** that points to a specific commit in your repository

When a GitHub repository is connected to Zenodo, creating a new release automatically sends the repository contents to Zenodo, which then generates a DOI for that release.

#### Versioning with semantic versioning

We use **[semantic versioning](https://semver.org)** (SemVer) for all tutorial releases. Semantic versioning uses a three-part label in the format `MAJOR.MINOR.PATCH` — for example, `v0.3.0`. Here is what each number means:

- **MAJOR** — incremented when you make incompatible or breaking changes (e.g., restructuring the entire tutorial)
- **MINOR** — incremented when you add functionality or content in a backwards-compatible manner (e.g., adding a new section)
- **PATCH** — incremented when you make backwards-compatible bug fixes or minor corrections (e.g., fixing a typo or a broken link)

When creating a new release on GitHub, use a tag like `v0.3.0` (with the `v` prefix followed by the three-part version number). Start with `v0.1.0` for the first release and increment from there. This consistent labeling helps users and citation tools understand the significance of each release at a glance. When you are ready to publish the final version of your tutorial, you can use a tag like `v1.0.0` to indicate that it is the first major release.

### Setting up the connection

To connect your GitHub repository to Zenodo, an OSC staff member with ownership rights over the **OSC Zenodo organization** needs to:

1.  Log in to [Zenodo](https://zenodo.org)
2.  Go to the **GitHub** section in their account settings
3.  Link the **OSC GitHub organization** to the **OSC Zenodo account**

> **IMPORTANT:**
>
> This step requires **admin-level access** to the OSC Zenodo organization. If you need this set up, notify a member of OSC staff who can coordinate it.

Once the connection is active, follow these steps to generate a DOI:

1.  **Update `CITATION.cff`** — make sure the version number in `CITATION.cff` matches the release tag you plan to use
2.  **Create a new release** on GitHub — go to your repository’s **Releases** page, click **“Draft a new release”**, set a version tag (e.g., `v1.0.0`), add release notes, and publish
3.  **Wait for Zenodo** — within a few minutes, Zenodo will automatically create a new record and assign a DOI

> **NOTE:**
>
> While we recommend keeping the `CITATION.cff` version number and the release tag in sync, this is not strictly required for the DOI to be generated. Zenodo will create a DOI regardless, but matching the numbers avoids confusion for anyone citing your work.

------------------------------------------------------------------------

## Summary

Here is the complete workflow from draft to published tutorial. Use this as a quick reference to track your progress:

| Step | Description | Required? |
|----|----|----|
| **0. Verify content** | Review your tutorial for errors, test code, check links | ✅ Always |
| **1. Update `CITATION.cff`** | Add author names, ORCIDs, affiliations, and version | ✅ Always |
| **2. `quarto check`** | Validate Quarto project and code chunks | Only if using code |
| **3. Set up `renv`** | Create reproducible R environment with `renv::init()` | Only if using R |
| **4. Understand CI/CD** | Familiarize yourself with the built-in GitHub Actions workflows | ✅ Always |
| **5. `quarto publish gh-pages`** | Activate GitHub Pages (do this early!) | ✅ Always |
| **6. Submit for review** | Share repository with reviewers, collect feedback via issues/PRs | ✅ Always |
| **7. Final pre-merge checks** | Confirm all checklist items before merging | ✅ Always |
| **8. Merge into `tutorials`** | Coordinate with OSC staff to merge into the main tutorials repo | ✅ Always |
| **9. Set up Zenodo** | Ask OSC staff to link the GitHub organization to Zenodo | Recommended |
| **10. Create a GitHub release** | Tag a version (e.g., `v1.0.0`) and publish to generate a DOI | Recommended |

### Getting help

If you get stuck at any point, do not hesitate to:

- **Ask a colleague** — other OSC staff have been through this process before
- **Open an issue** in your tutorial repository and tag someone for help
- **Refer to the [Tutorial Template Walkthrough](../authoring-tutorials/tutorial-template.llms.md)** for detailed explanations of the template structure and workflows
- **Check the workflow logs** in the **Actions** tab of your repository on GitHub — error messages often point directly to the problem

Remember: the goal of this process is not just to publish a tutorial, but to ensure it is **maintainable**, **citable**, and **useful** to the community. Taking the time to do it carefully benefits both you and your readers.
