# Tutorial Template Walkthrough

Code

A thorough overview of the `tutorial-template` repository — how to navigate it, adapt it, and avoid common pitfalls

## Overview

The [`tutorial-template`](https://github.com/lmu-osc/tutorial-template) repository is the standard starting point for all OSC tutorials. It is a lightweight [Quarto](https://quarto.org) website project pre-configured with our branding, navigation structure, and automated workflows. Its purpose is to let you focus on writing content without worrying about setup, styling, or deployment.

This page walks you through every file and directory in the template, explains what each one does, what you should (and should not) change, and how to work with the built-in GitHub Actions workflows.

------------------------------------------------------------------------

## Creating a New Tutorial from the Template

### 1. Create a copy of the template

Navigate to the [`tutorial-template` repository on GitHub](https://github.com/lmu-osc/tutorial-template) and click the green **“Use this template”** button, then choose **“Create a new repository”**. You will be asked to name your new repository and choose its owner:

- If you have permissions to create repositories in the `lmu-osc` organization, you can create it there directly.
- Otherwise, create it in your personal GitHub account. You (or another OSC member with permissions) can later transfer it to the organization.
- If you need help, ask Felix or Malika to create the repository for you.

### 2. Clone the repository and verify it works

``` bash
git clone https://github.com/lmu-osc/YOUR-TUTORIAL-NAME.git
cd YOUR-TUTORIAL-NAME
quarto render
```

This should complete without errors and generate a `_site/` directory with the rendered website. If it fails, make sure you have [Quarto installed](https://quarto.org/docs/get-started/) on your machine.

### 3. Start editing

Open the project folder in your editor (VS Code, Positron, RStudio — any will work). **Be sure to open the folder itself**, not individual files, so your editor recognizes the project structure and Quarto commands work with the correct working directory.

------------------------------------------------------------------------

## Repository Structure — File by File

Below is a complete overview of every file and directory in the template. Files are grouped by their role.

### Site Configuration

| File | Purpose | Do you need to edit it? |
|----|----|----|
| `_quarto.yml` | The master configuration file for the Quarto project. Controls the site title, navigation sidebar, navbar links, theme, output settings, and repository URLs. | **Yes** — update `title:`, `repo-url:`, and the GitHub URLs under `navbar > tools` to match your repository. |
| `index.qmd` | The homepage / landing page of your tutorial. This is the first thing visitors see. | **Yes** — replace the welcome message, tutorial overview, and software prerequisites. **Do not rename or delete this file.** |
| `about.qmd` | An example about page containing license, citation, and contributor information. | **Yes** — fill in author names, affiliations, ORCIDs, DOI, and the date. |
| `CITATION.cff` | Citation metadata in a machine-readable format. Allows others to cite your tutorial properly. | **Yes** — update with author names, affiliations, and ORCIDs. See the [CITATION.cff documentation](https://citation-file-format.github.io/) for details. |

### Content Pages

| File / Directory | Purpose |
|----|----|
| `topic-one/` | Example section directory. Contains an `index.qmd` (section landing page) and sub-pages like `page-one.qmd`, `page-two.qmd`. |
| `topic-one/index.qmd` | Landing page for the first major topic. Has YAML front matter with a title but no H1 heading (the title serves as the H1). |
| `topic-one/page-one.qmd` | Example sub-page demonstrating good practices: starts with H2 headings (not H1), includes a note about the table of contents. |
| `topic-two/` | Another example section, with an `index.qmd` and three sub-pages (`page-one.qmd`, `page-two.qmd`, `page-three.qmd`). |

**You should rename or replace these example folders.** For a two-section tutorial, you might rename `topic-one/` → `data-preparation/` and `topic-two/` → `analysis/`. For a single-page tutorial, you can delete the example folders entirely and put all content in `index.qmd`.

Each section’s `index.qmd` acts as a chapter landing page. Additional `.qmd` files in the same folder become sub-pages within that section. If you don’t need sub-pages, just use the `index.qmd` alone.

> **TIP:**
>
> - **Do not use H1 (`#`) headings** in your content pages. The page title from the YAML front matter is automatically rendered as an H1. Using additional H1s can break the table of contents and is discouraged by Quarto. Start with H2 (`##`) headings instead.
> - Use **lowercase, kebab-case** for file and directory names (e.g., `my-topic/my-page.qmd`), not spaces or camelCase. This keeps URLs clean and avoids issues with the filename-checking workflow.
> - Each `.qmd` file should have **YAML front matter** with at least a `title:` field.
> - When referencing images, assets, or other files, use **absolute paths** from the root of the project (e.g., `![](/assets/images/my-figure.png)`) rather than relative paths. This ensures links work correctly regardless of the page’s location in the directory structure.

### Styling and Branding

| File | Purpose | Do you need to edit it? |
|----|----|----|
| `lmu-osc-custom.scss` | Site-wide SCSS overrides for colors, fonts, and layout. Sets the navbar background, link colors, and sidebar highlight to OSC green. | Only if you want to change branding colors or site-wide layout. See notes below. |
| `styles.css` | Additional CSS classes for content-level styling (e.g., `.center`, `.img-border`, `.output-overflow`). | Only if you need custom styling for specific page elements. The pre-defined classes cover common use cases. |

> **WARNING:**
>
> - **Do not modify `lmu-osc-custom.scss` or `styles.css` unless you are comfortable with CSS/SCSS.** The default styles are designed to match the OSC branding. If you need a visual change you cannot achieve yourself, ask a web-savvy colleague or open an issue.
> - **Do not edit the `_site/` directory.** The `_site/` folder is generated automatically by Quarto when you render the site. Any changes you make there will be overwritten the next time you run `quarto render` or `quarto preview`.

### Licensing

| File | Purpose | Do you need to edit it? |
|----|----|----|
| `LICENSE.md` | The full text of the **CC BY-SA 4.0** license, which covers the tutorial content (narrative text, images, etc.). | Please do not without explicit permission. |
| `LICENSE-CODE.md` | The full text of the **CC0 1.0 Universal** license, which covers code snippets and configuration files. | Please do not without explicit permission. |

We use a dual-licensing model: the narrative content is CC BY-SA 4.0 (share-alike, requires attribution), while code and configuration files are CC0 1.0 (public domain, no restrictions). This is a common practice for educational websites and is explained in the `about.qmd` page.

### Other Files

| File | Purpose | Do you need to edit it? |
|----|----|----|
| `README.md` | The GitHub repository README. Contains the quick overview, structure overview, step-by-step adaptation instructions, and information about GitHub Actions. | **Yes** — update it to describe your specific tutorial. |
| `404.qmd` | Custom 404 error page shown when visitors try to access a page that does not exist. | Optional — you can customize the message or leave it as-is. |
| `matomo-analytics.html` | Matomo Analytics tracking snippet, included in the page header via `_quarto.yml`. | **Please ask an OSC staff member to include this for you.** |
| `.gitignore` | Lists files and directories that Git should ignore (e.g., `.Rproj.user`, `_site/`, `/.quarto/`). | Only if your project generates new temporary files that should not be tracked. |
| `.filenameignore` | Patterns that the automated filename-check workflow should ignore. | Only if the filename-check workflow flags files that you intentionally want to keep. |

### Directories

| Directory | Purpose |
|----|----|
| `assets/` | Place static files here: images, downloadable files, videos, etc. Reference them in your pages with paths like `![](/assets/images/my-figure.png)`. |
| `_site/` | **Auto-generated.** Contains the rendered HTML output. Do not edit manually. |
| `.github/workflows/` | Contains GitHub Actions workflow files (see next section). |
| `renv/` | (Optional) R package environment directory. Only relevant if you use R and `renv` for dependency management. |

------------------------------------------------------------------------

## GitHub Actions Workflows

The template includes several automated workflows in `.github/workflows/`. These run automatically on GitHub when you push changes, and some can also be triggered manually. Understanding them helps you avoid surprises.

### Available Workflows

1.  **Render Quarto Site** — Renders the Quarto project and publishes the output to GitHub Pages. This is the workflow that makes your tutorial live on the web. It triggers on pushes to the `main` branch and can also be run manually from the Actions tab.

2.  **Check CITATION.cff** — Validates that your `CITATION.cff` file is correctly formatted. Runs on every push. If this workflow fails, check that your `CITATION.cff` follows the [specification](https://citation-file-format.github.io/).

3.  **Filename Checks** — Ensures all file and directory names follow our conventions (lowercase, kebab-case, no spaces). Runs on every push. If it flags files you intentionally want to keep (e.g., third-party assets with uppercase names), add them to `.filenameignore`.

4.  **Tidyverse Style Formatting** — Checks code formatting for R code files using the [styler](https://styler.r-lib.org/) package. Only relevant if your tutorial includes R code.

### How to Run a Workflow Manually

1.  Go to your repository on GitHub and click the **Actions** tab.
2.  Select the workflow you want to run from the left sidebar.
3.  Click the **“Run workflow”** button.
4.  Choose the branch you want to run it on from the dropdown, then click **“Run workflow”** again.

You can monitor the progress of any workflow run by clicking on it. If a step fails, inspect the logs to understand why — they often include helpful error messages. If you are unsure what to do after a failure, open a GitHub issue in your repository and paste the error or screenshot.

> **IMPORTANT:**
>
> - The **Render Quarto Site** workflow must be activated once for a new repository by running `quarto publish gh-pages` locally. After that, every push to `main` automatically triggers a re-render and updates the live site.
> - If your repository is **private**, GitHub Pages cannot be activated, and the publishing workflow will not work.
> - Workflows that trigger on `push` (like the CITATION.cff check and filename check) run automatically. You do not need to manually start them.
> - For the **Tidyverse Style Formatting** workflow: it pushes formatting fixes back to your branch. Always pull those changes before making further edits.

------------------------------------------------------------------------

## Step-by-Step: Adapting the Template

Here is the recommended order of operations when creating a new tutorial:

### 1. Update `_quarto.yml`

Change these values: - `title:` — set to your tutorial’s name - `repo-url:` — point to your new repository - The GitHub URLs under `navbar > tools` — update to your repository’s URL

Optionally, adjust the `sidebar:` and `navbar:` sections to reflect your tutorial’s structure. The sidebar controls the left navigation menu; the navbar controls the top bar.

### 2. Edit the homepage (`index.qmd`)

Replace the placeholder text with: - A welcome message - A tutorial overview (topics covered, estimated time) - Prerequisites / recommended software - A table of contents linking to each section

### 3. Edit the about page (`about.qmd`)

Fill in: - Author names, affiliations, ORCIDs - The date and DOI - Contributor acknowledgements

### 4. Rename or replace the example topic folders

- Rename `topic-one/` and `topic-two/` to match your section names.
- Within each folder, rename or replace the example `.qmd` files.
- Update the `sidebar:` section in `_quarto.yml` to reflect the new folder and page names (see next section).

### 5. Update `CITATION.cff`

Add your author names, affiliations, and ORCIDs. This file allows others to cite your tutorial.

### 6. Update `README.md`

Replace the template’s README with information about your specific tutorial.

### 7. Add images and files

Place images in `assets/images/` (or a subdirectory of `assets/`). Reference them in your pages with:

``` markdown
![Descriptive caption](/assets/images/my-image.png){width=80%}
```

### 8. Update `_quarto.yml` navigation

After renaming folders and pages, you **must** update the `sidebar:` section in `_quarto.yml` so the navigation menu matches your new structure. For example, if you renamed `topic-one/` to `data-preparation/` and have two sub-pages, the sidebar entry would look like:

``` yaml
contents:
  - section: "Data Preparation"
    href: data-preparation/index.qmd
    contents:
      - href: data-preparation/cleaning.qmd
        text: "Data Cleaning"
      - href: data-preparation/transformation.qmd
        text: "Data Transformation"
```

### 9. Preview locally

``` bash
quarto preview
```

This starts a local web server and opens your default browser. Changes you make are reflected automatically as you save files.

### 10. Publish

Activate GitHub Pages by running this command **once** from your local project folder:

``` bash
quarto publish gh-pages
```

This may take several minutes. You can check progress in the Actions tab of your repository. After this initial setup, every push to `main` will automatically re-render and deploy the site.

------------------------------------------------------------------------

## Common Pitfalls and How to Avoid Them

| Pitfall | Solution |
|----|----|
| Using H1 (`#`) headings in content pages | Use H2 (`##`) headings instead. The page title from YAML front matter is already an H1. |
| Renaming or deleting `index.qmd` | The Quarto project expects an `index.qmd` at the root. Rename other files, not this one. |
| Editing `_site/` directly | Never edit `_site/`. It is regenerated from source files every time you render. |
| Spaces in file or directory names | Use lowercase kebab-case: `my-section/my-page.qmd` instead of `My Section/My Page.qmd`. |
| Forgetting to update `_quarto.yml` after renaming pages | The sidebar navigation in `_quarto.yml` must match your actual file structure. |
| Using `quarto render` instead of `quarto preview` during editing | `quarto preview` gives you a live-updating preview. Use `quarto render` only for final builds or debugging. |
| Not pulling after the Tidyverse Style workflow runs | If the formatting workflow runs, it may push changes to your branch. Pull those changes before continuing to edit. |

------------------------------------------------------------------------

## Getting Help

If you get stuck or need assistance:

- **Open a GitHub issue** in your repository describing what you want to change. Someone from OSC or your team can help.
- **Ask a colleague** — other OSC members have experience with the template and can offer guidance.
- **Check the official [Quarto documentation](https://quarto.org/docs/)** for questions about Quarto itself (theming, navigation, cross-references, etc.).

The template is designed to be as simple as possible, but if something is unclear, do not hesitate to reach out.
