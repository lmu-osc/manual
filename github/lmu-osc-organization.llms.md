# The LMU OSC GitHub Organization

Code

How we use GitHub for collaboration, hosting our code and content, and management

## Overview

A **GitHub Organization** is a shared workspace where multiple people can collaborate on repositories under a single umbrella. Unlike a personal account, an organization allows you to group repositories, manage permissions with teams, and centralise billing and settings. Our organization lives at [github.com/lmu-osc](https://github.com/lmu-osc) and is where we host all of our code, content, and documentation.

This page covers what you need to know about navigating our organization, how permissions work, and how to manage members and teams.

------------------------------------------------------------------------

## What is a GitHub Organization?

If you’re new to GitHub Organizations, think of it as a **shared account** that multiple people can belong to. With a personal account, you own your repositories personally — if you leave a project or change roles, those repos can be tricky to transfer. With an organization, the repos belong to the group, not to any one person. This means:

- **Continuity** — Repositories aren’t lost when someone leaves the group. The organization remains the owner.
- **Scalable permissions** — Instead of adding people to repos one by one, you can create teams with predefined permissions and simply add or remove people from those teams.
- **Discoverability** — The organization provides a single place (github.com/lmu-osc) where anyone can find all our projects.

### A quick comparison

|  | Personal account | Organization |
|----|----|----|
| Ownership | Belongs to one person | Belongs to the group |
| Repositories | Under your name | Under the org name |
| Permissions | Simple (collaborator or not) | Granular (teams, roles, base permissions) |
| Best for | Individual projects, personal work | Collaborative projects, teams |

### What you’ll see at github.com/lmu-osc

When you visit [github.com/lmu-osc](https://github.com/lmu-osc), you’ll see:

- **Pinned repositories** — A few key repos highlighted at the top (like this manual). These are our most important or most active projects.
- **Organization README** — A short description of who we are, pulled from the `.github` repository.
- **Tabs** — Repositories, Packages, and People are the main ones you’ll use. The Repositories tab lists everything we have (public ones are visible to everyone; private ones only if you have access).

------------------------------------------------------------------------

## Repositories

Our organization contains a mix of **public** and **private** repositories.

- **Public repositories** are visible to anyone on the internet. All of our content repositories (like this manual, our tutorials, and public-facing websites) are public. This aligns with our commitment to open science — anyone can view, clone, and learn from our work.
- **Private repositories** are only visible to members of the organization who have been granted access. We use private repositories mainly for internal tools, drafts of projects not yet ready for public release, or configurations that contain sensitive information.

> **Tip:** If you see a repository name in a discussion or issue but can’t find it, it might be private and you may not have been granted access yet. Ask a team member to add you if you need it.

### Finding repositories

You can browse all repositories by clicking the **“Repositories” tab** on the organization’s GitHub page. From there you can:

- Scroll through the list of all public repositories.
- Use the **search bar** at the top of the page to filter by repository name, description, or topic tags.
- Sort by last updated, name, or number of stars.

You can also **star** repositories you work on frequently — they’ll be saved under your personal “Starred” tab for quick access later. This is especially useful if you regularly contribute to several different repos.

If you’re looking for something specific and can’t find it, ask a team member — it may be in a private repository that you don’t yet have access to, or it may be stored elsewhere.

------------------------------------------------------------------------

## Organization features

GitHub provides several features at the organization level. Here’s how we use (and don’t use) them at the OSC.

### Teams

Teams are the primary way we manage permissions. Instead of adding people to individual repositories one by one, you can create a team, give that team a set of permissions across all repos (or specific ones), and then add or remove members from the team. This makes it easy to see who has access to what and to onboard or offboard people quickly.

#### How team permissions work

When you add someone to a team, they automatically get the team’s permission level on all repositories the team has been granted access to. GitHub offers several permission levels, but the main ones you’ll encounter are:

| Level | Can… |
|----|----|
| **Read** | View and clone repositories, open issues, leave comments |
| **Write** | All of the above, plus push changes, manage issues and pull requests |
| **Admin** | All of the above, plus manage repository settings, add collaborators, configure CI/CD |
| **Owner** | Full control over the entire organization (billing, settings, all repos) |

#### Our current teams

| Team Name | Who’s in it | What they can do |
|----|----|----|
| `osc-admin-members` | Full-time staff | Admin access to all repos, including managing CI/CD workflows and repository settings |
| `osc-research-assistants` | Student research assistants (HiWis) | Admin access to all repos |

Both teams currently have **Admin**-level access to all repositories. If you’re on either team, you can push to any branch, merge pull requests, and change repository settings.

#### Creating a new team

If you need a new team for a specific project or group of people, feel free to create one. Before doing so, check the [organization role management settings](https://github.com/organizations/lmu-osc/settings/org_roles) to understand what permission levels are available and appropriate. As a rule of thumb:

- **Start with Read or Write** unless there’s a clear need for Admin.
- It’s easier to **escalate permissions later** than to roll them back after an accident.
- Consider the **principle of least privilege**: give people the minimum access they need to do their work.

We want to avoid giving out Admin permissions unnecessarily, but we also don’t want to micromanage permissions to the point where it becomes a burden. Use your judgement, and when in doubt, ask another team member.

#### Practical example: onboarding a new HiWi

When a new student research assistant joins, here’s roughly what happens:

1.  They’re invited to join the organization (see “Adding new members” below).
2.  They’re added to the `osc-research-assistants` team.
3.  They automatically get Admin access to all repositories.
4.  When they leave, they’re removed from the team (and optionally the organization), and their access is revoked everywhere at once.

### Adding people to individual repositories

Sometimes you need to give someone access to just **one repository** without making them a full member of the organization. This is common when we contract with someone for a specific piece of work — for example, a freelance designer working on a website template.

**How to do it:**

1.  Go to the repository on GitHub.
2.  Click **Settings** (in the right sidebar).
3.  Click **Collaborators and teams** in the left menu.
4.  Under “Manage access”, click **Add people**.
5.  Search by username, full name, or email, choose their permission level (Read, Write, or Admin), and send the invite.

**When to use this approach:**

- ✅ The person only needs access to **one repo**.
- ✅ It’s a **short-term or one-off** collaboration.
- ❌ Avoid if you find yourself doing this repeatedly for the same person — in that case, create a team instead.

> **Why teams are usually better:** If you give five people access to three different repos each via individual invitations, you now have fifteen separate permissions to track and manually revoke. With teams, you add each person to one team and give that team access to the relevant repos — much cleaner.

### Discussions

GitHub Discussions is a feature for having **forum-style conversations** that aren’t tied to a specific issue or pull request. It’s useful for Q&A, brainstorming, announcements, or general community engagement.

We haven’t actively adopted Discussions yet at the OSC, but they remain available if we ever need them. For now, we rely on **Issues** for tracking tasks and bugs, and **pull requests** for proposing and reviewing changes. If you think a topic would benefit from a discussion thread (e.g., a design proposal that doesn’t have a clear actionable issue yet), feel free to start one.

### Projects

GitHub Projects provides a **Kanban-style board** for organizing and tracking work across issues and pull requests. We experimented with it for a period but found it didn’t fit our workflow well, so we don’t use it formally at the organization level.

That said, you’re **welcome to create your own project board** if you find it useful for tracking your work. For example, you could:

- Create a personal board to keep track of issues you’re responsible for across multiple repositories.
- Set up a board for a specific event or project with a fixed timeline.
- Use it as a lightweight to-do list for a short-term initiative.

To create one, go to the organization’s **Projects** tab and click “New project”. Just keep in mind that this is for your personal productivity — there’s no expectation that others will use or maintain it.

------------------------------------------------------------------------

## Membership and permissions

Understanding how membership works is important for both new and existing members. Here are the main membership types and how they relate to each other.

### Membership types

- **Member**: A normal organization member. Members belong to the organization, appear in the member list, and count toward any license seats for GitHub Team/Enterprise.
- **Owner**: A member with full control over the organization. Owners can manage members and teams, change organization-wide settings, and access all repositories. We generally reserve owner access for full-time staff.
- **Outside Collaborator**: Not a member of the organization. Outside collaborators can be granted access to specific repositories only, and they do not appear in the org member list.

### How members are different from outside collaborators

| Aspect | Members | Outside collaborators |
|----|----|----|
| Belong to the organization | Yes | No |
| Appear in organization member list | Yes | No |
| Can be added to teams | Yes | No |
| Access management | Usually via teams and org roles | Direct repository-level access only |
| Can access multiple repos through teams | Yes | No |
| Count toward license seats (GitHub Team/Enterprise) | Usually yes | Depends on plan and permissions |
| Visibility into organization | More organizational visibility | Limited to assigned repositories |
| Best for | Employees, long-term contributors | Contractors, vendors, external partners |

### Base member permissions

Base permissions are the default access level for **all members** of the organization. Ours are set to **Read**, which means every member can:

- ✅ View and clone repositories.
- ✅ Open issues and leave comments.
- ❌ **Cannot** push changes to repositories.
- ❌ **Cannot** manage issues or pull requests on repositories they haven’t been explicitly granted access to.

This is a sensible default: it lets people access the content they need without giving them unnecessary control over repositories they’re not actively working on.

### Teams and elevated permissions

Teams are the primary way we give members additional permissions across one or more repositories.

- Members can have their base permissions elevated by being added to a team.
- The best way to manage permissions is usually with teams, not one repository at a time.
- Teams let you grant the same access level to a group of people and then manage that access from one place.

#### Our current team structure

| Team Name | Who’s in it | What they can do |
|----|----|----|
| `osc-admin-members` | Full-time staff | Admin access to all repos, including managing CI/CD workflows and repository settings |
| `osc-research-assistants` | Student research assistants (HiWis) | Admin access to all repos |
| `osc-trusted-members` | Non-staff OSC members | Maintenance access to all repos |

> Note: The `osc-admin-members` team is currently used by full-time staff. In the future, we may want to keep the number of actual Owners small and give staff their repo permissions via a team instead.

The `osc-trusted-members` team is used for non-staff and non-HiWi OSC members who should have maintenance access to all of our repositories. Maintenance is a step down from admin, but in practice it is often sufficient for reviewing code, managing issues, and coordinating releases.

#### Practical example: onboarding a new HiWi

When a new student research assistant joins, here’s roughly what happens:

1.  They’re invited to join the organization (see “Adding new members” below).
2.  They’re added to the `osc-research-assistants` team.
3.  They automatically get Admin access to the repositories that team covers.
4.  When they leave, they’re removed from the team (and optionally the organization), and their access is revoked everywhere at once.

### Adding new members

The most common management task is inviting new people to the organization. Here’s how to do it step by step:

1.  Go to the organization’s **People** tab (visible only to members with sufficient permissions).
2.  Click the green **Invite Member** button.
3.  Search by **GitHub username**, **full name**, or **email address**.
    - Username is the quickest way if you know it.
    - Email works too, but make sure it matches the email they use on GitHub.
4.  Choose whether to add them to a team right away (recommended) or just add them to the organization directly.
    - Adding to a team means they’ll automatically get that team’s permissions.
    - Adding them directly means they’ll only have base permissions (Read).
5.  The invite will expire after a few days if not accepted. You can resend it if needed.

> **What if I can’t invite someone?** You need to have Owner permissions or be a team maintainer with the right privileges to invite new members. If you don’t see the option, ask an owner to do it.

### Adding outside collaborators to a repository

If someone only needs access to one repository and should not be an organization member, grant them access as an outside collaborator.

**How to do it:**

1.  Go to the repository on GitHub.
2.  Click **Settings** (in the right sidebar).
3.  Click **Collaborators and teams** in the left menu.
4.  Under “Manage access”, click **Add people**.
5.  Search by username, full name, or email, choose their permission level (Read, Write, or Admin), and send the invite.

**When to use this approach:**

- ✅ The person only needs access to **one repo**.
- ✅ It’s a **short-term or one-off** collaboration.
- ❌ Avoid if you find yourself doing this repeatedly for the same person — in that case, add them as a member instead, and consider adding them to the `osc-trusted-members` team or creating a new team with the necessary permissions.

> **Why teams are usually better:** If you give five people access to three different repos each via individual invitations, you now have fifteen separate permissions to track and manually revoke. With teams, you add each person to one team and give that team access to the relevant repos — much cleaner.

### Member visibility

By default, new members are listed as **Private** — their membership is not visible to the public. This means no one outside the organization can see they’re a member.

**We ask members to make themselves Public** so that: - Other team members can easily find them. - External collaborators and the community can see who is part of the OSC. - It’s easier for people to know who to contact about specific projects.

Making your membership public is entirely optional. If you’d like to do it:

1.  Go to your [organization membership page](https://github.com/settings/organizations).
2.  Find the lmu-osc entry and change the visibility from **Private** to **Public**.

GitHub also provides [official documentation on this setting](https://docs.github.com/en/account-and-profile/how-tos/organization-membership/publicizing-or-hiding-organization-membership).

### Organization owners

Above regular members and teams are **organization owners**. Owners have full control over the organization, including:

- Managing members and teams.
- Changing organization-wide settings (e.g., base permissions, 2FA requirements).
- Accessing and managing all repositories, including private ones.
- Deleting the organization (use with caution!).

**Who gets owner access:** We generally grant owner permissions only to **full-time staff members**, not to student research assistants or other collaborators. We may further restrict this in the future for security purposes.

> **Why this matters:** If you ever need something done that requires owner-level access (creating a new team, changing org-wide settings, adding a new owner), ask one of the full-time staff members. Normal team admins cannot do these things.

You can review and adjust base permissions at any time in the [organization’s member privileges settings](https://github.com/organizations/lmu-osc/settings/member_privileges).

------------------------------------------------------------------------

## Security: two-factor authentication (2FA)

We are in the process of **requiring two-factor authentication (2FA)** for all members of the organization. This is an important security practice: even if someone’s password is compromised, a second factor (like a code from your phone) prevents unauthorized access to our repositories and code.

### What you need to do

- **If you already have 2FA enabled** on your GitHub account, you’re all set. You should be able to access the organization without any issues.
- **If you don’t have 2FA enabled**, you’ll need to set it up before you can access the organization. GitHub provides a step-by-step [guide on configuring 2FA](https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa/configuring-two-factor-authentication).

### Which 2FA method to choose

GitHub offers several options. Here’s what we recommend:

| Method | Recommendation | How it works |
|----|----|----|
| **TOTP app** (e.g. Duo, Google Authenticator, Authy, 1Password, Microsoft Authenticator) | ✅ **Recommended** | You scan a QR code with your phone or password manager, and it generates a 6-digit code that changes every 30 seconds. |
| **GitHub Mobile app** | ✅ **Recommended** | You can use the GitHub Mobile app as a second factor. It sends a push notification to your phone for approval. |
| **Passkeys** (biometric or device-based) | ✅ Good option | Uses your device’s fingerprint, face recognition, or PIN. Works well if your device supports it. |
| **SMS text message** | ❌ **Not recommended** | Codes sent via SMS can be intercepted. GitHub itself [advises against it](https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa/configuring-two-factor-authentication). |
| **Security keys** (hardware, e.g., YubiKey) | ✅ Good for extra security | Physical key that you plug in or tap. More expensive but very secure. |

### Setting up a TOTP app

If you’re new to 2FA, a TOTP app is the easiest place to start:

1.  Install an authenticator app on your phone (Google Authenticator, Authy, or 1Password all work well).
2.  Go to your [GitHub security settings](https://github.com/settings/security).
3.  Click “Enable two-factor authentication” and follow the prompts to scan the QR code with your app.
4.  Save your recovery codes somewhere safe (you’ll need them if you lose access to your phone).

> **Tip:** When you set up 2FA, GitHub gives you a set of **recovery codes**. Save these somewhere secure (e.g., in your password manager). If you ever lose your phone, these codes are the only way to get back into your account.

------------------------------------------------------------------------

## Quick reference

### Key links

| Resource | Link |
|----|----|
| OSC GitHub Organization | [github.com/lmu-osc](https://github.com/lmu-osc) |
| Organization role management | [Settings → Org Roles](https://github.com/organizations/lmu-osc/settings/org_roles) |
| Member privileges settings | [Settings → Member Privileges](https://github.com/organizations/lmu-osc/settings/member_privileges) |
| Your organization memberships | [github.com/settings/organizations](https://github.com/settings/organizations) |
| 2FA setup guide | [GitHub Docs](https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa/configuring-two-factor-authentication) |
| Publicising organization membership | [GitHub Docs](https://docs.github.com/en/account-and-profile/how-tos/organization-membership/publicizing-or-hiding-organization-membership) |

### Who to ask for help

If you run into any of the following, here’s who to contact:

| Situation | Who to ask |
|----|----|
| I need to be added to the organization | Any full-time staff member (an organization owner) |
| I can’t access a specific repository | Ask the team that maintains it, or a staff member |
| I need a new team created | An organization owner |
| I’m having trouble with 2FA | Check the [GitHub docs](https://docs.github.com/en/authentication/securing-your-account-with-two-factor-authentication-2fa) or ask a staff member |
| I’m not sure where a project lives | Check the organization’s Repositories tab, or ask in the relevant Slack/Matrix channel |

Back to top
