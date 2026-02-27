# Upstream-Safe Workflow for Your Resume Fork

This repository can stay connected to Awesome-CV updates without modifying the original upstream repository.

## 1) Remote setup

```bash
# Check current remotes
git remote -v

# Add upstream (official Awesome-CV) once
git remote add upstream https://github.com/posquit0/Awesome-CV.git
```

- `origin`: your fork (you can push here)
- `upstream`: original Awesome-CV (pull updates from here, never push)

## 2) Branch model

- Keep your long-lived branch for resume work, e.g. `resume-main`.
- Optionally keep `upstream-sync` to integrate upstream updates before merging into `resume-main`.
- Use short-lived feature branches for specific edits (e.g. `feat/resume-fr-copy`).

## 3) Regular sync routine

```bash
# From your working branch
git fetch upstream
git checkout resume-main
git merge upstream/master
```

If your fork uses `main` instead of `master` upstream, replace accordingly.

## 4) Conflict minimization tips

- Keep custom files in `examples/resume_custom/` and custom entrypoints (`examples/resume_*_*.tex`).
- Avoid editing upstream sample files unless necessary.
- Commit often and keep commits focused (structure vs content).

## 5) Build your custom resumes

```bash
make resumes-docker
```

Generated PDFs are written to `build/`.