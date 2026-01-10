<#
.SYNOPSIS
    Matrix Command Experience - Installer
.DESCRIPTION
    Installs the Matrix Command Experience to your system.
    Run this script once to set everything up.
.EXAMPLE
    .\Install-MatrixCommands.ps1
    # Installs to default location
.EXAMPLE
    .\Install-MatrixCommands.ps1 -InstallPath "D:\Scripts\Matrix"
    # Installs to custom location
#>

param(
    [string]$InstallPath = "$env:USERPROFILE\Documents\MatrixCommands"
)

$ErrorActionPreference = "Stop"

# Colors
$ESC = [char]27
$Green = "$ESC[92m"
$DarkGreen = "$ESC[32m"
$Cyan = "$ESC[96m"
$Yellow = "$ESC[93m"
$Red = "$ESC[91m"
$White = "$ESC[97m"
$Gray = "$ESC[90m"
$Reset = "$ESC[0m"

function Write-MatrixText($text, $color = $Green, $delay = 10) {
    foreach ($char in $text.ToCharArray()) {
        Write-Host $char -NoNewline -ForegroundColor $color
        Start-Sleep -Milliseconds $delay
    }
    Write-Host ""
}

Clear-Host
Write-Host ""
Write-Host "  $Green+================================================================+$Reset"
Write-Host "  $Green|$White     M A T R I X   C O M M A N D   E X P E R I E N C E      $Green|$Reset"
Write-Host "  $Green+================================================================+$Reset"
Write-Host "  $Green|$Gray        A Fun Learning Experiment by Sassy Labs              $Green|$Reset"
Write-Host "  $Green+----------------------------------------------------------------+$Reset"
Write-Host ""
Write-MatrixText "  Initiating installation sequence..." "Green"
Write-Host ""
Start-Sleep -Milliseconds 500

# Step 1: Create install directory
Write-Host "  $Yellow[1/4]$Reset Creating install directory..." -NoNewline
try {
    if (-not (Test-Path $InstallPath)) {
        New-Item -ItemType Directory -Path $InstallPath -Force | Out-Null
    }
    Write-Host " $Green OK$Reset"
} catch {
    Write-Host " $Red FAILED$Reset"
    Write-Host "  Error: $_" -ForegroundColor Red
    exit 1
}

# Step 2: Copy matrix rain scripts
Write-Host "  $Yellow[2/4]$Reset Copying Matrix rain scripts..." -NoNewline
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$scripts = @(
    "matrix.ps1",
    "matrix-dead.ps1",
    "matrix-deja.ps1",
    "matrix-katakana-glitch.ps1",
    "matrix-one.ps1",
    "matrix-oracle.ps1",
    "matrix-train.ps1"
)

try {
    foreach ($script in $scripts) {
        $source = Join-Path $scriptDir $script
        if (Test-Path $source) {
            Copy-Item $source $InstallPath -Force
        }
    }
    # Also copy the functions module
    Copy-Item (Join-Path $scriptDir "MatrixCommands.psm1") $InstallPath -Force
    Write-Host " $Green OK$Reset"
} catch {
    Write-Host " $Red FAILED$Reset"
    Write-Host "  Error: $_" -ForegroundColor Red
    exit 1
}

# Step 3: Update PowerShell profile
Write-Host "  $Yellow[3/4]$Reset Configuring PowerShell profile..." -NoNewline

$profileLine = ". `"$InstallPath\MatrixCommands.psm1`""

try {
    # Create profile if it doesn't exist
    if (-not (Test-Path $PROFILE)) {
        New-Item -ItemType File -Path $PROFILE -Force | Out-Null
    }

    # Check if already installed
    $profileContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
    if ($profileContent -and $profileContent.Contains("MatrixCommands.psm1")) {
        Write-Host " $Cyan ALREADY CONFIGURED$Reset"
    } else {
        # Add to profile
        Add-Content -Path $PROFILE -Value "`n# Matrix Command Experience`n$profileLine"
        Write-Host " $Green OK$Reset"
    }
} catch {
    Write-Host " $Red FAILED$Reset"
    Write-Host "  Error: $_" -ForegroundColor Red
    exit 1
}

# Step 4: Load the module now
Write-Host "  $Yellow[4/4]$Reset Loading Matrix commands..." -NoNewline
try {
    . "$InstallPath\MatrixCommands.psm1"
    Write-Host " $Green OK$Reset"
} catch {
    Write-Host " $Yellow SKIP$Reset (will load on next terminal)"
}

Write-Host ""
Write-Host "  $Green+----------------------------------------------------------------+$Reset"
Write-Host "  $Green|$Reset  $Green Installation Complete!$Reset                                    $Green|$Reset"
Write-Host "  $Green+----------------------------------------------------------------+$Reset"
Write-Host "  $Green|$Reset  Installed to: $Cyan$InstallPath$Reset"
Write-Host "  $Green|$Reset                                                              $Green|$Reset"
Write-Host "  $Green|$Reset  $Yellow Quick Start:$Reset                                              $Green|$Reset"
Write-Host "  $Green|$Reset    Type $Cyan neo$Reset to open the Matrix Command menu               $Green|$Reset"
Write-Host "  $Green|$Reset    Type $Cyan matrix$Reset to start the digital rain                  $Green|$Reset"
Write-Host "  $Green|$Reset    Type $Cyan whiterabbit$Reset for the full experience               $Green|$Reset"
Write-Host "  $Green|$Reset                                                              $Green|$Reset"
Write-Host "  $Green|$Gray  If commands don't work, restart your terminal or run:        $Green|$Reset"
Write-Host "  $Green|$Gray    . `$PROFILE                                                  $Green|$Reset"
Write-Host "  $Green+----------------------------------------------------------------+$Reset"
Write-Host ""
Write-Host "  $DarkGreen""Welcome to the Matrix, Neo_$env:USERNAME""$Reset" -ForegroundColor DarkGreen
Write-Host ""
