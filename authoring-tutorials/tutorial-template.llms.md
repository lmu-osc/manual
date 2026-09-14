# Tutorial Template Walkthrough

Code

A thorough overview of the `tutorial-template` repository and Quarto extension — how to navigate it, adapt it, and avoid common pitfalls

## Overview

The [`tutorial-template`](https://github.com/lmu-osc/tutorial-template) is the standard starting point for all OSC tutorials. It is a lightweight [Quarto](https://quarto.org) website project pre-configured with our branding, navigation structure, and automated workflows. Its purpose is to let you focus on writing content without worrying about setup, styling, or deployment.

The template is distributed as a **Quarto extension**. That means the theme, branding, the shared HTML format (`tutorial-template-html+tutorial`), and the page footer live in an installed extension under `_extensions/` rather than in loose stylesheets that you would copy and edit. A tutorial’s `_quarto.yml` therefore only needs to declare:

``` yaml
project:
  type: tutorial-template
```

Quarto then supplies the OSC color palette and fonts, light/dark themes, sidebar search, the footer, and a set of sensible HTML defaults. Because this configuration is versioned separately from your content, it can be refreshed later with a single command (see [Keeping the Extension Up to Date](#keeping-the-extension-up-to-date)) without touching anything you have written.

This page walks you through every file and directory in the template, explains what each one does, what you should (and should not) change, and how to work with the built-in GitHub Actions workflows. A shorter, plain-language version aimed at non-technical contributors is available in the template’s own [`README-template.md`](https://github.com/lmu-osc/tutorial-template/blob/main/README-template.md), though it is less detailed and may lag behind this page.

## Quick Start

Below is a condensed workflow for creating a new tutorial from the template. **If you are new to Quarto or the template, we recommend reading the full documentation on this page before starting. The presentation is a quick start guide that should help you quickly cover the main content, but please do read the rest of the chapter afterwards.**

Click through the slides below using the left/right arrow keys, or [open the deck directly](../authoring-tutorials/tutorial-template-slides.llms.md) to see it full screen.

## Creating a New Tutorial from the Template

This section expands on some details from the quick start slides above, mostly just providing additional context or background information.

### 1. Create the project from the template

From the directory where you want your tutorial to live, run:

``` bash
quarto use template lmu-osc/tutorial-template
```

This single command sets up a new tutorial. It downloads the template, asks you to confirm that you trust it, copies the starter files into the directory, and installs the `tutorial-template` Quarto extension under `_extensions/`. It requires **Quarto 1.9.0 or newer**. If the directory already contains files, Quarto asks whether to use it as-is or to create a new subdirectory; if it creates one, `cd` into it afterwards.

> **NOTE:**
>
> `quarto use template` skips the files listed in the template’s [`.quartoignore`](https://github.com/lmu-osc/tutorial-template/blob/main/.quartoignore), along with editor and build artifacts such as `.git/`, `.posit/`, and `_site/`. Your new project therefore does **not** contain the template repository’s own `README.md` or `CITATION.cff` (it gets `README-template.md` and `CITATION-template.cff` instead), nor the template’s `update-branding.yml` maintenance workflow, nor `.quartoignore` itself.

> **WARNING:**
>
> **Do not use GitHub’s green “Use this template” button** on the `tutorial-template` repository. That copies the repository as a static snapshot rather than installing the template the way Quarto expects, which leaves your project unable to pick up future theme and footer changes. Use the command above instead.

### 2. Create the repository and push your project

`quarto use template` builds the project locally but does not create a Git repository. Create one for your tutorial — in the `lmu-osc` organization if you have permission, otherwise in your personal account, where an OSC member can help and it can be transferred later — and push to it:

``` bash
git init
git add .
git commit -m "Initial commit from tutorial-template"
git branch -M main
git remote add origin https://github.com/lmu-osc/YOUR-REPO-NAME.git
git push -u origin main
```

### 3. Rename the placeholder files

Two files are deliberately suffixed so that the `tutorial-template` repository can carry its own `README.md` and `CITATION.cff` without those being copied into new projects. Rename them:

``` bash
mv CITATION-template.cff CITATION.cff
mv README-template.md README.md
```

One further rename happens automatically: Quarto renames a starter file named `template.qmd` to match the project directory. If you ran the command in a folder called `my-tutorial`, the template’s demonstration page arrives as `my-tutorial.qmd`, not `template.qmd`. You can delete it once you no longer need the branding reference, or rename it to something more descriptive and add it to the sidebar in `_quarto.yml` if you want it reachable.

### 4. Verify it renders

``` bash
quarto preview
```

This should complete without errors and open the rendered website in your browser. If it fails, check that you have a recent version of [Quarto installed](https://quarto.org/docs/get-started/).

### 5. Start editing

Open the project folder in your editor (VS Code, Positron, RStudio — any will work). **Be sure to open the folder itself**, not individual files, so your editor recognizes the project structure and Quarto commands work with the correct working directory.

------------------------------------------------------------------------

## Repository Structure — File by File

Below is a complete overview of every file and directory in the template. Files are grouped by their role.

### Site Configuration

| File | Purpose | Do you need to edit it? |
|----|----|----|
| `_quarto.yml` | The master configuration file for the Quarto project. Declares `project: type: tutorial-template` and controls the site title, navigation sidebar, navbar links, page footer text, and the format overrides. | **Yes** — update `title:`, `repo-url:`, the GitHub URLs under `navbar > tools`, and the `page-footer` copyright line. |
| `index.qmd` | The homepage / landing page of your tutorial. This is the first thing visitors see. It also contains a hidden R chunk that loads `downlit` and `xml2` (needed for clickable code links) and two callout-tips inviting readers to star the repository and to visit the About page. | **Yes** — replace the welcome message, tutorial overview, and software prerequisites. Keep the code chunk and the callouts. **Do not rename or delete this file.** |
| `about.qmd` | The About page. Contains the Contributors, Licenses, and Notes sections, and carries the site’s citation metadata in its YAML front matter (title, authors, DOI, version). | **Yes** — fill in author names, affiliations, ORCIDs, the date, and the DOI. |
| `template.qmd` | A demonstration page showing the colors, Bootstrap components, typography, and logo shortcodes provided by the extension. Quarto renames it to match your project directory (e.g. `my-tutorial.qmd`), and it is not linked from the sidebar. | Optional — delete it once you no longer need the branding reference. If you keep it, add it to the `sidebar:` in `_quarto.yml` if you want it reachable. |
| `404.qmd` | Custom 404 error page shown when visitors request a page that does not exist. | Optional — you can customize the message or leave it as-is. |

### Citation, Licensing, and References

| File | Purpose | Do you need to edit it? |
|----|----|----|
| `CITATION.cff` | Citation metadata in a machine-readable format, so others can cite your tutorial correctly. Created by renaming `CITATION-template.cff`. | **Yes** — update with author names, affiliations, ORCIDs, version, and DOI. See the [CITATION.cff documentation](https://citation-file-format.github.io/). |
| `README.md` | The GitHub repository README. Created by renaming `README-template.md`. | **Yes** — describe your specific tutorial. |
| `LICENSE.md` | The full text of the **CC BY-SA 4.0** license, which covers the tutorial content (narrative text, images, etc.). | Please do not change without explicit permission. |
| `LICENSE-CODE.md` | The full text of the **CC0 1.0 Universal** license, which covers code snippets and configuration files. | Please do not change without explicit permission. |
| `references.bib` | A BibTeX bibliography. The template cites the `tutorial-template` extension here, and `about.qmd` renders it. Add entries if your tutorial cites sources. | Only if you cite references. |

We use a dual-licensing model: the narrative content is CC BY-SA 4.0 (share-alike, requires attribution), while code and configuration files are CC0 1.0 (public domain, no restrictions). This is a common practice for educational websites and is explained in the `about.qmd` page.

### The Quarto Extension

| Directory | Purpose |
|----|----|
| `_extensions/` | The installed `tutorial-template` Quarto extension. It defines the `tutorial-template` project type and the `tutorial-template-html+tutorial` format, and it embeds the OSC brand (`brand.yml`, the color palette, fonts, logos, and a `lmu-osc-custom.scss`). |

> **WARNING:**
>
> Everything under `_extensions/` is managed by Quarto. Editing it directly means your changes will be silently overwritten the next time the extension is updated — including by the automated `Update Tutorial Template Extension` workflow, which runs on a schedule. If you need a different look, see [Styling and Branding](#styling-and-branding) below.

### Content Pages

| File / Directory | Purpose |
|----|----|
| `topic-one/` | Example section directory. Contains an `index.qmd` (section landing page) and sub-pages `page-one.qmd` and `page-two.qmd`. |
| `topic-one/index.qmd` | Landing page for the first major topic. Has YAML front matter with a title but no H1 heading (the title serves as the H1). |
| `topic-one/page-one.qmd` | Example sub-page demonstrating good practices: starts with H2 headings (not H1) and explains why. |
| `topic-two/` | Another example section, with an `index.qmd` and three sub-pages (`page-one.qmd`, `page-two.qmd`, `page-three.qmd`). |

**You should rename or replace these example folders.** For a two-section tutorial, you might rename `topic-one/` → `data-preparation/` and `topic-two/` → `analysis/`. For a single-page tutorial, you can delete the example folders entirely and put all content in `index.qmd`.

Each section’s `index.qmd` acts as a chapter landing page. Additional `.qmd` files in the same folder become sub-pages within that section. If you don’t need sub-pages, just use the `index.qmd` alone.

> **TIP:**
>
> - **Do not use H1 (`#`) headings** in your content pages. The page title from the YAML front matter is automatically rendered as an H1, and Quarto discourages multiple H1s on a page. Start with H2 (`##`) headings instead.
> - Use **lowercase, kebab-case** for file and directory names (e.g., `my-topic/my-page.qmd`), not spaces or camelCase. This keeps URLs clean and avoids issues with the filename-checking workflow.
> - Each `.qmd` file should have **YAML front matter** with at least a `title:` field.
> - When referencing images, assets, or other files, use **absolute paths** from the root of the project (e.g., `![](/assets/images/my-figure.png)`) rather than relative paths. This ensures links work correctly regardless of the page’s location in the directory structure.

### The Footer and Assets

The footer is included on every page, and is stored in the `footer/` directory. Authors should not need to edit this.

Please store your images, data files, and other assets in the `assets/` directory (or a subdirectory of it). Reference them with absolute paths from the project root, e.g., `![](/assets/images/my-figure.png)`.

### Analytics and Housekeeping

| File | Purpose | Do you need to edit it? |
|----|----|----|
| `matomo-analytics.html` | Matomo Analytics tracking snippet, included in every page’s header via `include-in-header` in `_quarto.yml`. It is wrapped in a conditional so that tracking is **not** recorded from `localhost` previews. | **Please ask an OSC staff member to provide the tracking code for you.** Keep the `localhost` check in place. |
| `.gitignore` | Lists files and directories that Git should ignore (e.g., `.Rproj.user`, `_site/`, `/.quarto/`). | Only if your project generates new temporary files that should not be tracked. |
| `.filenameignore` | Patterns that the automated filename-check workflow should ignore. | Only if the filename-check workflow flags files that you intentionally want to keep. |
| `.Rbuildignore` | Inherited from the template repository; relevant only if the project is ever built as an R package. | No — leave this alone. |

The template’s own [`.quartoignore`](https://github.com/lmu-osc/tutorial-template/blob/main/.quartoignore) is not copied into your project. It lives in the `tutorial-template` repository and controls which files `quarto use template` skips.

### Generated Directories

| Directory | Purpose |
|----|----|
| `_site/` | **Auto-generated.** Contains the rendered HTML output. Do not edit manually — it is regenerated from source every time you render. |
| `.quarto/` | Local Quarto build cache. Do not edit; it is git-ignored. |

------------------------------------------------------------------------

## GitHub Actions Workflows

The template includes several automated workflows in `.github/workflows/`. These run automatically on GitHub when you push changes, and some can also be triggered manually. Understanding them helps you avoid surprises. The file [`.github/workflows/README.md`](https://github.com/lmu-osc/tutorial-template/blob/main/.github/workflows/README.md) covers the core workflows in plain language, though the descriptions below are the more complete and current reference.

### Available Workflows

## Render Quarto Site

`publish.yaml`

**Trigger:** Push to `main`, weekly schedule, manual

Renders the project and publishes the output to GitHub Pages. This is the workflow that makes your tutorial live on the web.

## Check CITATION.cff is Valid

`citation-check.yml`

**Trigger:** Push to `main` when `CITATION.cff` changes, manual

Validates that your `CITATION.cff` is correctly formatted. If it fails, check the file against the [specification](https://citation-file-format.github.io/).

## Filename Checks

`filename-check.yml`

**Trigger:** Push to `main`, pull requests, manual

Ensures file and directory names meet our conventions (limits on path length and depth, allowed file types, no uppercase/spaces). If it flags files you intentionally want to keep (e.g., third-party assets), add them to `.filenameignore`.

## Link Checker

`link-checker.yml`

**Trigger:** Monthly schedule, manual

Crawls the published site and opens a single issue labelled `link-checker` listing any broken links. It checks the live URL, so it only does anything once your site is published.

## Air Formatting

`style.yaml`

**Trigger:** Manual

Formats R and Quarto code with [Air](https://posit-dev.github.io/air/) and commits the changes back to the branch. Only relevant if your tutorial includes R code.

## Update Tutorial Template Extension

`update-extension.yml`

**Trigger:** Monthly schedule, manual

Runs `quarto update lmu-osc/tutorial-template` to pull the latest release of the extension into your project and commits the change. This is what keeps your theme and footer current.

The `tutorial-template` repository itself includes one additional workflow, `update-branding.yml`, which refreshes the OSC brand assets embedded in the extension. That workflow is excluded from projects created from the template via `.quartoignore`.

### How to Run a Workflow Manually

1.  Go to your repository on GitHub and click the **Actions** tab.
2.  Select the workflow you want to run from the left sidebar.
3.  Click the **“Run workflow”** button.
4.  Choose the branch you want to run it on from the dropdown, then click **“Run workflow”** again.

If you do not see a **“Run workflow”** button, the workflow does not support manual runs — but any workflow that triggers on `push` will still run automatically when you push changes.

You can monitor the progress of any workflow run by clicking on it. If a step fails, inspect the logs to understand why — they often include helpful error messages. If you are unsure what to do after a failure, open a GitHub issue in your repository and paste the error or screenshot.

> **IMPORTANT:**
>
> - The **Render Quarto Site** workflow must be activated once for a new repository by running `quarto publish gh-pages` locally. After that, every push to `main` automatically triggers a re-render and updates the live site.
> - If your repository is **private**, GitHub Pages cannot be activated, and the publishing workflow will not work.
> - The **Render Quarto Site** workflow detects a `renv.lock` file and restores your R packages from it; if there is no lockfile, it installs the latest R and infers packages from your files. Either way works, but a lockfile gives you reproducible builds (see [Finalization and Publishing](../authoring-tutorials/finalization-and-publishing.llms.md)).
> - Workflows that trigger on `push` (the CITATION check, the filename check) run automatically. You do not need to manually start them.
> - The **Update Tutorial Template Extension** and **Air Formatting** workflows push commits back to your branch. Always pull those changes before making further edits, or you will create conflicts.

------------------------------------------------------------------------

## Styling and Branding

All default styling now comes from the installed extension, so most tutorials should not need to change anything. If you do need an adjustment, work *outside* `_extensions/`:

- **Small, tutorial-specific CSS tweaks** — add a stylesheet and reference it from the `format` block in `_quarto.yml`, extending the template’s definition rather than replacing it:

  ``` yaml
  format:
    tutorial-template-html+tutorial:
      css:
        - footer/footer-style.css
        - my-styles.css
      include-after-body:
        - file: footer/footer.html
  ```

- This sets the default format for all pages to `tutorial-template-html+tutorial`. Individual Quarto files ***should not*** override this with their own `format:` value unless you are intentionally creating e.g. a RevealJS slide deck or a PDF.

- **Brand colors, fonts, or logos** — these come from the `osc-brand` extension embedded in the template. Changing them is an organization-level decision; open an issue in the [template repository](https://github.com/lmu-osc/tutorial-template) rather than editing the extension yourself.

> **WARNING:**
>
> - **Do not edit files under `_extensions/`.** They are managed by Quarto and will be overwritten on the next extension update.
> - **Do not edit the `_site/` directory.** It is generated automatically by Quarto and will be overwritten the next time you render or preview.

## Common Pitfalls and How to Avoid Them

| Pitfall | Solution |
|----|----|
| Editing files under `_extensions/` | These are managed by Quarto and will be overwritten on the next update. Put custom CSS in its own file and reference it from `_quarto.yml`. |
| Forgetting to rename the placeholder files | A project still containing `CITATION-template.cff` or `README-template.md` will fail the CITATION check and display a placeholder README. Rename both on setup. |
| Looking for `template.qmd` in your new project | Quarto renames the template’s demonstration page to match your project directory (e.g. `my-tutorial.qmd`). Delete it once you no longer need the branding reference. |
| Using H1 (`#`) headings in content pages | Use H2 (`##`) headings instead. The page title from YAML front matter is already an H1. |
| Renaming or deleting `index.qmd` | The Quarto project expects an `index.qmd` at the root. Rename other files, not this one. |
| Editing `_site/` directly | Never edit `_site/`. It is regenerated from source files every time you render. |
| Spaces or uppercase letters in file or directory names | Use lowercase kebab-case: `my-section/my-page.qmd` instead of `My Section/My Page.qmd`. The filename-check workflow will flag violations. |
| Forgetting to update `_quarto.yml` after renaming pages | The sidebar navigation in `_quarto.yml` must match your actual file structure. |
| Using `quarto render` instead of `quarto preview` during editing | `quarto preview` gives you a live-updating preview. Use `quarto render` only for final builds or debugging. |
| Not pulling after an automated workflow pushes a commit | The extension-update and formatting workflows push changes to your branch. Pull before continuing to edit. |
| Removing the footer include or the `format` block | The footer and its stylesheet are wired up through `_quarto.yml`. Deleting these lines removes the site footer from every page. |

------------------------------------------------------------------------

## Getting Help

If you get stuck or need assistance:

- **Open a GitHub issue** in your repository describing what you want to change. Someone from OSC or your team can help.
- **Ask a colleague** — other OSC members have experience with the template and can offer guidance.
- **Check the official [Quarto documentation](https://quarto.org/docs/)** for questions about Quarto itself (theming, navigation, cross-references, etc.).
- **Report a problem with the template or extension** in the [template repository](https://github.com/lmu-osc/tutorial-template/issues).

The template is designed to be as simple as possible, but if something is unclear, do not hesitate to reach out.

Back to top
