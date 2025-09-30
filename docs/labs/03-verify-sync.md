# Exercise 2: Verify Sync & Sign-in

Objective: Validate Azure AD Connect synchronization and confirm cloud sign-in works for a test user.

Estimated time: 10–15 minutes

Prereqs

- Azure AD Connect (PHS) configured
- Test user synced to Azure AD (cloud username = routable UPN)

## Check sync status

1. On the DC, open Synchronization Service Manager (if installed) or Azure AD Connect.
2. Confirm the last sync completed successfully.

## Verify user in Azure

1. In Entra admin center, navigate to Users and locate the test user.
2. Confirm Source is “Windows Server AD” and the UPN matches the routable domain.

## Test sign-in

1. Browse to [portal.office.com](https://portal.office.com)
2. Sign in with the test user UPN and password.
3. Confirm access to the landing page (or see conditional prompts as configured).

## Troubleshooting

- User missing: wait 5–10 minutes and run a delta sync; verify OU scoping.
- Wrong UPN: fix on-prem `userPrincipalName`, wait for sync, and retry.
- Password mismatch: wait for PHS propagation; consider a password reset in on-prem AD and re‑test.
