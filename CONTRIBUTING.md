# Contributing

Thanks for your interest in contributing to this Hybrid AD / Azure AD / O365 lab. This project uses pull requests to keep `main` stable and visible. Please follow the process below.

## Pull request process

- Fork or create a topic branch from `main`.
- Keep changes focused and small; one logical change per PR.
- Use the repository PR template (auto-included when you open a PR) and complete all required sections.
- Ensure required checks are passing before requesting merge.
- Squash-merge is the preferred merge strategy; the repository enforces a linear history.

## Required checks

These must be green on each PR:

- markdownlint: Lints all Markdown files using markdownlint-cli2.
- PR template check: Verifies the PR body contains all required sections.

## Local verification

Run these locally before pushing to reduce CI churn.

### Markdown

```powershell
# From the repo root
npm ci
npm run lint:md
```

### PowerShell syntax (scripts/)

```powershell
# Syntax check all scripts
Get-ChildItem -Path scripts -Filter *.ps1 -Recurse | ForEach-Object { ./scripts/tools/parse-check.ps1 -Path $_.FullName }

# Or check a single file
./scripts/tools/parse-check.ps1 -Path ./scripts/sample-setup.ps1
```

## Commit messages

- Use concise, conventional prefixes when helpful (e.g., docs:, chore:, feat:, fix:).
- Examples:
  - `docs(readme): add CI badges`
  - `chore(tools): improve parse-check error message`

## Scope and guardrails

- Focus on hybrid identity core first; advanced or adjacent topics can be proposed as optional extensions.
- No credentials, personal IPs, or tenant IDs should be committed. Use placeholders like `<tenant-name>`, `<vm-ip>`.

## Questions

Open an issue with your proposal or question, or start a draft PR if you prefer code to discuss.
