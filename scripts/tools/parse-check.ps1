param(
    [Parameter(Mandatory = $true)]
    [string]$Path
)

try {
    if (-not (Test-Path -LiteralPath $Path)) {
        throw "File not found: $Path"
    }

    $content = Get-Content -LiteralPath $Path -Raw -ErrorAction Stop
    $tokens = $null
    $errors = $null
    [void][System.Management.Automation.Language.Parser]::ParseInput($content, [ref]$tokens, [ref]$errors)

    if ($errors -and $errors.Count -gt 0) {
        $errors | ForEach-Object { Write-Error $_.Message }
        exit 1
    } else {
        Write-Host "Parse OK: $Path" -ForegroundColor Green
        exit 0
    }
}
catch {
    Write-Error $_
    exit 1
}
