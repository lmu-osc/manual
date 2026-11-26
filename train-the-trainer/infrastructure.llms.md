# Technical Infrastructure

Code

## The two main repositories

The teaching materials for the Train-the-Trainer program are hosted in two main repositories: [Train-the-Trainer Open Research](https://github.com/lmu-osc/train-the-trainer-open-research) and [Teaching Materials for Novices](https://github.com/lmu-osc/teaching-material-for-novices). Both follow the same structure and are built with Quarto and our tutorial template.

The infrastructure of our tutorial templates in general — the Quarto project structure, the tutorial template, the build process, and the deployment process — is documented in the [Authoring Tutorials](../authoring-tutorials/index.llms.md) section of this manual. That section is the general reference and should be read first. This page only covers what is specific to the Train-the-Trainer project.

## Slide decks in separate repositories

Both websites embed multiple slide decks. The decks are written in Quarto and rendered to three formats: RevealJS, PDF, and PPTX. Originally, all of these slides were contained in the same repository as the website, but we have since moved them to separate repositories, one per deck.

We did this first and foremost because it allows us to include one `CITATION.cff` file in each slide deck repository. This is important for proper citation of the slides, particularly given the GitHub–Zenodo integration pipeline we use for our projects. In addition, the separation allows us to:

- keep the website repository smaller and more manageable,
- allow for easier collaboration on the slides, and
- allow for easier reuse of the slides in other contexts (e.g. in other websites or in other courses).

## Slide deck repositories

The following repositories have been created for the slide decks as of November 26th, 2026, although more should be included in the future:

- [slides-zotero](https://github.com/lmu-osc/slides-zotero)
- [slides-simulations](https://github.com/lmu-osc/slides-simulations)
- [slides-r-part-I](https://github.com/lmu-osc/slides-r-part-I)
- [slides-reproducibility-replicability](https://github.com/lmu-osc/slides-reproducibility-replicability)
- [slides-r-part-II](https://github.com/lmu-osc/slides-r-part-II)
- [slides-git](https://github.com/lmu-osc/slides-git)
- [slides-quarto](https://github.com/lmu-osc/slides-quarto)
- [slides-github](https://github.com/lmu-osc/slides-github)
- [slides-core-didactic-principles](https://github.com/lmu-osc/slides-core-didactic-principles)

## Structure of a slide deck repository

All of the slide deck repositories share the same structure. This means maintainers can move from one deck to another without having to re-learn the layout, and that an update to the shared infrastructure can be applied in the same way everywhere.

| File or folder | Purpose |
|:---|:---|
| `index.qmd` | The slide deck itself, written as a single document. Its YAML header lists the three render formats (see below) and sets deck-specific options. |
| `_quarto.yml` | Minimal Quarto project definition (`project: type: website`). Almost all project and format settings come from the `tutorial-template` extension instead of being set here. |
| `_extensions/` | The embedded [`tutorial-template`](https://github.com/lmu-osc/tutorial-template) extension, including its embedded `osc-brand` extension, plus any deck-specific extensions used in the slides (e.g. `timer`, `tabset`). |
| `assets/` | Deck-specific styling (`slides-custom.css`), the bibliography (`references.bib`) and citation style (`apa.csl`), logos, and supplementary files used in the slides. |
| `images/` | Figures used in the slides. |
| `CITATION.cff` | Citation metadata for the deck (authors, ORCID, title, version, DOI). This must be updated for every deck, since it is one of the main reasons for the separate repositories. |
| `LICENSE.md`, `LICENSE-CODE.md` | The same licenses as in our other projects: CC BY-SA 4.0 for the content and CC0 1.0 for the code. |
| `README.md` | Short boilerplate text describing the repository and linking to the published version of the deck. |
| `.github/workflows/` | GitHub Actions that publish the deck to GitHub Pages on every push to `main`, and that run the same checks as our other repositories: validation of `CITATION.cff`, filename checks, a monthly link checker, code styling, and the automatic extension updates described below. |
| `.gitignore`, `.filenameignore` | Standard ignore files, copied from our other repositories. |

The three output formats are declared in the YAML header of `index.qmd`. A typical header looks like this:

``` yaml
format: 
  osc-brand-html: default
  revealjs:
    css: assets/slides-custom.css
    output-file: slides-git-revealjs.html
  pdf:
    output-file: slides-git.pdf
  osc-brand-pptx:
    output-file: slides-git.pptx
```

Each format has an explicit `output-file` name, so that the plain HTML rendering of the deck can keep the default name `index.html` and become the landing page of the published deck at `https://lmu-osc.github.io/slides-*/`. From that page, all three formats are available for download. The PDF and PPTX versions are meant for offline use and for editing: the PPTX output deliberately uses only minimal formatting so that presenters can adapt the slides in PowerPoint.

## Branding with the `osc-brand` extension

All of our projects — the slide decks included — use the [`osc-brand`](https://github.com/lmu-osc/osc-brand) Quarto extension. It keeps the branding of the organization in one place: the LMU colour palette, the OSC logos, the typography (Roboto and Arial, as specified in the LMU brand guide, with Fira Code for code), a branded HTML theme, and a PowerPoint reference document. Because every project draws on the same extension, we do not maintain custom styling in individual repositories, and a deck cannot drift away from the rest of our materials.

The slide deck repositories do not install `osc-brand` directly. The extension is embedded in the `tutorial-template` extension, which is in turn embedded in each repository’s `_extensions/` folder. A new deck therefore gets the branding by installing the tutorial template, without any additional steps.

In practice, this is where the `osc-brand-html` and `osc-brand-pptx` formats in the YAML header come from: they are the branded HTML and PowerPoint formats contributed by the extension. The PPTX format uses the reference document in `_extensions/lmu-osc/osc-brand/powerpoint/working-template.pptx`, which is what makes the PowerPoint output recognizable as an OSC deck.

Because the extensions are embedded rather than installed at render time, updates are automated. A scheduled GitHub Action in [`lmu-osc/osc-brand`](https://github.com/lmu-osc/osc-brand) refreshes the copy embedded in `tutorial-template`, and a second scheduled Action in each downstream repository runs `quarto update lmu-osc/tutorial-template`. Branding changes are therefore made once in `osc-brand` and reach all projects without anyone editing the individual repositories. Changes to brand colours, fonts, or logos are an organization-level decision and should be raised in the `osc-brand` or `tutorial-template` repository rather than made locally in a single deck.

Back to top
