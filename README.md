# Hybrid AD / Azure AD / O365 Lab  

![Last Commit](https://img.shields.io/github/last-commit/iplaycomputer/hybrid-ad-azure-lab)
![Open Issues](https://img.shields.io/github/issues/iplaycomputer/hybrid-ad-azure-lab)
![Closed Issues](https://img.shields.io/github/issues-closed/iplaycomputer/hybrid-ad-azure-lab)
![Repo Size](https://img.shields.io/github/repo-size/iplaycomputer/hybrid-ad-azure-lab)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
![Lab Status](https://img.shields.io/badge/lab--status-in_progress-orange)

Languages  
🇺🇸 English

This repo documents my homelab simulating enterprise-scale identity and systems management.  
It demonstrates integration between on-prem Active Directory, Azure AD, and Microsoft 365.
  
## Architecture Diagram  
![Hybrid Microsoft 365 Architecture](hybrid-architechture.png)

## Documentation  

📖 [Hybrid Lab Guide](lab_guide.md) – step-by-step instructions to set up the lab.  

## What’s Included (Diagrammed)  
- On-prem Active Directory domain (lab.local) with OUs, groups, and Group Policies.  
- Azure AD + Microsoft 365 tenant sync via Azure AD Connect.  
- Windows 10/11 clients joined to the domain.  
- File shares with NTFS permissions and DFS namespaces/replication.  
- Application deployment with SCCM (ConfigMgr).  
- Azure File Sync to OneDrive.  
- Office 365 services (Exchange Online, Teams, SharePoint Online) with SSO, MFA, and Conditional Access.  
- Security overlays: HIPAA/PCI compliance scope, monitoring/logging, and SIEM (Sentinel/Splunk).  

## Extensions (Not in Diagram Yet)  
- **Terraform** (AWS VPC + EC2) for cloud infrastructure automation.  
- **Ansible** for Windows configuration management.  

## Why This Lab?  
To practice:  
- Hybrid identity management.  
- GPO and file share administration.  
- Application deployment and automation.  
- Cloud service integration (Office 365 + OneDrive).  
- Security monitoring and compliance alignment.

## Next Steps  
- Expand Terraform to Azure IaaS resources.  
- Automate Intune app deployment.  
- Add Splunk/Sentinel SIEM detection queries.  

---

## 📚 Resources  

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

## 🔧 Troubleshooting Tips  

- **Domain Join Issues** → Verify the PC is joined to the domain and the user has the correct UPN suffix.  
- **O365 Sync Issues** → Check if the account actually synced in Azure AD / O365. Run **IdFix** or review AD Connect sync logs.  
- **Mapped Drive Issues** → Confirm the user is in the correct AD group. Verify NTFS and Share permissions match.  
- **Group Policy Missing** → On the client, run `gpresult /r`. If policies aren’t applying, use `gpupdate /force`.  
  
