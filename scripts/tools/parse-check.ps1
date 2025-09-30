param(
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Position = 0)]
    [Alias('FullName')]
    [string[]]$Path
)

begin {
    $globalExit = 0
    $hadInput = $false
}

process {
    if (-not $Path -or $Path.Count -eq 0) {
        return
    }
    $hadInput = $true
    foreach ($p in $Path) {
        try {
            if (-not (Test-Path -LiteralPath $p)) {
                throw "File not found: $p"
            }

            $content = Get-Content -LiteralPath $p -Raw -ErrorAction Stop
            $tokens = $null
            $errors = $null
            [void][System.Management.Automation.Language.Parser]::ParseInput($content, [ref]$tokens, [ref]$errors)

            if ($errors -and $errors.Count -gt 0) {
                $errors | ForEach-Object {
                    if ($_.Extent) {
                        Write-Error ("$p -> Line {0}, Col {1}: {2}" -f $_.Extent.StartLineNumber, $_.Extent.StartColumnNumber, $_.Message)
                    } else {
                        Write-Error "$p -> $($_.Message)"
                    }
                }
                $globalExit = 1
            } else {
                Write-Host "Parse OK: $p" -ForegroundColor Green
            }
        }
        catch {
            Write-Error $_
            $globalExit = 1
        }
    }
}

end {
    if (-not $hadInput) {
        Write-Error "No input files provided. Pass -Path or pipe files (e.g., Get-ChildItem -Recurse -Filter *.ps1 | .\\scripts\\tools\\parse-check.ps1)."
        $globalExit = 1
    }
    exit $globalExit
}
