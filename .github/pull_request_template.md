# Summary

Briefly describe what this PR adds or changes for the Hybrid AD / Azure AD lab (keep scope lean to hybrid identity).

## Changes

- Scripts:
  - [ ] New/updated PowerShell (list files)
- Docs:
  - [ ] New/updated lab pages (list files)
  - [ ] README/Overview changes
- Infra:
  - [ ] Terraform or other infra updates
- Tooling/CI:
  - [ ] Linting/workflows/editor configs

## Labs affected (if any)

Link to the impacted lab pages and relevant anchors:

- [ ] `docs/labs/ex1-ad-setup.md#validation`
- [ ] `docs/labs/02-azure-ad-connect.md#validate-initial-sync`
- [ ] `docs/labs/03-verify-sync.md#test-sign-in`

## Testing & validation

- Environment
  - [ ] Tested on Windows Server (version: ___)
  - [ ] Elevated PowerShell session used when required
- Scripts
  - [ ] Ran `scripts/tools/parse-check.ps1` on changed .ps1 files
  - [ ] No hardcoded secrets; secure prompts used where applicable
  - [ ] For DC promotion changes: validated reboot + domain login
- Docs
  - [ ] Markdownlint passes locally (and CI expected to pass)
  - [ ] Relative links and anchors resolve in repo preview
  - [ ] No bare URLs / hard tabs; uses code fencing where appropriate

## Checklist

- [ ] No credentials, personal IPs, or tenant IDs committed (use placeholders like `<vm-ip>`, `<tenant-name>`)
- [ ] README updated if new docs/scripts were added
- [ ] `docs/labs/master.json` updated if pages were added/removed from the flow
- [ ] Changes align with lab scope (hybrid identity core); advanced topics remain optional

## Screenshots / logs (optional)

Add images or transcript snippets if helpful for reviewers.

## How to verify (for reviewers)

- Click the lab links above and confirm anchors jump to the correct sections.
- If scripts changed, run the relevant Verification steps in the lab(s) and confirm expected outcomes.
- Confirm CI markdownlint status is green.

## Backout plan

- Revert this PR. No persistent cloud-side changes are made unless scripts are explicitly executed by the user.
