# Main Website Deployment

Technical details of how we deploy our main website using GitHub, Quarto, and Webhooks

This page describes the automated deployment pipeline for the [main OSC website](https://lmu-osc.github.io/) (repository: [lmu-osc/lmu-osc.github.io](https://github.com/lmu-osc/lmu-osc.github.io)). When changes are pushed to the `main` branch, the site is automatically rendered and deployed to two destinations: **GitHub Pages** (for the `lmu-osc.github.io` address) and our **production server** at the LMU web address. This page covers how both paths work, from commit to live site.

**Note: the webhook receiver should run in perpetuity without needing maintenance. If you are here because the production site is not updating, please follow the troubleshooting steps at the end of this page before attempting any changes.**

------------------------------------------------------------------------

## Overview

The deployment pipeline consists of three main stages:

1.  **A GitHub Actions workflow** triggered by pushes to `main` (and weekly on a schedule). This workflow renders the Quarto site using two different profiles and publishes the output to two branches.
2.  **GitHub Pages** serves the `gh-pages` branch automatically — no further action needed.
3.  **A webhook receiver** running on our LRZ server listens for pushes to the `prod-pages` branch and updates the live production site.

&nbsp;

    ┌──────────────┐    ┌──────────────────────┐    ┌───────────────────┐
    │  Push to     │───▶│  GitHub Actions      │───▶│  gh-pages branch  │───▶ GitHub Pages
    │  main branch │    │  (Render & Publish)  │    │                   │    (automatic)
    └──────────────┘    │                      │    └───────────────────┘
                        │  Two parallel jobs:  │
                        │  • github profile    │    ┌───────────────────┐
                        │  • production profile│───▶│  prod-pages branch│───▶ Webhook
                        └──────────────────────┘    └───────────────────┘      │
                                                                               ▼
                                                                        ┌───────────────────┐
                                                                        │  Webhook Receiver │
                                                                        │  (LRZ server)     │
                                                                        │  git fetch + reset│
                                                                        └───────────────────┘
                                                                                │
                                                                                ▼
                                                                        ┌──────────────────┐
                                                                        │  Production site │
                                                                        │  (LMU web addr.) │
                                                                        └──────────────────┘

------------------------------------------------------------------------

## Trigger: what starts the pipeline

The workflow runs automatically whenever code is pushed to the `main` branch of [lmu-osc/lmu-osc.github.io](https://github.com/lmu-osc/lmu-osc.github.io). It also runs on a weekly schedule (Sundays at 11 PM UTC) to pick up any changes from dependencies, and can be triggered manually via the GitHub Actions UI (`workflow_dispatch`).

------------------------------------------------------------------------

## The GitHub Actions workflow

The workflow file lives at `.github/workflows/publish.yml` in the website repository. It defines two independent jobs that run in parallel.

### Job 1: Build for GitHub Pages (`build-github`)

This job renders the site with the `github` Quarto profile and publishes the output to the `gh-pages` branch using the standard `quarto-dev/quarto-actions/publish` action. GitHub Pages is configured to serve from this branch, so the site becomes available at `https://lmu-osc.github.io/` as soon as the action completes.

The `github` profile ensures that links, the sitemap, and other absolute URLs are generated with the GitHub Pages address (`https://lmu-osc.github.io/`).

### Job 2: Build for production (`build-production`)

This job renders the site with the `production` Quarto profile. Instead of using the `publish` action, it uses `quarto-dev/quarto-actions/render` to produce the static site in `_site/`, then deploys the output to the `prod-pages` branch.

The `production` profile generates absolute URLs pointing to the LMU production address (e.g., `https://www.osc.lmu.de/...`). This is critical so that the sitemap, RSS feeds, social media previews, and all internal links reference the correct domain.

> **Why two profiles?** Quarto needs to know the site URL at render time to generate correct absolute links. Since the site is served at two different addresses (GitHub Pages and the LMU production server), we use two Quarto profiles — one for each URL. Each profile is defined in `_quarto.yml` with its own `url` setting.

------------------------------------------------------------------------

## GitHub Pages deployment

The `gh-pages` branch is served automatically by GitHub Pages. No additional infrastructure is needed — GitHub handles the web server, TLS certificate, and CDN. This is the fastest path from merge to live (typically a few minutes) and is useful as a preview or fallback address.

------------------------------------------------------------------------

## Production server deployment (via webhooks)

Deploying to the LMU production server (`www.osc.lmu.de`) requires an additional step because the server is hosted on LRZ infrastructure, not on GitHub. This is handled by a **GitHub webhook** and a small **Go application** called the [webhook-receiver](https://github.com/lmu-osc/webhook-receiver).

### What is a webhook?

A webhook is an HTTP callback — a message that GitHub sends to a URL when a specific event occurs. In our case, GitHub sends a POST request to our webhook receiver every time a push is made to the `prod-pages` branch. The webhook receiver then pulls the updated content and places it in the correct directory on the server.

### The webhook-receiver application

The [webhook-receiver](https://github.com/lmu-osc/webhook-receiver) is a Go application that runs in a Docker container on our LRZ server. It does the following:

1.  **Listens** for POST requests at the `/lmu-osc-site` endpoint.
2.  **Verifies** the request signature using a shared secret (HMAC-SHA256) to ensure the request genuinely came from GitHub.
3.  **Checks** that the event is a `push` to the `refs/heads/prod-pages` ref. If not, it ignores the request.
4.  **Ensures** the repository is cloned locally — if no local copy exists yet, it clones `lmu-osc/lmu-osc.github.io` and checks out the `prod-pages` branch.
5.  **Updates** the local copy by running `git fetch --prune origin prod-pages` followed by `git reset --hard FETCH_HEAD` and `git clean -fd`, which brings the working tree exactly in sync with the remote branch.
6.  **Responds** to GitHub immediately (so the webhook delivery is marked as successful), while the update runs asynchronously.

Key design features:

- **Concurrency safety**: If multiple webhook events arrive in quick succession, they are coalesced — only one update runs at a time, with a single additional run queued if events arrive during an active update.
- **Idempotent**: The receiver simply ensures the local working tree matches the remote branch. Running it multiple times has the same effect as running it once.
- **Lightweight**: The Docker image is based on Alpine Linux and is built from a multi-stage Go build, resulting in a small footprint.

### How the webhook is configured

The webhook is configured in the GitHub repository settings (Settings → Webhooks). The configuration includes:

- **Payload URL**: `https://our-server.example.com/lmu-osc-site`
- **Content type**: `application/json`
- **Secret**: A long random string shared between GitHub and the webhook receiver (set as `WEBHOOK_SECRET` in the receiver’s environment)
- **Events**: “Just the push event” (we only need to react to pushes)

The receiver is routed through Nginx on the server, which terminates TLS and proxies requests to the Docker container on `127.0.0.1:8080`.

### How the production site files are served

The Docker container mounts a host directory (configured via the `REPO_DIR` environment variable, typically `/var/www/your-site`) into the container at `/app/repo`. The webhook receiver keeps this directory updated with the contents of the `prod-pages` branch. The Nginx (or Apache) web server on the host serves this directory as the live website.

This means the production site is essentially a static file server pointing at a Git working tree that is kept in sync with the `prod-pages` branch.

------------------------------------------------------------------------

## The complete flow, step by step

1.  A contributor merges a pull request into `main` on [lmu-osc/lmu-osc.github.io](https://github.com/lmu-osc/lmu-osc.github.io).
2.  The **GitHub Actions workflow** (`publish.yml`) starts automatically.
3.  The `build-github` job renders the site with the `github` profile and publishes to `gh-pages`. GitHub Pages serves the result at `https://lmu-osc.github.io/`.
4.  Concurrently, the `build-production` job renders the site with the `production` profile and pushes the output to `prod-pages`.
5.  GitHub sends a **webhook POST** to the webhook receiver on the LRZ server, notifying it of the push to `prod-pages`.
6.  The **webhook receiver** verifies the signature, fetches the latest `prod-pages` branch, and updates the local working tree.
7.  The web server on the LRZ host serves the updated files at the LMU production address.

Steps 5 and 6 typically complete within seconds of the workflow finishing. In total, both the GitHub Pages and production versions of the site are updated within a few minutes of a merge.

------------------------------------------------------------------------

## Troubleshooting and maintenance

### If the production site is not updating

1.  **Check the workflow run**: Go to the [Actions tab](https://github.com/lmu-osc/lmu-osc.github.io/actions) of the website repository and verify that the “Render and Publish Site” workflow completed successfully. If it failed, the `prod-pages` branch was not updated, so no webhook was sent.
2.  **Check the webhook receiver logs**: On the LRZ server, run `docker compose logs --tail=200 webhook-receiver` in the webhook-receiver directory to see recent activity. Look for error messages.
3.  **Check webhook deliveries**: In the GitHub repository, go to Settings → Webhooks → your webhook → Recent Deliveries. This shows every webhook request GitHub sent and the response. A `200` response means the receiver accepted it; a `4xx` or `5xx` means something went wrong.

### Common issues

| Symptom | Likely cause |
|----|----|
| Webhook delivery shows `401` | `WEBHOOK_SECRET` in the receiver’s `.env` does not match the secret configured in GitHub. Regenerate and update both. |
| Webhook delivery shows `200` but site hasn’t changed | The webhook event may have been for a different branch or event type. Check the receiver logs for “Webhook received and ignored” messages. |
| `prod-pages` branch is ahead of the local copy | The receiver may have been down during a previous deployment. Either wait for the next push to `main` (which will trigger another update) or manually trigger the workflow via `workflow_dispatch`. |
| The receiver cannot clone or pull | Verify that `REPO_URL` is correct and that the server has network access to GitHub. The repository is public, so no authentication is needed for read access. |
| Files on the server are out of sync | Run `docker compose exec webhook-receiver ls -la /app/repo` to inspect the current state. Compare with the `prod-pages` branch on GitHub. |

### Updating the webhook receiver

When the webhook-receiver code itself is updated (e.g., a new feature or bug fix), pull the latest changes on the server and rebuild the container:

``` bash
git pull
docker compose up -d --build
```

## The Webhook is Broken and I Have No Idea Why or What to Do

If you made it here, then I am sorry and my recommendation would be to start from scratch (unless you happen to know Go and can debug the webhook-receiver code). The steps to start from scratch are:

1.  Stop the webhook-receiver container: `cd /path/to/webhook-receiver && docker compose down`
2.  Copy the secret from the `.env` file to a safe place, as you will need to reconfigure the webhook in GitHub with the same secret. Alternatively, you can generate a new secret and update both the `.env` file and the GitHub webhook configuration, but using the same secret is simpler.
3.  Remove the existing local repository copy: `rm -rf /path/to/repo`
4.  Start an entirely new project, likely using Python.
5.  Configure the new webhook receiver to listen for the same events and use the same secret.
6.  Set-up the project to listen for pushes to the `prod-pages` branch and update the local copy of the repository accordingly.
7.  To avoid having to make any sort of Nginx changes too, you can have the new webhook receiver listen on the same port, `8080`, as was used before. This way, the Nginx configuration can remain unchanged, and you can simply replace the old webhook receiver with the new one.

Back to top
