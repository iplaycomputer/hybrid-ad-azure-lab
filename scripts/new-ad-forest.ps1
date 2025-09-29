<#
.SYNOPSIS
Promote this Windows Server to a new Active Directory forest (lab.local by default) safely and idempotently.

.DESCRIPTION
- Installs AD DS role (with management tools) if missing.
- Creates a new forest and domain (defaults: lab.local / LAB).
- Securely prompts for the DSRM (Safe Mode) password if not provided.
- Idempotent: exits early if the machine is already a domain controller or a domain exists locally.
- Adds basic validation and clear status output.

.PARAMETER DomainName
The FQDN of the new forest root domain. Default: lab.local

.PARAMETER DomainNetBIOSName
The NetBIOS name for the new domain. Default: LAB

.PARAMETER SafeModeAdministratorPassword
SecureString for the DSRM password. If omitted, you will be prompted.

.PARAMETER Force
Skip interactive confirmations.

.EXAMPLE
# Create a new lab forest using defaults (prompts for DSRM password)
./new-ad-forest.ps1

.EXAMPLE
# Specify names and pass the DSRM password securely
$pw = Read-Host -AsSecureString "Enter DSRM password"
./new-ad-forest.ps1 -DomainName "corp.example" -DomainNetBIOSName "CORP" -SafeModeAdministratorPassword $pw -Force

.NOTES
- Run in an elevated PowerShell session on Windows Server 2019/2022.
- The server will reboot automatically during promotion.
- Ensure the server has a static IP and correct DNS configuration.
#>

[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [Parameter(Mandatory=$false)]
    [ValidatePattern('^[A-Za-z0-9.-]+$')]
    [string]$DomainName = 'lab.local',

    [Parameter(Mandatory=$false)]
    [ValidatePattern('^[A-Za-z0-9-]+$')]
    [string]$DomainNetBIOSName = 'LAB',

    [Parameter(Mandatory=$false)]
    [SecureString]$SafeModeAdministratorPassword,

    [switch]$Force
)

function Assert-Administrator {
    $currentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentIdentity)
    if (-not $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
        throw 'This script must be run in an elevated PowerShell session (Run as administrator).'
    }
}

function Get-IsDomainController {
    try {
        $cs = Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop
        # 4 = Backup DC, 5 = Primary DC
        return ($cs.DomainRole -ge 4)
    } catch {
        return $false
    }
}

function Get-IsDomainJoined {
    try {
        $cs = Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop
        # 3 = Member Server/Workstation, 4/5 are DCs
        return ($cs.PartOfDomain -and $cs.DomainRole -ge 3)
    } catch {
        return $false
    }
}

# Start transcript for basic auditing
$transcriptPath = Join-Path -Path $env:SystemDrive -ChildPath "ADForestSetup-$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
try { Start-Transcript -Path $transcriptPath -ErrorAction SilentlyContinue } catch {}

try {
    Assert-Administrator

    Write-Host "[+] Requested forest: $DomainName (NetBIOS: $DomainNetBIOSName)" -ForegroundColor Cyan

    if (Get-IsDomainController) {
        Write-Warning "This server is already a Domain Controller. Nothing to do."
        return
    }

    if (Get-IsDomainJoined) {
        Write-Warning "This server is already joined to a domain. New forest creation is not applicable here."
        return
    }

    # Ensure AD DS role is present
    $feature = Get-WindowsFeature -Name AD-Domain-Services
    if (-not $feature.Installed) {
        Write-Host "[+] Installing AD Domain Services role and management tools..." -ForegroundColor Cyan
        Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -ErrorAction Stop | Out-Null
        Write-Host "[+] AD DS role installed." -ForegroundColor Green
    } else {
        Write-Host "[+] AD DS role already installed." -ForegroundColor Green
    }

    if (-not $SafeModeAdministratorPassword) {
        $SafeModeAdministratorPassword = Read-Host -AsSecureString -Prompt 'Enter DSRM (Safe Mode) password'
    }

    $installParams = @{
        DomainName                    = $DomainName
        DomainNetbiosName             = $DomainNetBIOSName
        SafeModeAdministratorPassword = $SafeModeAdministratorPassword
        InstallDns                    = $true
        Force                         = $true
    }

    if ($PSCmdlet.ShouldProcess($DomainName, 'Install new AD DS forest and promote to Domain Controller')) {
        Write-Host "[+] Promoting this server to a new forest: $($installParams.DomainName) ..." -ForegroundColor Cyan
        # This cmdlet will reboot automatically on success
        Install-ADDSForest @installParams
    }

} catch {
    Write-Error $_
    exit 1
} finally {
    try { Stop-Transcript | Out-Null } catch {}
}