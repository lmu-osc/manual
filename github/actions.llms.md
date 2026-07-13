# GitHub Actions

Code

What they are, how they work, and how we use them at the OSC

## Purpose of this page

This page introduces **GitHub Actions** from the ground up. If you’ve never used GitHub Actions before, you’ll learn what they are, how they work, and why they’re useful. If you already have some experience, you’ll find details on how we specifically use Actions at the OSC and what conventions we follow.

By the end of this chapter, you should be able to:

- Explain what GitHub Actions are and what problems they solve.
- Understand the core concepts: workflows, jobs, steps, runners, and events.
- Read and understand a simple workflow file.
- Know where workflow files live and how to add, edit, or remove them.
- Find and interpret workflow run results.
- Recognize the common Actions we use at the OSC and what each one does.

------------------------------------------------------------------------

## What are GitHub Actions?

**GitHub Actions** is a built-in automation platform that lets you run tasks—called *actions*—in response to events that happen in your GitHub repository. Think of it as a way to tell GitHub: *“Whenever X happens, do Y.”*

Common examples include:

- Running tests automatically whenever someone opens a pull request.
- Building and deploying a website whenever new code is pushed to `main`.
- Checking for broken links or spelling mistakes on a schedule.
- Formatting code or running quality checks before merging.

Before GitHub Actions existed, you had to use separate tools (like Jenkins, Travis CI, or CircleCI) to do these things, and you often had to configure them on your own servers. GitHub Actions is **integrated directly into GitHub**, which means:

- No separate accounts or servers to set up (for most cases).
- Results appear right inside your repository, on pull requests and in the GitHub interface.
- It’s free for public repositories and includes a generous free tier for private ones.

> **Note for beginners:** If you’ve never used a CI/CD (Continuous Integration / Continuous Deployment) tool before, don’t worry. The basic idea is simple: you write a recipe (a “workflow”) that tells GitHub what to do, and GitHub follows that recipe automatically when certain things happen in your repository. The rest of this page walks you through everything you need to know.

------------------------------------------------------------------------

## Core concepts

Before we dive into examples, let’s build a mental model of the key pieces. Each term builds on the previous one.

### Workflow

A **workflow** is the top-level unit of automation: a complete, automated process made up of one or more jobs. Workflows are defined in YAML files (a human-readable data format, similar to a simpler version of JSON). You’ll learn the YAML syntax shortly.

A workflow is:

- **Triggered by one or more events** (e.g., a push, a pull request, a scheduled time).
- **Stored in your repository** inside the `.github/workflows/` directory.
- **Named** by the filename (e.g., `deploy-website.yml`).

### Event

An **event** is a specific activity that triggers a workflow. Examples:

| Event | When it happens |
|----|----|
| `push` | Code is pushed to a branch. |
| `pull_request` | A pull request is opened, updated, or reopened. |
| `workflow_dispatch` | Someone manually triggers the workflow from the GitHub UI. |
| `schedule` | A pre-defined time (using cron syntax). |
| `issues` | An issue is opened, closed, or edited. |

A workflow can listen for multiple events.

### Job

A **job** is a set of steps that execute on the same runner. A workflow can have one job or multiple jobs. Jobs can run:

- **In parallel** (the default) — useful when jobs are independent of each other.
- **Sequentially** — useful when one job depends on the output of another (e.g., deploy only after tests pass).

### Step

A **step** is an individual task within a job. Steps can be:

- **Shell commands** (e.g., `npm install`, `python script.py`).
- **Actions** — reusable units of code (more on these below).

Steps within a job share the same filesystem (so a file created in one step is available in the next).

### Action

