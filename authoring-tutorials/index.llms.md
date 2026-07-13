# Authoring Tutorials for the OSC

Code

A technical guide to using Quarto and the `tutorial-template` for authoring tutorials for the OSC

## Welcome

Welcome to the **Authoring Tutorials** section of the OSC Manual. This guide is for anyone who needs to create or maintain tutorials for the Open Science Center website — whether you are a new staff member creating your first tutorial, or an experienced contributor looking for a refresher on our tooling and processes.

This section covers the **technical aspects** of authoring tutorials: how we use [Quarto](https://quarto.org) to build our tutorial websites, how to work with the [`tutorial-template`](https://github.com/lmu-osc/tutorial-template) repository, and what steps are required to get a tutorial from a draft to a published, citable resource.

We do not prescribe *what* you should write or how you should structure your content pedagogically. Instead, we provide an overview of the **tools and workflows** we use, so you can focus on writing great tutorials without worrying about the technical setup.

> **NOTE:**
>
> This guide is intended primarily for **OSC staff** or other individuals who are responsible for creating and maintaining tutorials. However, much of the advice here is applicable to any Quarto project. Even if you are using a different setup, the tips and best practices covered in these pages are recommended reading for anyone interested in learning more about how our websites are built and/or who wishes to contribute to the OSC web presence.

------------------------------------------------------------------------

## What You Will Learn

This section is organized into three chapters, meant to be read in order:

### 1. [Quarto Overview and Tips](../authoring-tutorials/quarto-overview.llms.md)

If you are new to Quarto, start here. This chapter provides a brief introduction to what Quarto is and how we use it to create our website. It covers:

- The `.qmd` file format (YAML front matter, Markdown content, and code chunks)
- Quarto projects vs. standalone documents
- Installing Quarto and essential commands (`quarto preview`, `quarto render`, `quarto publish`)
- A typical authoring workflow
- Common Quarto features you will use frequently: figures, cross-references, callout blocks, code chunks, and tables
- Shortcuts and tips for working efficiently

### 2. [Tutorial Template Walkthrough](../authoring-tutorials/tutorial-template.llms.md)

This chapter provides a detailed, file-by-file walkthrough of the [`tutorial-template`](https://github.com/lmu-osc/tutorial-template) repository — the standardized starting point for all of our tutorials. It covers:

- How to create a new tutorial from the template (step-by-step)
- What each file and directory in the template does, and which ones you need to edit
- The built-in **GitHub Actions workflows** and what they do
- A recommended order of operations for adapting the template to your tutorial
- Common pitfalls and what *not* to do

### 3. [Finalization and Publishing](../authoring-tutorials/finalization-and-publishing.llms.md)

Once your tutorial content is ready, this chapter walks you through everything needed to go from a draft to a live, citable publication. It covers:

- The review process (how feedback is collected and resolved via GitHub issues and pull requests)
- A pre-publication checklist (verifying content, updating `CITATION.cff`, running `quarto check`, setting up `renv`)
- Activating GitHub Pages (the one-time `quarto publish gh-pages` command)
- Making the site live (merging into the tutorials repository and automated deployment)
- Setting up a DOI via Zenodo and GitHub releases

------------------------------------------------------------------------

## Quick Start

If you are an experienced author who just needs a reminder of the key steps, here is the condensed workflow:

1.  **Create a new repository** from the [`tutorial-template`](https://github.com/lmu-osc/tutorial-template) using the “Use this template” button on GitHub.
2.  **Clone your new repository** and open the folder in your editor.
3.  **Update `_quarto.yml`** with your tutorial’s title, repository URL, and navigation structure.
4.  **Write your content** in `.qmd` files, previewing with `quarto preview`.
5.  **Run the pre-publication checklist** (verify content, update `CITATION.cff`, activate GitHub Pages).
6.  **Submit for review** and iterate on feedback.
7.  **Merge and publish** — your tutorial goes live automatically.

For full details on each step, follow the chapters above in order. If you get stuck or have questions, reach out to an OSC staff member or [open an issue](https://github.com/lmu-osc/manual/issues) in the OSC Manual repository.

Back to top
