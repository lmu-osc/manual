# Repositories

Code

How we create and manage repositories in the organization, and who can access them

Every repository at [github.com/lmu-osc](https://github.com/lmu-osc) belongs to the organization rather than to whoever created it, which is what lets us manage access in groups and keep work going when people move on. This page is about **managing** repositories — creating them, controlling access, and retiring them. For what we have and what each repository is for, see [Our Repositories](../../github/our-repositories.llms.md).

## Public or private

- **Public** — visible to anyone on the internet. All of our content repositories (this manual, our tutorials, our public-facing websites) are public, in line with our commitment to open science: anyone can view, clone, and learn from them.
- **Private** — visible to members and to any outside collaborators we add, but not to the public. We use these for internal tools, drafts not yet ready for release, and configurations that contain sensitive information.

Prefer public where you reasonably can: a private repository is easy to forget about. Work that shouldn’t live in the shared organization — internal server administration, for example — goes to our organization on the **LRZ GitLab** instance instead: see [LRZ GitLab](../../lrz-gitlab/index.llms.md). [Setting repository visibility](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/managing-repository-settings/setting-repository-visibility) explains how to change it.

------------------------------------------------------------------------

## Who has access to what

Access comes from one of three places: the organization’s **base permission**, **teams**, or **direct access to a single repository**.

| Who | Role | Where |
|----|----|----|
| Staff (`osc-admin-members`) and HiWis (`osc-research-assistants`) | **Admin** | All repositories |
| `osc-trusted-members` | **Maintain** | All repositories |
| Outside collaborators we add | Usually **Write** | The one repository they were added to |
| Every other member | **Read** (base permission) | All repositories |

Base **Read** is what every member has on every repository without being added to anything: clone and read, open issues, and contribute through forks, but not push — see [Base member permissions](../../github/lmu-osc-organization/membership-and-permissions.llms.md#base-member-permissions).

**Teams** are the normal way to give someone more: adding someone to a team gives them that team’s role on every repository it can access, which is what makes offboarding a single action. **Direct access** is for one-off or narrowly scoped work, including outside collaborators who aren’t members — add them from the repository’s **Settings → Collaborators and teams**, which needs **Admin** on that repository. If you’re adding the same person repeatedly, make them a member instead.

Two rules: **grant the lowest role that lets the person work**, and **prefer teams over per-repository access**. See [Teams](../../github/lmu-osc-organization/organization-features.llms.md#teams) for what each role can do, and [Membership and Permissions](../../github/lmu-osc-organization/membership-and-permissions.llms.md) for who may invite people, create teams, or change settings.

> **Read the GitHub docs:** [Repository roles for an organization](https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories/managing-repository-roles/repository-roles-for-an-organization).

------------------------------------------------------------------------

## Creating a repository

Create it in the organization rather than a personal account, so it inherits our access rules and survives staff changes — work that started in a personal account can be transferred in later. Start from a template where one fits (tutorials always start from [`tutorial-template`](https://github.com/lmu-osc/tutorial-template)), and follow our conventions: a kebab-case name, a `README.md`, a `LICENSE`, and a short description with topic tags. See [Working Practices](../../github/working-practices.llms.md).

------------------------------------------------------------------------

## Looking after a repository

- **Renaming** changes the repository’s URL: GitHub redirects the old paths, but local clones and links elsewhere won’t follow. **Transferring** it to a new owner means checking everything that referenced it — clones, deployment secrets, topics, access.
- **Archiving** is how we retire a repository: read-only, no new issues or pull requests, but everything stays visible and citable. Add a note to the README explaining why — see [Working Practices](../../github/working-practices.llms.md).
- **Deleting** is permanent, so archive instead unless the content genuinely shouldn’t exist, and agree it with a staff member first.
- **Backups** run monthly, for disaster recovery rather than browsing old versions. Issue templates, pull request templates, and `CONTRIBUTING` come from [`.github`](https://github.com/lmu-osc/.github) unless a repository defines its own. See [Our Repositories](../../github/our-repositories.llms.md#backup-and-archival).

> **Read the GitHub docs:** [Renaming](https://docs.github.com/en/repositories/creating-and-managing-repositories/renaming-a-repository), [transferring](https://docs.github.com/en/repositories/creating-and-managing-repositories/transferring-a-repository), [archiving](https://docs.github.com/en/repositories/archiving-a-github-repository/archiving-repositories), and [deleting](https://docs.github.com/en/repositories/creating-and-managing-repositories/deleting-a-repository) repositories.

------------------------------------------------------------------------

## Finding repositories

Browse the **Repositories** tab and filter by name, description, or topic; star anything you work on regularly. [Searching for repositories](https://docs.github.com/en/search-github/searching-on-github/searching-for-repositories) covers the search syntax. If you can’t find something, ask a staff member — it may be private, or it may be on LRZ GitLab.

Back to top