An **action** is a reusable, packaged piece of code that performs a specific task. Actions are the building blocks of workflows. Instead of writing everything from scratch, you can use pre-built actions from the [GitHub Marketplace](https://github.com/marketplace?type=actions) or write your own.

For example, instead of writing a script to check out your repository, you use the official `actions/checkout` action. Instead of manually installing a programming language, you use `actions/setup-python` or `r-lib/actions/setup-r`.

Think of actions as **function calls** for your workflow — they save you from reinventing the wheel.

### Runner

A **runner** is a server that executes your workflows. There are two types:

- **GitHub-hosted runners**: Virtual machines provided by GitHub with common tools pre-installed (Ubuntu Linux, Windows, macOS). For public repositories, these are free up to a usage limit.
- **Self-hosted runners**: Servers you manage yourself. We don’t currently use these at the OSC.

When a workflow is triggered, GitHub spins up a fresh runner, runs your jobs, and then discards the runner. This means each run starts from a clean slate — no files or state carry over between runs.

> **Tip:** This clean-slate design is important. If your workflow needs certain software installed, it must install it every time (or use a pre-built action that does it for you).

------------------------------------------------------------------------

## Anatomy of a workflow file

Workflow files are written in **YAML** and stored in `.github/workflows/` at the root of your repository. Let’s look at a minimal example:

``` yaml
# .github/workflows/example.yml
name: Example Workflow

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  greet:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repository
        uses: actions/checkout@v4

      - name: Say hello
        run: echo "Hello, world!"
```

Let’s break this down line by line:

| Line(s) | What it does |
|----|----|
| `name: Example Workflow` | A human-readable name for the workflow. Appears in the GitHub UI. |
| `on:` | Defines the **triggering events**. Here, the workflow runs on pushes and pull requests to `main`. |
| `jobs:` | The start of the jobs section. |
| `greet:` | The **identifier** for one job. You can name jobs whatever you like. |
| `runs-on: ubuntu-latest` | Specifies the **runner** type. `ubuntu-latest` is GitHub’s standard Linux runner. |
| `steps:` | The list of steps this job will execute, in order. |
| `- name: ...` | A human-readable label for the step (optional but recommended). |
| `uses: actions/checkout@v4` | Uses the official `checkout` action to clone your repository onto the runner. |
| `run: echo "Hello, world!"` | Runs a shell command directly. |

### YAML basics for workflow files

If you’re new to YAML, here’s what you need to know to read workflow files:

- **Indentation matters**: YAML uses spaces (not tabs) to indicate nesting. Two spaces per level is the convention.
- **`key: value`** pairs define mappings.
- **Lists** start with `-` (a hyphen followed by a space).
- **Comments** start with `#`.
- **Strings** usually don’t need quotes, but it’s safe to use them.

### A more realistic example

Here’s a workflow that installs R packages with renv and runs a script:

``` yaml
name: R Check

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  r-check:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repository
        uses: actions/checkout@v4

      - name: Set up R
        uses: r-lib/actions/setup-r@v2

      - name: Restore renv packages
        uses: r-lib/actions/setup-renv@v2

      - name: Run R script
        run: Rscript -e 'rmarkdown::render_site()'
```

Notice how the `uses` keyword pulls in pre-built actions. The `r-lib/actions/setup-r@v2` action installs R on the runner, and `r-lib/actions/setup-renv@v2` restores the packages from your `renv.lock` file. You didn’t have to write any of that installation logic — the actions handle it.

------------------------------------------------------------------------

## Where workflows live

Workflow files must be placed in a specific directory at the root of your repository:

    your-repository/
    └── .github/
        └── workflows/
            ├── deploy-website.yml
            ├── spellcheck.yml
            └── url-check.yml

The directory name is case-sensitive: `.github/workflows/` (note the dot at the start). Each `.yml` file in this directory defines a separate workflow. GitHub automatically discovers and activates them.

### Adding a workflow

To add a new workflow:

1.  Create the directory `.github/workflows/` if it doesn’t exist.
2.  Create a new `.yml` file inside it (e.g., `deploy-website.yml`).
3.  Write your workflow definition (or copy an existing one and adapt it).
4.  Commit and push the file to your repository.
5.  GitHub will automatically pick up the new workflow the next time its trigger event occurs.

### Editing a workflow

Simply edit the `.yml` file in the `.github/workflows/` directory, commit, and push. The next workflow run will use the updated version.

### Removing a workflow

Delete the `.yml` file from `.github/workflows/`, commit, and push. GitHub will stop triggering that workflow.

> **Tip:** If you want to temporarily disable a workflow without deleting the file, you can set it to trigger on `workflow_dispatch` only (manual trigger), or add a `if: false` condition at the top of the workflow.

------------------------------------------------------------------------

## Viewing and troubleshooting workflow runs

### Finding workflow runs

Every workflow run appears in your repository under the **“Actions” tab** (the tab with a play/stopwatch icon). From there you can:

- See a list of all recent workflow runs, sorted by most recent.
- Filter by workflow name, branch, status (success, failure, cancelled), or event (push, PR, etc.).
- Click on any run to see its details.

### Reading run results

When you click into a specific workflow run, you’ll see:

1.  **The commit that triggered the run** — useful for correlating code changes with workflow results.
2.  **The list of jobs** — click on a job to expand its steps.
3.  **Each step’s log output** — click on a step to see its full console output. This is where you look when something goes wrong.

GitHub also surfaces workflow results directly on pull requests: a green checkmark ✅ means all checks passed, a red ✖ means something failed, and a yellow circle means checks are still running.

### Troubleshooting common issues

When a workflow fails, here’s how to diagnose it:

1.  **Go to the Actions tab** and find the failing run.
2.  **Click on the run**, then click on the failed job.
3.  **Look for the step that has a red ✖** — that’s where the error occurred.
4.  **Expand that step** to read its log output. The error message is usually at the bottom.

Common failure patterns:

| Symptom | Likely cause |
|----|----|
| `Command not found` | A required tool isn’t installed — add a setup step (e.g., `actions/setup-python`). |
| `Permission denied` | The workflow doesn’t have the right permissions. Check the workflow’s `permissions` setting. |
| `Cannot find file` | The `actions/checkout` step is missing or placed too late — add it early in the job. |
| `renv package restore failed` | The `renv.lock` file is out of sync with `renv/` directory — run `renv::snapshot()` locally and commit the updated files. |
| Workflow didn’t run | The file might not be in `.github/workflows/`, or the trigger event doesn’t match. |

> **Tip:** You can also re-run a workflow from the Actions tab. This is useful if a failure was due to a transient issue (e.g., a network timeout). GitHub even offers a “Re-run failed jobs” option, which only re-runs the jobs that failed, saving time.

------------------------------------------------------------------------

## Events and triggers in more detail

We touched on events earlier. Here’s a deeper look at the ones we use most frequently at the OSC.

### `push`

Triggers the workflow whenever commits are pushed to a branch. You can narrow it to specific branches:

``` yaml
on:
  push:
    branches: [main]
```

You can also exclude branches:

``` yaml
on:
  push:
    branches-ignore:
      - 'wip/**'
```

### `pull_request`

Triggers when a pull request is opened, synchronized (new commits are pushed), or reopened.

``` yaml
on:
  pull_request:
    branches: [main]
```

A useful distinction: `push` runs on your branch as you work; `pull_request` runs on the **merge result** (i.e., the combination of your branch and the target branch). This means a PR check can catch merge conflicts before they land on `main`.

### `workflow_dispatch`

Allows you to trigger the workflow **manually** from the GitHub UI. This is great for workflows you only want to run on demand.

``` yaml
on:
  workflow_dispatch:
```

Once this is configured, a “Run workflow” button appears on the Actions tab. You can even add **inputs** — parameters you can set when triggering the workflow:

``` yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Deployment target'
        required: true
        default: 'staging'
        type: choice
        options:
          - staging
          - production
```

### `schedule`

Triggers the workflow at a scheduled time using **cron syntax**. This is useful for periodic checks (e.g., running a spellchecker every Monday morning).

``` yaml
on:
  schedule:
    - cron: '0 6 * * 1'   # Every Monday at 6:00 AM UTC
```

Cron syntax can look cryptic at first. Here’s a quick reference:

     ┌───────── minute (0-59)
     │ ┌───────── hour (0-23)
     │ │ ┌───────── day of month (1-31)
     │ │ │ ┌───────── month (1-12)
     │ │ │ │ ┌───────── day of week (0-6, Sunday=0)
     │ │ │ │ │
     * * * * *

Some common examples:

| Cron expression | Meaning                     |
|-----------------|-----------------------------|
| `0 6 * * 1`     | Every Monday at 6:00 AM UTC |
| `0 0 * * *`     | Daily at midnight UTC       |
| `0 */6 * * *`   | Every 6 hours               |
| `30 8 * * 1-5`  | Weekdays at 8:30 AM UTC     |

> **Tip:** You can use a site like [crontab.guru](https://crontab.guru/) to build and check cron expressions interactively.

### Combining events

You can list multiple events, and the workflow will trigger when *any* of them occur:

``` yaml
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  workflow_dispatch:
  schedule:
    - cron: '0 6 * * 1'
```

------------------------------------------------------------------------

## Our primary use cases at the OSC

Now let’s look at how we actually use GitHub Actions in our organization. These are the workflows you’re most likely to encounter, maintain, or create as a member of the OSC.

### 1. Restoring R packages with renv

Many of our projects use R, and we manage package dependencies with **renv**. When a workflow runs on a GitHub runner, it starts with a clean environment — no R packages installed. So the first thing we need to do is restore the project’s R packages.

We use the `r-lib/actions/setup-renv` action, which:

1.  Installs R (if not already installed via `setup-r`).
2.  Reads the `renv.lock` file to determine which packages are needed.
3.  Installs them from the R package repository (CRAN).
4.  Caches the installed packages so that subsequent runs are faster.

The typical pattern looks like this:

``` yaml
- name: Set up R
  uses: r-lib/actions/setup-r@v2

- name: Restore renv packages
  uses: r-lib/actions/setup-renv@v2
```

This is usually one of the first steps in any R-related workflow. Without it, subsequent steps that try to use R packages would fail.

> **Note:** Keep your `renv.lock` file in sync with your project’s dependencies. If you add a new package with `renv::install()`, run `renv::snapshot()` to update the lockfile, and commit the changes. Otherwise, the workflow will try to restore an outdated package set.

### 2. Quarto website deployment

Several of our projects are **Quarto websites** (including this manual). When changes are pushed to `main`, we want the website to be rebuilt and deployed automatically.

Our deployment workflow typically:

1.  Checks out the repository.
2.  Installs Quarto (using an action or the system package manager).
3.  Installs R (if the project uses R-based features like `engines`).
4.  Restores renv packages (if the project depends on R packages).
5.  Runs `quarto render` to build the site.
6.  Deploys the output (often to GitHub Pages).

A simplified version:

``` yaml
name: Deploy Quarto Website

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Quarto
        uses: quarto-dev/quarto-actions/setup@v2

      - name: Set up R
        uses: r-lib/actions/setup-r@v2

      - name: Restore renv packages
        uses: r-lib/actions/setup-renv@v2

      - name: Render and Publish
        uses: quarto-dev/quarto-actions/publish@v2
        with:
          target: gh-pages
```

The `${{ secrets.GITHUB_TOKEN }}` is a special token that GitHub automatically provides to every workflow run. It allows the workflow to push to your repository without you having to create and manage a personal access token.

### 3. Spellcheckers (American English and German)

Our website content is written in both **American English** and **German**. To catch typos before they go live, we run spellchecking workflows—either on pull requests or on a schedule. This is only in use in our main website at current, but will likely be expanded to other repositories in the future.

In short, the workflow we use looks for a folder called `config` in the root of the repository which contains a [README](https://github.com/lmu-osc/lmu-osc.github.io/tree/main/config) file with details that you should absolutely read if you want to understand how the spellcheckers work. There is also a `config/cspell` folder containing files to be ignored (`ignore-paths.yaml`) and several `.txt` files containing words to be excepted from the spellcheck (e.g., technical terms, proper nouns, some British spellings of (proper) nouns, etc.). The workflow uses the [`cspell` action](https://github.com/marketplace/actions/cspell-action) to run the spellcheck and report any issues.

> **TIP:**
>
> **TL;DR**: if the spell checker workflow fails due to supposed misspellings, first check the PR. The “misspelled” word(s) will be flagged. Fix the misspelling or typo if it is indeed a mistake.
>
> If the spelling is correct but just not in the dictionary, add it to the appropriate `.txt` file in `config/cspell/` and commit the change. This will prevent the workflow from flagging that word as a misspelling in the future.

### 4. URL checkers for dead links

Broken links undermine the credibility of our websites. We run **link checker** workflows to scan for dead links and report them. We currently have two different link checker setups:

#### Main website: `lycheeverse/lychee-action`

The [main OSC website](https://github.com/lmu-osc/lmu-osc.github.io) uses [`lycheeverse/lychee-action`](https://github.com/lycheeverse/lychee-action) to scan the Markdown and HTML files in the repository for broken links. It runs on a weekly schedule. For specific details, refer to the documentation in that repository.

Note: the main difference between this link checker and the one used in the tutorial template is that this one is more complex and customizable, allowing us to exclude certain files, folders, and external domains from the check.

#### Tutorial template: `filiph/linkcheck`

The [tutorial template](https://github.com/lmu-osc/tutorial-template) uses a different, simpler link checker built around [`filiph/linkcheck`](https://github.com/filiph/linkcheck). Rather than scanning repository files, this action checks the **live deployed website** — it navigates the published site and reports any broken links it encounters. The workflow can be found at `.github/workflows/link-checker.yml` in the tutorial template repository.

Key characteristics of the tutorial template link checker:

- **Scheduling**: Runs on the first day of every month at midnight (`cron: '0 0 1 * *'`). It can also be triggered manually via `workflow_dispatch`.
- **Scope**: Checks the entire website with no exclusions for specific files, folders, or external domains.
- **Reporting**: If broken links are found, the workflow automatically creates a GitHub issue (labeled `link-checker`) with a detailed report. It will not create duplicate issues if one is already open.
- **Why a simpler approach?**: Tutorials typically have fewer outbound links than the main website, and virtually all links should always be functional (or replaced when a linked site goes down). A straightforward link checker that scans the live site is therefore sufficient — there is no need for complex exclusion patterns or file-level filtering.

> **Note:** Because this checker scans the *live* website, updates pushed shortly before a run might not yet be reflected in the deployed site. That said, the monthly schedule means the checker will naturally catch any broken links soon enough.

### 5. Code formatting with the R styler package

Consistent code style makes our R code easier to read and maintain. The **styler** workflow automatically formats R code according to a standard style guide.

We use the [styler workflow](https://github.com/r-lib/actions/tree/v2-branch/examples#style-package) from the `r-lib/actions` repository.

One difference to note is that the documentation provided above uses:

``` yaml
      - name: Style
        run: styler::style_pkg()
        shell: Rscript {0}
```

However, we are not styling R packages but rather just a directory of files that may or may not be in a package structure. Therefore, we use:

``` yaml
      - name: Style
        run: styler::style_dir()
        shell: Rscript {0}
```

------------------------------------------------------------------------

## Best practices for GitHub Actions

Here are some guidelines to keep your workflows reliable and maintainable.

### Use specific action versions

Always pin actions to a specific version tag (e.g., `@v4`, `@v2`) rather than using `@main` or `@master`. This prevents unexpected changes from breaking your workflows when action maintainers update their code.

``` yaml
# Good --- version is explicit
uses: actions/checkout@v4

# Risky --- could break when the action is updated
uses: actions/checkout@main
```

### Keep workflows focused

Each workflow should do one thing well. If you have a spellchecker and a deployment workflow, keep them in separate files. This makes it easier to:

- See at a glance what automation exists.
- Re-run a single workflow without triggering others.
- Understand failures (a spellcheck failure shouldn’t block deployment).

### Name your steps

Adding `name` to each step makes the workflow log much easier to read, especially when a step fails:

``` yaml
# Good
- name: Install dependencies
  run: npm install

# Less helpful
- run: npm install
```

### Use caching when possible

Some GitHub Actions support caching, which speeds up subsequent runs. The `setup-renv` action caches R packages automatically. For other languages, look for `setup-*` actions that support caching (e.g., `actions/setup-node` with `cache: 'npm'`).

### Don’t store secrets in the workflow file

Never hard-code passwords, tokens, or API keys in your workflow YAML. Use **GitHub Secrets** instead (found under Settings → Secrets and variables → Actions in your repository). Reference them with `${{ secrets.SECRET_NAME }}`.

``` yaml
# Good
- name: Deploy
  run: deploy-script.sh
  env:
    API_TOKEN: ${{ secrets.DEPLOY_TOKEN }}

# Bad --- don't do this
- name: Deploy
  run: deploy-script.sh
  env:
    API_TOKEN: "my-super-secret-token"
```

### Test workflow changes on a branch

If you’re modifying a workflow file or adding a new one, do it on a branch and open a pull request. This way, you can see the workflow run against your changes before they land on `main`. The workflow file itself is part of the repository, so it will be triggered by the PR that introduces it.

------------------------------------------------------------------------

## Security considerations

While GitHub Actions is powerful, it’s important to use it safely:

- **Review actions from the Marketplace**: Anyone can publish an action on the GitHub Marketplace. For critical workflows, prefer actions from well-known publishers (like `actions/`, `r-lib/`, `quarto-dev/`).
- **Limit permissions**: You can set the default `GITHUB_TOKEN` permissions to be as restrictive as possible. In your workflow, use the `permissions` key to grant only what’s needed.
- **Be careful with `pull_request_target`**: This event runs workflows in the context of the target repository (not the PR), giving them access to secrets. *We do not currently have any use cases for this event, and we recommend against using it unless you have a specific need and understand the security implications. We only mention it here because some users might encounter workflow templates using this event.*

------------------------------------------------------------------------

## Self-check

After reading this page, you should be able to answer “yes” to each of these:

Can I explain what GitHub Actions are and why we use them?

Do I understand the difference between a workflow, a job, a step, and an action?

Can I identify where workflow files are stored (`.github/workflows/`)?

Do I know how to find and read a workflow run’s results on the Actions tab?

Can I name at least three events that can trigger a workflow?

Do I know what a runner is and why each run starts from a clean environment?

Can I list the main ways we use GitHub Actions at the OSC (deployment, spellcheck, link checking, R package restoration, code formatting)?

Do I know how to troubleshoot a failed workflow run?

Do I understand why we pin action versions and avoid hard-coding secrets?

If you checked all the boxes, you’re ready to work with—and create—GitHub Actions workflows in our organization!

Back to top
