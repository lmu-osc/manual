# Onboarding a New OSC Member

Code

After a new member has been accepted to the OSC, several administrative tasks must be completed to fully onboard them.

The onboarding process goes beyond creating the member’s profile page on the website and ensures that the member is integrated into OSC records, communication channels, and bibliometric tracking systems.

# Onboarding Checklist

After accepting a new member, complete the following tasks:

Update the Member Management sheet.

Add the member to the Members Publications (Bibliometrics) sheet.

Add the member to the appropriate mailing lists.

Create a profile page on the OSC website.

# How to Onboard a New Member?

Click through the following tabs to read the details and instructions involved in each item of the checklist:

## Updating the Member Management Sheet

Here is the Google Sheet used to collect and store the information on each OSC member:

- [Member Management Sheet](https://docs.google.com/spreadsheets/d/1dKGtEoSAh0xFkoDdnFUXjjz8ZgFzNSCIsR3q2imuXek/edit?usp=sharing)

To add to the spreadsheet, follow these steps:

1.  Select the appropriate worksheet:

    - **OSC-Mitglieder** for LMU and associated members.
    - **Fellows** for OSC fellows.

2.  Insert a new row in alphabetical order according to the member’s last name.

3.  Enter information in columns **A–C**.

4.  Copy the formula in **column D** from the member directly above by dragging the cell down.

5.  Complete the remaining columns using the information provided in the onboarding email.

### Past Members

When a member leaves the OSC:

1.  Remove their entry from the **OSC-Mitglieder** sheet.

2.  Add the member to the **Past Members** sheet.

> **IMPORTANT:**
>
> Take note of all newly added members in the OSC assistants document under the **Newsletter** section.
>
> “New Members & Fellows” is a recurring category in the OSC Newsletter.

## Updating the Members Publications (Bibliometrics) Sheet

Here is the Google Sheet used to collect and store publications information of each OSC member:

- [Members Publications Sheet](https://docs.google.com/spreadsheets/d/15vXf-iksan44LKMagVAWdcBNnGMtmhk4/edit?gid=293446652#gid=293446652)

To add the bibliometrics of a new member, follow these steps:

1.  Check whether the member already exists by searching the sheet for the member’s last name. A member is considered to already exist in the system if at least one of their entries has a **1** in both of the first two columns. If the member is already present, simply add any additional OpenAlex IDs if necessary. If the member is not present, continue with the next step.

2.  Find the OpenAlex Author ID on the [OpenAlex website](https://openalex.org/). Search for the person by name, affiliation, publications, or research field. In the search results, click the person’s name and then select **Author profile**. The URL of the profile page corresponds to the OpenAlex author ID.

Example:

``` text
https://openalex.org/authors/A5061123357
```

> **TIP:**
>
> 1.  Open `01b-Add_members.R`.
> 2.  Modify the search string.
> 3.  Run the script.
> 4.  Inspect the results object to identify the correct OpenAlex author ID.

3.  Add the information to the OSC Author List. Add one row for **each valid OpenAlex ID**.

The following cells must be updated:

| Column | Information                       |
|--------|-----------------------------------|
| A      | Enter `1`                         |
| B      | Enter `1`                         |
| C      | Enter the `osc_id`                |
| E      | Enter the OpenAlex ID             |
| G      | Enter the official `display_name` |

### Creating the `osc_id`

The `osc_id` must:

- be unique for each OSC member;
- remain consistent across all entries for that member.

General rule:

- Use the member’s last name only.
- If multiple members share the same last name, append the first initial.

Examples:

``` text
Schulz
SchulzC
SchulzE
```

### Formatting the OpenAlex ID

Use the following format:

``` text
https://openalex.org/A5061123357
```

**Important:** The ID must:

- contain a capital **A**;
- not contain `/authors/`.

Example:

``` text
https://openalex.org/A5061123357
```

### Special Cases

#### If the Person Already Exists

Simply add the new OpenAlex ID.

Example:

``` text
1 | 1 | lastname | lastname firstname | OpenAlex ID | firstname lastname
```

## Adding the Member to Mailing Lists

Add the new member to all relevant OSC mailing lists.

The exact mailing lists and access procedures should be obtained from Malika.

## Creating a Profile Page on the OSC Website

A profile page should be created for every new member.

For detailed instructions, see:

- [Creating a New Member Profile Page](../updating-website/create-new-members-page.qmd)
