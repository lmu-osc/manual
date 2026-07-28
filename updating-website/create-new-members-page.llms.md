# Create a New Member’s Profile Page

Code

Member profile pages are used to introduce members of the LMU Open Science Center and provide information about their research interests, expertise, and contact details.

# Individual Members

You can view all individual member profiles here:

- [OSC Members Page](https://www.osc.lmu.de/people/members.html)

**How Will You Know When to Add a New Member?**

Malika will typically send you an email containing all the information required to create the member profile.

If any information is missing, notify Malika. She will either obtain the missing information from the new member or provide further instructions. Typically, Profs provide the minimum information (i.e. their statement) and we find all the other information on their LMU page (e.g. picture, website link, ect.)

# Creating a New Individual Member Profile

## Step 1: Create a GitHub Issue

Following our classic [GitHub workflow](../github/working-practices.llms.md), create an **issue** in the `lmu-osc.github.io` repository (unless Malika has already created one and linked it in your to do table).

Use the following naming convention:

> `Add New Member: <firstname lastname>`

Create a new branch from this issue.

## Step 2: Switch to the New Branch

In your local copy of the repository, switch to the newly created branch.

## Step 3: Locate the Member Template

Navigate to:

``` text
people → people → templates
```

## Step 4: Create a New Member File

Create a copy of the `_people_template.qmd` file.

Complete the template using the information provided by the new member.

## Step 5: Rename the File

Rename the newly created `.qmd` file using the following format:

``` text
firstname-lastname.qmd
```

For example:

``` text
malika-ihle.qmd
```

# Adding the Member’s Profile Picture

Each member profile should include a profile picture unless they specified they didn’t want to share one. Use either:

- the picture provided by the member during their application; or
- the profile picture from the official LMU website
- the profile picture of their main professional website

Do not use profile pictures from any other sources without their consent.

## Adding the Image

1.  Navigate to:

``` text
people → people → images
```

2.  Add the image to this folder.

3.  Rename the image file using the following format:

``` text
lastname-firstname
```

For example:

``` text
ihle-malika.jpg
```

> **NOTE:**
>
> The `_people_template.qmd` file contains a designated field where the path to the profile picture should be specified.
>
> Make sure that the filename and path exactly match the image stored in the `images` folder.

# Detailed Instructions

Detailed instructions for creating member profile pages using the `_people_template.qmd` file can be found in the README located in the first `people` folder.

Alternatively, you can access the README directly here:

- [New Member README](https://github.com/lmu-osc/lmu-osc.github.io/tree/main/people)

Back to top
