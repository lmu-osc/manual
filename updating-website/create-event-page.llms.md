# Create an Event Page

Code

Event pages on the OSC website serve several purposes:

- They advertise upcoming events to the Open Science community.
- They create a permanent archive of past events.
- They provide long-term access to event materials (e.g., recordings, slides, and other resources) that may continue to benefit interested researchers.

You can view all OSC event pages here:

- [OSC Events Page](https://www.osc.lmu.de/events/)

## What’s on the Events Page?

The Events page is divided into two main sections:

- **Upcoming Events**: Events that have not yet taken place. These are displayed at the top of the page.
- **Past Events**: Events whose date is earlier than the current date. Events are automatically moved to this section once they have occurred.

Events are grouped by:

1.  **Year**
2.  **Event category**

## Creating a New Event Item

### Step 1: Create a GitHub Issue

Using the [GitHub workflow](../github/working-practices.llms.md), create an **issue** in the `lmu-osc.github.io` repository (unless Malika has already created one).

Use the following naming convention:

> `Add New Event: <name of event>`

Create a new branch from this issue.

### Step 2: Switch to the New Branch

In your local copy of the repository, switch to the newly created branch.

### Step 3: Locate the Event Template

Navigate to:

``` text
events → events → templates
```

> **Note:** The `_event_template.qmd` file may currently not be located in this folder. Ask Pat about this.

### Step 4: Create a New Event File

Create a copy of the `_event_template.qmd` file.

Fill in the template using the details of the event.

### Step 5: Rename the File

Rename the newly created `.qmd` file using the following format:

``` text
YYYY-MM-DD-event-name.qmd
```

For example:

``` text
2026-09-07-open-science-summer-school.qmd
```

## Detailed Instructions

Detailed instructions for creating new event pages using the `_event_template.qmd` file can be found in the README located in the first `events` folder.

Alternatively, you can access the README directly here:

- [New Event README](https://github.com/lmu-osc/lmu-osc.github.io/tree/main/events)

## Event Categories

Choose the category that best describes the event.

| Category | Description |
|----|----|
| **Conference** | Large academic or professional gatherings focused on a specific theme where researchers, practitioners, or organizations present work, share ideas, and network. |
| **Discussion** | Informal or semi-structured conversations centered around a specific Open Science topic, issue, or challenge. Includes panel discussions, roundtables, and community conversations. |
| **Event** | General category for activities that do not fit clearly into another category, such as networking events, launches, celebrations, or public engagement activities (e.g., Love Data Week). |
| **Hackathon** | Collaborative, project-based events where participants work intensively over a short period to solve problems, build tools, or develop ideas related to Open Science or research infrastructure. |
| **Hacky Hour** | Informal coding or troubleshooting sessions where participants work on technical challenges, share solutions, and collaborate in a relaxed setting. Sessions are typically organized around a specific topic or tool. |
| **Lecture** | Formal presentations delivered by a speaker or expert to share knowledge on a specific topic. These events are generally presentation-focused rather than interactive. |
| **OSIM Meetup** | Events specifically organized for the Open Science Initiative Munich (OSIM) community, including networking and collaborative gatherings. |
| **ReproducibiliTea Journal Club** | Journal club sessions following the ReproducibiliTea format, where participants discuss research papers and topics related to reproducibility, transparency, and Open Science. |
| **Summer School** | Multi-day training events designed to provide participants with structured learning experiences, workshops, and practical skill development. This category is typically reserved for the annual Open Science Summer School. |
| **Symposium** | Academic events that bring together multiple speakers or presentations centered around a shared research theme. |
| **Workshop** | Interactive, hands-on training sessions in which participants actively develop skills, complete activities, or engage with practical tools and methods. |

> **NOTE:**
>
> Typical hackathon activities may include:
>
> - Learning how to install a BitTorrent client to seed and safeguard critical research datasets
> - Scraping at-risk datasets
> - Repurposing old hardware into data rescue nodes
> - Improving documentation
> - Developing one-click installation scripts to simplify deployment

Back to top
