# Exercise 1: On-Prem AD Setup

## Objective

Promote a server to a domain controller and create initial OUs, groups, and users.

## Automated setup (recommended)

Prereqs:

- Run in an elevated Windows PowerShell on the target server.
- Ensure a static IP and correct DNS settings.

Steps:

1. From the repo root, copy the script to the server if needed, then on the server run:
   - `scripts\new-ad-forest.ps1` (prompts for DSRM password)
   - Optional: `scripts\sample-setup.ps1` to create OUs, groups, users, and a sample share.
2. The server will reboot during promotion. Log in as `LAB\\Administrator` (or your domain NETBIOS name).

## Manual setup (alternative)

1. Open Server Manager → Add Roles and Features
2. Select Active Directory Domain Services (AD DS) and install
3. Promote server to Domain Controller → new forest (e.g., lab.local)
4. Reboot and log in as lab\\Administrator
5. Create OUs, groups, and users in ADUC

## Validation

- Run `dsa.msc` and verify objects exist
