# Editing Other Pages

Detailed instructions for updating important page types such as [Members](../updating-website/create-new-members-page.llms.md), [Events](../updating-website/create-event-page.llms.md), and [News](../updating-website/create-news-item.llms.md) are already provided. This section provides general guidance for editing all other pages on the OSC website.

# General Workflow

## Step 1: Follow the GitHub Workflow

Before making any changes to the website, follow the standard GitHub workflow described here:

- [GitHub Working Practices](../github/working-practices.llms.md)

This includes creating an issue, creating a branch, making your changes, and submitting a pull request.

## Step 2: Reuse Existing Design Elements

When editing or creating pages, always try to reuse existing page structures and design elements already present on the website.

For example, if a page already uses:

- buttons,
- accordions,
- cards,
- tabsets,
- callout boxes, or
- other Bootstrap components,

copy and adapt these existing structures rather than creating new ones from scratch.

This ensures:

- a consistent appearance across the website;
- that existing CSS and Bootstrap styling continues to work correctly; and
- that pages follow OSC design standards.

> **TIP:**
>
> When creating a new page, first look for a similar page elsewhere on the website and use it as a template.

## Step 3: Update the YAML Configuration

When creating a new page, remember to update the relevant YAML files as necessary.

Examples include:

- adding the page to `_quarto.yml` navigation menus;
- adding entries to sidebars;
- updating listing pages; or
- modifying other YAML configurations required for the page to appear correctly on the website.

Always preview the website locally after making changes to ensure that the page appears in the correct location and that navigation links work as expected.

Back to top
