# Adding a New Institutional Member

Code

An institutional member of the OSC is a research unit, department, collaborative project, or other organization affiliated with the LMU that formally partners with and supports the OSC in promoting Open Science practices within its community.

You can view institutional members here:

- [Institutional Members Page](https://www.osc.lmu.de/partners/institutional-members.html)

Institutional members can belong to one of two categories:

- Funding Institutional Members
- Affiliate Institutional Members

**Institutional members are managed differently from individual members.**

## Step 1: Obtain the Information

Malika will provide:

- the institutional member’s information;
- a statement describing the institution and its motivation for joining the OSC; and
- any relevant links, contacts, or images.

## Step 2: Open the Appropriate File

Navigate to:

``` text
partners
```

Then edit one of the following files:

- `affiliate-institutional-members.qmd`
- `funding-institutional-members.qmd`

Choose the file corresponding to the type of institutional membership.

## Step 3: Add the New Institutional Member

Add the new institution to the existing YAML list using the following format:

``` yaml
- name: "Faculty of Business Administration - Munich School of Management"
  image_url: "images/som.png"
  contact:
    - name: "Prof. Dr. Ralf Elsas"
      link: "/people/people/ralf-elsas.qmd"
  website_url: "https://www.som.lmu.de/en/"
  description: |
    The LMU Munich School of Management is committed to advancing the principles of open science and research transparency. By becoming an institutional member of the LMU's Open Science Center, we aim to foster a culture of openness, collaboration, and integrity in our research community. We believe that promoting open access to data, methodologies, and findings will enhance the quality and reproducibility of research in business studies, ultimately contributing to innovative and impactful solutions for global business challenges.
```

> **WARNING:**
>
> When editing institutional members, ensure that you remain within the YAML block enclosed by the green `---` lines.
>
> Do **not** add content below the closing `---`, as this may break the page.
