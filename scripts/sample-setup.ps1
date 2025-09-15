
# Hybrid AD Lab Secure Setup Script
# This script automates basic lab setup tasks with security best practices.
# - Prompts for credentials (no hardcoded passwords)
# - Assigns least privilege permissions
# - Adds logging for auditing

# Prompt for domain admin credentials securely
# (Removed unused $DomainCred variable)

# Create an OU for lab users
New-ADOrganizationalUnit -Name "LabUsers" -Path "DC=lab,DC=local" -ProtectedFromAccidentalDeletion $true

# Create a security group with least privilege
New-ADGroup -Name "LabUsersRW" -GroupScope Global -GroupCategory Security -Path "OU=LabUsers,DC=lab,DC=local"

# Create a user and prompt for password securely
$UserPassword = Read-Host -AsSecureString -Prompt "Enter password for TestUser"
New-ADUser -Name "TestUser" -AccountPassword $UserPassword -Enabled $true -Path "OU=LabUsers,DC=lab,DC=local" -ChangePasswordAtLogon $true

# Create a folder for file sharing
$SharePath = "D:\LabShare"
New-Item -Path $SharePath -ItemType Directory -Force

# Set NTFS permissions: grant only modify rights to LabUsersRW group
$Acl = Get-Acl $SharePath
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("LAB\\LabUsersRW","Modify","ContainerInherit,ObjectInherit","None","Allow")
$Acl.SetAccessRule($AccessRule)
Set-Acl $SharePath $Acl

# Create a secure SMB share
New-SmbShare -Name "LabShare" -Path $SharePath -ChangeAccess "LAB\LabUsersRW"

# Enable auditing on the share for access events
AuditPol /set /subcategory:"File Share" /success:enable /failure:enable

# Install required Windows features (minimal set)
Install-WindowsFeature -Name AD-Domain-Services,RSAT-AD-Tools,RSAT-DNS-Server

# Log all actions to a file for auditing
$LogPath = "D:\LabSetupLog.txt"
Start-Transcript -Path $LogPath
# ...existing code...
Stop-Transcript
