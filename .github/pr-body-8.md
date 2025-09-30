# Summary

Remove platform-specific (CloudLabs) references to keep documentation provider-agnostic and focused on the repo itself.

## Changes

- Scripts:
  - [ ] New/updated PowerShell (list files)
- Docs:
  - [x] Generalized credentials note in `docs/labs/environment.md`
  - [x] Removed CloudLabs reviewer checklist from `.github/pull_request_template.md`
- Infra:
  - [ ] Terraform or other infra updates
- Tooling/CI:
  - [ ] Linting/workflows/editor configs

## Labs affected (if any)

- [ ] `docs/labs/ex1-ad-setup.md#validation`
- [ ] `docs/labs/02-azure-ad-connect.md#validate-initial-sync`
- [ ] `docs/labs/03-verify-sync.md#test-sign-in`
- N/A for this PR (docs template and environment note only)

## Testing & validation

- Environment
  - [x] Tested via local repo preview
- Docs
  - [x] Markdownlint passes locally (npm run lint:md)
  - [x] Relative links/anchors unaffected by this change

## Checklist

- [x] No credentials, personal IPs, or tenant IDs committed (use placeholders like `<vm-ip>`, `<tenant-name>`)
- [x] README unchanged (no new docs/scripts added that require updates)
- [x] `docs/labs/master.json` updated if pages were added/removed (N/A)
- [x] Changes align with lab scope (hybrid identity docs hygiene)

## Screenshots / logs (optional)

N/A

## How to verify (for reviewers)

- Open the modified files above; confirm phrasing is provider-agnostic
- Run `npm run lint:md`; expect 0 errors

## Backout plan

- Revert this PR (docs-only)
