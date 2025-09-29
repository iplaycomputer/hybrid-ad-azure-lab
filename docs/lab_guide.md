# Hybrid AD & Azure Lab Guide

**Version:** 1.0

**Last Updated:** September 15, 2025

## Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Objectives](#objectives)
4. [Environment Setup](#environment-setup)
5. [Configuration Steps](#configuration-steps)
6. [Validation](#validation)
7. [Troubleshooting](#troubleshooting)
8. [References](#references)

## Overview

This guide walks through building a hybrid lab environment that integrates on-premises Active Directory with Azure AD and Microsoft 365. The goal is to provide hands-on experience with hybrid identity, cloud sync, and enterprise management tools.

## Prerequisites

- Physical or virtual lab hardware (sufficient RAM/CPU for at least 2 Windows Server VMs and 1 Windows client VM)
- Internet access for Azure and O365 setup
- Microsoft 365 trial tenant
- Windows Server 2019/2022 ISO (evaluation)
- Windows 10/11 ISO (evaluation)
- Basic networking (DHCP or static IPs, domain connectivity)
- Admin privileges for all installs

## Objectives

By the end of this lab, you will:

1. Deploy and configure on-premises Active Directory
2. Integrate Azure AD and Microsoft 365
3. Set up file shares and NTFS permissions
4. Test hybrid identity and group policy scenarios
5. Deploy applications and validate cloud sync

## Environment Setup

> Tip: Use snapshots or checkpoints for VMs before major changes.

### Domain Controller VM

1. Create VM:
   - Recommended specs: 2 vCPU, 8GB RAM, 60GB disk
   - Name: `LAB-DC`
2. Install Windows Server:
   - Use Windows Server 2019/2022 ISO
   - Complete initial setup and install all updates
3. Assign Static IP:
   - Example: `192.168.1.10`
   - Set DNS to `127.0.0.1`
4. Rename Computer:
   - Set hostname to `LAB-DC`
5. Prepare for AD DS Role:
   - Ensure network connectivity
   - Verify time sync with internet or NTP

### Client VM

1. Create VM:
   - Recommended specs: 2 vCPU, 4GB RAM, 40GB disk
   - Name: `LAB-CLIENT`
2. Install Windows 10/11:
   - Use evaluation ISO
   - Complete initial setup and install all updates
3. Configure Networking:
   - Assign IP via DHCP or static (e.g., `192.168.1.20`)
   - Set DNS to point to Domain Controller (`192.168.1.10`)
4. Rename Computer:
   - Set hostname to `LAB-CLIENT`
5. Prepare for Domain Join:
   - Verify network connectivity to DC
   - Confirm time sync

## Configuration Steps

### 1. Microsoft 365 Tenant Setup

- Sign up for a Microsoft 365 tenant (trial).
- Create a global admin (example: `admin@mytest.onmicrosoft.com`).
- Log in at [admin.microsoft.com](https://admin.microsoft.com) → Admin dashboard.
- Under Users:
  - Add users.
  - Assign licenses (E3 trial).
  - Create groups and assign users.

### 2. Azure Setup

- Go to [portal.azure.com](https://portal.azure.com).
- Log in with tenant global admin.
- Access Azure Active Directory (Entra ID).

### 3. Lab VM Setup

- Create a VM.
- Mount Windows Server 2019/2022 ISO (evaluation).
- Install Windows Server.
- Log in as local Administrator.
- You will add AD role later.

> Note: You’ll also need a Windows 10/11 client VM for testing domain join and GPOs.

### 4. On-Prem Active Directory Setup

On the Windows Server VM:

1. Open Server Manager → Add Roles and Features.
2. Select Active Directory Domain Services (AD DS).
   - Installs DNS automatically.
   - Accept feature defaults (GPMC included with AD DS).
3. Install the role.
4. Promote server to Domain Controller → new forest/domain (e.g., `lab.local`).
5. Reboot → log in as `lab\Administrator`.
6. Use Active Directory Users and Computers (ADUC) to create OUs, groups, and users.

### 5. Client VM Join

On the Windows 10/11 client VM:

- Open System Properties → Rename this PC → Domain = `lab.local`.
- Enter domain admin credentials.
- Reboot.
- Verify in ADUC: computer object appears under Computers.

### 6. Group Policy Test

- On the DC, open Group Policy Management.
- Create new GPO (e.g., Force Chrome Homepage).
- Link GPO to target OU.
- On client VM:
  - Log in as domain user.
  - Run `gpupdate /force`.
  - Verify policy applied.

### 7. UPN Suffixes

- On-prem AD users default to `user@lab.local`.
- Azure AD/O365 requires routable domains.
- Fix:
  1. In Active Directory Domains and Trusts → Properties → UPN Suffixes, add `labdomain.com`.
  2. Assign suffix to users in ADUC.
  3. Verify domain in O365 tenant (Admin Center → Settings → Domains → Add domain → TXT DNS record).

### 8. Domain Prep

- Ensure valid `userPrincipalName` attributes.
- Remove duplicate SMTP/UPN values.
- Clean up unused or disabled accounts.
- Optionally run IdFix tool to catch errors.

### 9. Azure AD Connect

- Install Azure AD Connect on Domain Controller VM.
- Run wizard:
  - Enter tenant global admin credentials.
  - Select OUs/users to sync.

After sync:

- Accounts appear in O365 with same usernames/passwords.

### 10. File Shares + NTFS Permissions

- On DC or member server: create `D:\Share`.
- Right-click → Share → assign “Domain Users” or AD group.
- Adjust NTFS permissions (read/write).
- On client VM: map drive (e.g., `\\DC\Share`).
- Verify access permissions.

### 11. SCCM / MECM App Deployment

1. Spin up another Windows Server VM → join it to domain (`lab.local`).
2. Assign a static IP.
3. Install prerequisites:
   - SQL Server (Express for lab).
   - IIS, .NET Framework, BITS, WSUS.
4. Install SCCM (MECM):
   - Download evaluation copy.
   - Run installer → choose Primary Site.
   - Configure site code, database, and distribution point.
5. Configure boundaries and collections:
   - Define IP range of lab network.
   - Add client VM to a collection (e.g., All Lab Computers).
6. Add an application (example: Chrome `.msi`):
   - Detection method: confirm install status.
   - Install command:
     msiexec /i googlechromestandaloneenterprise.msi /quiet
   - Deploy to client collection.
     - Required = installs automatically.
     - Available = user installs via Software Center.
7. Test deployment:
   - On client VM → open Software Center.
   - Chrome installs silently (if Required).

### 12. DFS (Namespaces + Replication) (Optional but valuable)

#### Goal

- Provide users with a single logical UNC path (e.g., `\\lab.local\Shares`) that stays available if a file server goes down.
- Replicate data between servers for redundancy.

#### Prerequisites (DFS)

- At least two servers with storage (DC + member server or two members).
- Both joined to the domain.
- Each has local folder (e.g., `D:\Finance`).

#### 12.1 DFS Namespaces

- On both servers: Add DFS Namespaces role.
- Run `dfsmgmt.msc`.
- Create Domain-based Namespace (requires AD):
  - Example: `\\lab.local\Shares`.
- Add folders:
  - `\\FS1\Finance`
  - `\\FS2\Finance`

#### 12.2 DFS Replication

- Add DFS Replication role.
- In `dfsmgmt.msc` → Replication → New Replication Group.
- Members: FS1, FS2.
- Topology: Full mesh.
- Schedule: Full (lab) or restricted.
- Primary member: server with current data.
- Add replicated folders (e.g., `D:\Finance`).

#### 12.3 Map and Test

- On client VM: map `\\lab.local\Shares\Finance`.
- Verify referral to FS1 or FS2.
- Test replication: add file on FS1 → appears on FS2.
- Test failover: stop sharing on FS1 → access continues via FS2.

## Validation

- Verify domain join and user login.
- Confirm group policy application.
- Test file share access and permissions.
- Validate Azure AD sync and Office 365 login.

## Troubleshooting

> Note: See the README for detailed troubleshooting tips.

- Domain Join Issues: Check network, credentials, and UPN suffix.
- O365 Sync Issues: Use IdFix and review AD Connect logs.
- Mapped Drive Issues: Confirm group membership and permissions.
- Group Policy Issues: Use `gpresult /r` and `gpupdate /force`.

## References

- [Microsoft Active Directory Documentation](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview)
- [Azure AD Connect Documentation](https://docs.microsoft.com/en-us/azure/active-directory/hybrid/whatis-azure-ad-connect)
  - Chrome installs silently (if Required).


