# Hybrid AD / Azure AD / O365 Lab

This repo documents my homelab simulating enterprise-scale identity and systems management.  
It demonstrates integration between on-prem Active Directory, Azure AD, and Microsoft 365.

## What’s Included
- On-prem AD domain (lab.local) with OUs, groups, and Group Policies.
- Azure AD + Microsoft 365 tenant sync via Azure AD Connect.
- Windows 10/11 clients joined to the domain.
- File shares with NTFS permissions and DFS namespaces/replication.
- Application deployment with SCCM (ConfigMgr).
- Extensions with Terraform (AWS VPC + EC2) and Ansible (Windows configs).

## Why This Lab?
To practice:
- Hybrid identity management
- GPO and file share administration
- App deployment and automation
- Cloud infrastructure basics (AWS/Azure)
- Endpoint and security monitoring with SIEM

## Next Steps
- Expand Terraform to Azure IaaS resources
- Automate Intune app deployment
- Add Splunk/SIEM detection queries
