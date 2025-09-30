<!-- markdownlint-disable-file -->

# Hybrid AD / Azure AD / O365 Lab

![Last Commit](https://img.shields.io/github/last-commit/iplaycomputer/hybrid-ad-azure-lab)
![Open Issues](https://img.shields.io/github/issues/iplaycomputer/hybrid-ad-azure-lab)
![Closed Issues](https://img.shields.io/github/issues-closed/iplaycomputer/hybrid-ad-azure-lab)
![Repo Size](https://img.shields.io/github/repo-size/iplaycomputer/hybrid-ad-azure-lab)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
![Lab Status](https://img.shields.io/badge/lab--status-in_progress-orange)

[![markdownlint](https://img.shields.io/github/actions/workflow/status/iplaycomputer/hybrid-ad-azure-lab/markdownlint.yml?branch=main&label=markdownlint)](https://github.com/iplaycomputer/hybrid-ad-azure-lab/actions/workflows/markdownlint.yml)
[![PR template check](https://img.shields.io/github/actions/workflow/status/iplaycomputer/hybrid-ad-azure-lab/pr-template-check.yml?branch=main&label=PR%20template%20check)](https://github.com/iplaycomputer/hybrid-ad-azure-lab/actions/workflows/pr-template-check.yml)

## Table of Contents

1. [Lab Purpose & Audience](#lab-purpose--audience)
2. [Quick Start](#quick-start)
3. [Architecture Diagram](#architecture-diagram)
4. [Documentation](#documentation)
5. [Features](#features)
6. [Extensions (Planned)](#extensions-planned)
7. [Why This Lab?](#why-this-lab)
8. [Next Steps](#next-steps)
9. [Troubleshooting Tips](#troubleshooting-tips)
10. [Resources](#resources)
11. [Contributing](#contributing)

## Lab Purpose & Audience

This repo documents a homelab for practicing enterprise-scale identity and systems management. It demonstrates integration between on-prem Active Directory, Azure AD, and Microsoft 365.

## Quick Start

1. Review the Hybrid Lab Guide: [docs/lab_guide.md](docs/lab_guide.md)
2. Clone this repo and review the folder structure:
   - infra/ – Terraform for cloud resources
   - scripts/ – PowerShell setup scripts
   - docs/ – Lab guide and documentation
   - diagrams/ – Architecture diagrams
3. Follow the guide to set up:
   - Microsoft 365 tenant
   - Azure AD and on-prem AD
   - Windows Server and client VMs
   - File shares, GPOs, and SCCM

## Architecture Diagram

![Hybrid Architecture](diagrams/hybrid-architecture.png)

## Documentation

📖 [Hybrid Lab Guide](docs/lab_guide.md) – step-by-step instructions to set up the lab.

- [Overview](docs/labs/overview.md)
- [Environment & Access](docs/labs/environment.md)
- [Exercise 1: On‑Prem AD Setup](docs/labs/ex1-ad-setup.md)

## Features

- On-prem Active Directory domain (lab.local) with OUs, groups, and Group Policies
- Azure AD + Microsoft 365 tenant sync via Azure AD Connect
- Windows 10/11 clients joined to the domain
- File shares with NTFS permissions and DFS namespaces/replication
- Application deployment with SCCM (ConfigMgr)
- Azure File Sync to OneDrive
- Office 365 services (Exchange Online, Teams, SharePoint Online) with SSO, MFA, and Conditional Access
- Security overlays: concepts for compliance (HIPAA, PCI), monitoring/logging, and SIEM (Sentinel/Splunk)

## Extensions (Planned)

- Terraform (AWS VPC + EC2) for cloud infrastructure automation
- Ansible for Windows configuration management
- Expanded Terraform to Azure IaaS resources
- Intune app deployment automation
- Splunk/Sentinel SIEM detection queries

## Why This Lab?

To practice:

- Hybrid identity management
- GPO and file share administration
- Application deployment and automation
- Cloud service integration (Office 365 + OneDrive)
- Security monitoring and compliance alignment

## Next Steps

- Expand Terraform to Azure IaaS resources
- Automate Intune app deployment
- Add Splunk/Sentinel SIEM detection queries

## Troubleshooting Tips

- Domain Join Issues: Verify the PC is joined to the domain and the user has the correct UPN suffix.
- O365 Sync Issues: Check if the account actually synced in Azure AD / O365. Run IdFix or review AD Connect sync logs.
- Mapped Drive Issues: Confirm the user is in the correct AD group. Verify NTFS and Share permissions match.
- Group Policy Missing: On the client, run `gpresult /r`. If policies aren’t applying, use `gpupdate /force`.

## Resources

### Group Policy & PowerShell

- [Implement Group Policy Objects – Microsoft Learn](https://learn.microsoft.com/en-us/training/modules/implement-group-policy-objects/)
- [Microsoft PowerShell Learning Paths](https://learn.microsoft.com/en-us/training/paths/powershell/)
  
### Active Directory & Identity

- [Learn Microsoft Active Directory (AD DS) in 30 mins – Andy Malone (YouTube)](https://www.youtube.com/watch?v=85-bp7XxWDQ)
- [How to use IdFix to clean AD objects – LazyAdmin](https://lazyadmin.nl/it/idfix/)

### DNS & Networking

- [Exploring DNS Traffic – ITExamAnswers](https://itexamanswers.net/17-1-7-lab-exploring-dns-traffic-answers.html)

### SCCM / Endpoint Management

- [SCCM Application Deployment Walkthrough – Cobuman (YouTube)](https://www.youtube.com/watch?v=hgp15SXJhQ4)

### DFS & File Services

- [DFS Replication Overview – Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/storage/dfs-replication/dfs-replication-overview)

## Further reading (Hybrid architecture)

- [Azure Architecture Center – Hybrid architecture design](https://learn.microsoft.com/azure/architecture/hybrid/)
- [Extend an on-premises network using VPN](https://learn.microsoft.com/azure/vpn-gateway/design)
- [Connect to Azure using ExpressRoute](https://learn.microsoft.com/azure/expressroute/expressroute-introduction)
- [Use Azure file shares](https://learn.microsoft.com/azure/storage/files/storage-files-introduction)
- [Back up files to Azure](https://learn.microsoft.com/azure/backup/backup-overview)
- [Troubleshoot a hybrid VPN connection](https://learn.microsoft.com/azure/vpn-gateway/vpn-gateway-troubleshoot)
- [Certification – Windows Server Hybrid Administrator Associate](https://learn.microsoft.com/credentials/certifications/windows-server-hybrid-administrator)

## Contributing

Contributions are welcome. This repo enforces pull requests to `main` with required checks.

- Required checks on PRs: markdownlint and “PR template check” must pass.
- Please follow the PR template: see `.github/pull_request_template.md`.
- Keep commits focused; the repository enforces a linear history.
- For PowerShell changes, do a quick syntax check locally:

```powershell
# Syntax check all scripts
Get-ChildItem -Path scripts -Filter *.ps1 -Recurse | % { ./scripts/tools/parse-check.ps1 -Path $_.FullName }

# Or check a single file
./scripts/tools/parse-check.ps1 -Path ./scripts/sample-setup.ps1
```
