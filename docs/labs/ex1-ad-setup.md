# Exercise 1: On-Prem AD Setup

## Objective

Promote a server to a domain controller and create initial OUs, groups, and users.

## Steps

1. Open Server Manager → Add Roles and Features
2. Select Active Directory Domain Services (AD DS) and install
3. Promote server to Domain Controller → new forest (e.g., lab.local)
4. Reboot and log in as lab\\Administrator
5. Create OUs, groups, and users in ADUC

## Validation

- Run `dsa.msc` and verify objects exist
