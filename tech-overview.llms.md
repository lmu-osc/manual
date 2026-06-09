# Tech Overview

What technologies we use at the OSC

This page provides a high-level overview of the technologies we use at the OSC, organized by proficiency level. Use it as a guide for what to learn depending on your role and goals.

If you are just joining the team, **basic** should be more than enough to get started. As you take on more responsibilities, you may find yourself gradually working through the other levels.

> **IMPORTANT:**
>
> - **Basic** is sufficient for most team members and essentially any contributor or learner outside of the team.
> - **Intermediate** — some parts may be used from time to time by team members.
> - **Advanced** is really intended for developer(s) maintaining the infrastructure.

## Basic

These are the tools almost everyone at the OSC uses daily.

- **R** — Our primary language for data analysis and statistical computing, including the **Tidyverse** (main packages + styling) and **{renv}** for reproducible environments.
- **RStudio / Positron** — The standard integrated development environment (IDE) for R. We are in the process of transitioning from RStudio to [Positron](https://positron.posit.co/) as Positron offers better support for R and Python in the same environment, and will be the primary IDE from Posit (formerly RStudio) moving forward.
- **git** — Version control system for tracking changes in code and content. You should understand the basics of committing, branching, and pushing to GitHub.
- **GitHub** — Platform for hosting repositories, managing contributions, and collaborating via pull requests and issues. See the [GitHub Organization](github/index.llms.md) section for more.
- **Pandoc Markdown** — The markup language used across our tutorials and documentation. You don’t necessarily need to know the details here, but understand that Quarto uses Pandoc Markdown as its underlying format, which allows for a lot of flexibility in how we write content. (And if you do want to know the details, the [Pandoc documentation](https://pandoc.org/MANUAL.html#pandocs-markdown) is a great resource.)
- **Quarto** (basic) — Publishing system built on Pandoc that we use for all of our websites and tutorials. See the [Authoring Tutorials](authoring-tutorials/index.llms.md) section for details.

> **TIP:**
>
> Don’t worry — you don’t need to be an expert in any of them on day one. Familiarity with the basics is sufficient to contribute.

## Intermediate

These technologies become relevant as you start working on our website and more complex projects.

- **CSS / HTML** — Used for styling and structuring our Quarto websites. See the [Updating Website](updating-website/index.llms.md) section for practical examples.
- **Bootstrap** — The underlying CSS framework for our Quarto websites. Understanding how it works can help with customizing our site templates.
- **Python** — Used alongside R for various data processing and automation tasks. We don’t use this directly for our tutorials (currently), but it emerges in some of the Carpentries lessons we use and in some of our internal tools.
- **GitHub Actions** (high-level understanding) — CI/CD pipelines for automating builds, tests, and deployments. See the [GitHub Organization](github/index.llms.md) section for more.

## Advanced

If you are taking on a development or maintenance role, these tools will become important.

- **In-depth HTML/CSS and Bootstrap + EJS templating** — Customizing our website templates beyond standard Quarto configurations.
- **In-depth Quarto** — Advanced configuration, custom formats, Lua filters, EJS templates, and extension development.
- **Docker** — Containerization for reproducible environments and deployment.
- **GitHub Actions** (troubleshooting and development) — Writing and debugging custom workflow files.

## Out of Scope

These are technologies used in specific projects but are **not necessary** for most team members or contributors.

- **Go** — Used in one or two projects and could potentially be replaced. Only relevant if you are working directly on those specific projects.

> **NOTE:**
>
> Many of these technologies are covered in detail elsewhere in this manual. Use the sidebar navigation to find the relevant sections, or open an issue on [GitHub](https://github.com/lmu-osc/manual/issues) if you have questions.

Back to top
