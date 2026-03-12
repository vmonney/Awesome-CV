# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal fork of [Awesome-CV](https://github.com/posquit0/Awesome-CV), a LaTeX template for CVs, résumés, and cover letters. It uses the `awesome-cv.cls` document class compiled with **XeLaTeX** (not pdflatex). The main branch for this fork is `resume-main`; `master` tracks upstream.

## Build Commands

All commands run from the repo root:

```bash
# Build the default resume (outputs to build/)
make resume.pdf

# Build all example documents (resume, cv, coverletter)
make examples

# Build all custom resume variants (de/da × en/fr)
make resumes

# Build using Docker (no local TeX installation needed)
make resumes-docker

# Clean build artifacts
make clean
```

For a single file manually:
```bash
cd examples && xelatex resume.tex
```

Output PDFs go to `build/`.

## Architecture

### Document Class
- `awesome-cv.cls` — the core LaTeX class defining all CV environments, commands, and styling. Requires XeLaTeX, fontspec, fontawesome6, Roboto and Source Sans Pro fonts.

### Document Structure
There are two resume systems:

1. **Standard examples** (`examples/resume.tex`, `examples/cv.tex`, `examples/coverletter.tex`):
   - Section files in `examples/resume/` and `examples/cv/` (experience.tex, education.tex, skills.tex, etc.)
   - Each section uses `\cvsection{}` with `\begin{cventries}` containing `\cventry{title}{org}{location}{dates}{description}` blocks

2. **Custom multi-variant resumes** (`examples/resume_custom/`):
   - Tailored résumés for specific job profiles (data engineer `_de`, data analyst `_da`) in multiple languages (`en/`, `fr/`)
   - Shared config in `resume_custom/shared/setup.tex` (geometry, colors) and `resume_custom/shared/profile.tex` (personal info)
   - Entry point files: `examples/resume_de_en.tex`, `resume_da_fr.tex`, etc. — each combines shared setup + profile + language-specific section files
   - Naming convention: `resume_{profile}_{language}.tex`

### Key LaTeX Commands (from awesome-cv.cls)
- `\cventry{job title}{org}{location}{dates}{description}` — main entry block
- `\cvhonor{award}{event/detail}{location}{date}` — honors/awards
- `\cvskill{category}{skills list}` — skills section
- `\begin{cvitems}...\end{cvitems}` — bullet points within an entry
- Header: `\name{}{}`, `\position{}`, `\email{}`, `\mobile{}`, `\github{}`, `\linkedin{}`, etc.
- Available accent colors: awesome-emerald, awesome-skyblue, awesome-red, awesome-pink, awesome-orange, awesome-nephritis, awesome-concrete, awesome-darknight

## Conventions

- Personal info (name, contact) for custom variants lives in `resume_custom/shared/profile.tex`; for the standard resume it's directly in `examples/resume.tex`
- When adding a new job profile variant, create section files under both `en/` and `fr/`, plus a new entry point `resume_{profile}_{lang}.tex`
- The `.gitignore` should exclude `build/` artifacts (*.aux, *.log)
