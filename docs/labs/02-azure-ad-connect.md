# Exercise 1: Azure AD Connect (PHS)

Objective: Configure Azure AD Connect with Password Hash Synchronization (PHS) to establish hybrid identity.

Estimated time: 25–40 minutes

Prereqs

- On‑prem AD domain is deployed (e.g., lab.local)
- Domain user objects exist for testing
- Azure tenant global admin account available

## Prepare UPNs (routable suffix)

1. In on‑prem AD: add a routable UPN suffix (e.g., `labdomain.com`) via Active Directory Domains and Trusts.
2. Update target users to use the routable UPN suffix.
3. In Microsoft 365 admin center: add/verify the custom domain and complete DNS verification.

## Install Azure AD Connect (on the DC)

1. Download Azure AD Connect from Microsoft.
2. Run the installer, accept defaults for Express settings if suitable for lab.
3. Choose Sign‑in method: Password hash synchronization (PHS).
4. Provide tenant global admin credentials when prompted.
5. Optional: Scope synchronization to specific OUs (e.g., `OU=LabUsers`).
6. Complete the wizard and start the initial sync.

## Validate initial sync

1. In M365/Azure AD portal, confirm test users appear.
2. Sign in to [portal.office.com](https://portal.office.com) with a test user UPN and verify success.
3. If sign‑in fails, wait a few minutes and re‑try; check sync status in Azure AD Connect Health if available.

## Troubleshooting

- Users not syncing: verify UPN suffix is routable and matches verified domain.
- Duplicates/conflicts: run Microsoft IdFix against on‑prem AD and remediate.
- Password not matching: allow time for PHS to propagate; ensure the sync cycle completed.
