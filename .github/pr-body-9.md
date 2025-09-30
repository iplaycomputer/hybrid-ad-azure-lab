# Summary

Add a CI check to enforce use of the repository PR template by validating required sections are present in each PR description.

## Changes

- Scripts:
  - [ ] New/updated PowerShell (list files)
- Docs:
  - [ ] New/updated lab pages
  - [ ] README/Overview changes
- Infra:
  - [ ] Terraform or other infra updates
- Tooling/CI:
  - [x] New workflow `.github/workflows/pr-template-check.yml` to validate PR bodies

## Labs affected (if any)

- [ ] `docs/labs/ex1-ad-setup.md#validation`
- [ ] `docs/labs/02-azure-ad-connect.md#validate-initial-sync`
- [ ] `docs/labs/03-verify-sync.md#test-sign-in`
- N/A (CI-only change)

## Testing & validation

- Environment
  - [x] Verified workflow triggers on PR opened/edited/synchronize
- Docs
  - [x] Markdownlint unaffected

## Checklist

- [x] No credentials, personal IPs, or tenant IDs committed
- [x] README unchanged
- [x] `docs/labs/master.json` not applicable
- [x] Aligned with repo scope (tooling/CI hygiene)

## Screenshots / logs (optional)

N/A

## How to verify (for reviewers)

- Open a test PR and remove one required section heading from its description; the check should fail with a missing section list.
- Restore the section and confirm the check passes.

## Backout plan

- Revert this PR (removes the workflow).
