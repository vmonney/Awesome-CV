<h1 align="center">
  <a href="https://github.com/posquit0/Awesome-CV" title="AwesomeCV Documentation">
    <img alt="AwesomeCV" src="https://github.com/posquit0/Awesome-CV/raw/master/icon.png" width="200px" height="200px" />
  </a>
  <br />
  Awesome CV
</h1>

<p align="center">
  LaTeX template for your outstanding job application
</p>

<div align="center">
  <a href="https://www.paypal.me/posquit0">
    <img alt="Donate" src="https://img.shields.io/badge/Donate-PayPal-blue.svg" />
  </a>
  <a href="https://github.com/posquit0/Awesome-CV/actions/workflows/main.yml">
    <img alt="GitHub Actions" src="https://github.com/posquit0/Awesome-CV/actions/workflows/main.yml/badge.svg" />
  </a>
  <a href="https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/resume.pdf">
    <img alt="Example Resume" src="https://img.shields.io/badge/resume-pdf-green.svg" />
  </a>
  <a href="https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/cv.pdf">
    <img alt="Example CV" src="https://img.shields.io/badge/cv-pdf-green.svg" />
  </a>
  <a href="https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/coverletter.pdf">
    <img alt="Example Coverletter" src="https://img.shields.io/badge/coverletter-pdf-green.svg" />
  </a>
</div>

<br />

## What is Awesome CV?

**Awesome CV** is LaTeX template for a **CV(Curriculum Vitae)**, **Résumé** or **Cover Letter** inspired by [Fancy CV](https://www.sharelatex.com/templates/cv-or-resume/fancy-cv). It is easy to customize your own template, especially since it is really written by a clean, semantic markup.

## Preview

#### Résumé

You can see [PDF](https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/resume.pdf)

| Page. 1 | Page. 2 |
|:---:|:---:|
| [![Résumé](https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/resume-0.png)](https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/resume.pdf)  | [![Résumé](https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/resume-1.png)](https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/resume.pdf) |

#### Cover Letter

You can see [PDF](https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/coverletter.pdf)

| Without Sections | With Sections |
|:---:|:---:|
| [![Cover Letter(Traditional)](https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/coverletter-0.png)](https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/coverletter.pdf)  | [![Cover Letter(Awesome)](https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/coverletter-1.png)](https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/coverletter.pdf) |


## Quick Start

* [**Edit Résumé on OverLeaf.com**](https://www.overleaf.com/latex/templates/awesome-cv/tvmzpvdjfqxp)
* [**Edit Cover Letter on OverLeaf.com**](https://www.overleaf.com/latex/templates/awesome-cv-cover-letter/pfzzjspkthbk)

**_Note:_ Above services do not guarantee up-to-date source code of Awesome CV**


## How to Use (This Fork)

This fork keeps upstream Awesome-CV examples and adds custom resume variants.

**Important:** Run all commands from the root of the `Awesome-CV` folder.

### Requirements

- Local: XeLaTeX (`xelatex`) installed (TeX Live recommended), or
- Docker: use `texlive/texlive:latest` through the Makefile targets

### Build Commands (current workflow)

```bash
# Upstream-style examples (resume/cv/coverletter)
make examples

# Custom resume variants (Data Engineer / Data Analyst in EN+FR)
make resumes

# Same custom resumes via Docker
make resumes-docker

# Build custom cover letter variant in build/artifacts
make coverletters-docker
```

### Where files are generated

- Build artifacts: `build/artifacts/`
- Deliverables for applications: `build/deliverables/<company>/`
- Cover letter source for applications: `examples/coverletter_custom.tex`
- Upstream cover letter example kept as reference: `examples/coverletter.tex`

### Which CV should I send?

Choose the variant based on role and language:

- `resume_de_en.pdf` -> Data Engineer (English)
- `resume_de_fr.pdf` -> Data Engineer (French)
- `resume_da_en.pdf` -> Data Analyst (English)
- `resume_da_fr.pdf` -> Data Analyst (French)

If unsure, start with:

- technical/data-platform jobs: `resume_de_en.pdf` (or `resume_de_fr.pdf`)
- analytics/BI-focused jobs: `resume_da_en.pdf` (or `resume_da_fr.pdf`)

### Generate CV + cover letter for one company

Use the bundled targets to create a company delivery folder with company-specific filenames.
You can now choose the CV variant with `RESUME_VARIANT`:

- `de_en` (Data Engineer, EN)
- `de_fr` (Data Engineer, FR)
- `da_en` (Data Analyst, EN)
- `da_fr` (Data Analyst, FR)

```bash
# Creates:
# build/deliverables/<COMPANY>/<COMPANY>_resume.pdf
# build/deliverables/<COMPANY>/<COMPANY>_coverletter.pdf
make send-bundle-docker COMPANY=acme RESUME_VARIANT=de_en
```

You can also run each step separately:

```bash
make send-resume-docker COMPANY=acme RESUME_VARIANT=da_fr
make send-coverletter-docker COMPANY=acme
```

To use another cover letter source without changing the Makefile:

```bash
make send-coverletter-docker COMPANY=acme COVERLETTER_SOURCE=examples/my_coverletter.tex
```

### Source layout

- Upstream reference resume: `examples/resume.tex` + `examples/resume/`
- Upstream reference cover letter: `examples/coverletter.tex`
- Custom content: `examples/resume_custom/`
- Custom entry points:
  - `examples/resume_de_en.tex`
  - `examples/resume_de_fr.tex`
  - `examples/resume_da_en.tex`
  - `examples/resume_da_fr.tex`
  - `examples/coverletter_custom.tex`


## Credit

[**LaTeX**](https://www.latex-project.org) is a fantastic typesetting program that a lot of people use these days, especially the math and computer science people in academia.

[**FontAwesome6 LaTeX Package**](https://github.com/braniii/fontawesome) is a LaTeX package that provides access to the [Font Awesome 6](https://fontawesome.com/v6/icons) icon set.

[**Roboto**](https://github.com/google/roboto) is the default font on Android and ChromeOS, and the recommended font for Google’s visual language, Material Design.

[**Source Sans Pro**](https://github.com/adobe-fonts/source-sans-pro) is a set of OpenType fonts that have been designed to work well in user interface (UI) environments.


## Contact

You are free to take my `.tex` file and modify it to create your own resume. Please don't use my resume for anything else without my permission, though!

If you have any questions, feel free to join me at [`#posquit0` on Freenode](irc://irc.freenode.net/posquit0) and ask away. Click [here](https://kiwiirc.com/client/irc.freenode.net/posquit0) to connect.

Good luck!


## Maintainers
- [posquit0](https://github.com/posquit0)
- [OJFord](https://github.com/OJFord)


## See Also

* [Awesome Identity](https://github.com/posquit0/hugo-awesome-identity) - A single-page Hugo theme to introduce yourself.
