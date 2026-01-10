<#
.SYNOPSIS
    Matrix Digital Rain Effect for Windows Terminal
.DESCRIPTION
    Creates the iconic Matrix "digital rain" effect with green falling characters.
    Press any key to exit.
.EXAMPLE
    .\matrix.ps1
    matrix              # Classic look
    matrix -Extended    # With letters
    matrix -Color Cyan  # Different color
#>

param(
    [ValidateSet('Green', 'Cyan', 'Red', 'Yellow', 'Magenta', 'White')]
    [string]$Color = 'Green',
    [int]$Speed = 33,  # ~30 FPS default
    [switch]$Katakana,
    [switch]$Extended
)

# ANSI escape codes for faster rendering
$ESC = [char]27
$RESET = "$ESC[0m"
$HIDE_CURSOR = "$ESC[?25l"
$SHOW_CURSOR = "$ESC[?25h"
$CLEAR = "$ESC[2J"
$HOME_CURSOR = "$ESC[H"

# Color codes
$ColorCodes = @{
    'Black'   = '30'; 'DarkRed'    = '31'; 'DarkGreen' = '32'; 'DarkYellow' = '33'
    'DarkBlue'= '34'; 'DarkMagenta'= '35'; 'DarkCyan'  = '36'; 'Gray'       = '37'
    'DarkGray'= '90'; 'Red'        = '91'; 'Green'     = '92'; 'Yellow'     = '93'
    'Blue'    = '94'; 'Magenta'    = '95'; 'Cyan'      = '96'; 'White'      = '97'
}

$BrightCode = $ColorCodes[$Color]
$DimCode = $ColorCodes["Dark$Color"]
if (-not $DimCode) { $DimCode = $ColorCodes['DarkGreen'] }

# Character sets
$classicChars = '0123456789:."=*+-<>|!#$%&/\~'
$extendedChars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%&*+-=<>?'
# Authentic Matrix mix: half-width Katakana + numbers + symbols (all single-width)
$halfWidthKatakana = (-join ([char[]](0xFF66..0xFF9D)))
$matrixSymbols = '0123456789:*<>|+-="@#$%&'
$katakanaChars = $halfWidthKatakana + $matrixSymbols

$charSet = if ($Katakana) { $katakanaChars } elseif ($Extended) { $extendedChars } else { $classicChars }
$chars = $charSet.ToCharArray()
$charCount = $chars.Length

# Get dimensions
$width = [Console]::WindowWidth
$height = [Console]::WindowHeight

# Initialize drops - each column has a drop position
$drops = [int[]]::new($width)
$speeds = [int[]]::new($width)
$lengths = [int[]]::new($width)

# Screen buffer - use jagged array (array of arrays) for PowerShell compatibility
$screen = @()
$brightness = @()
for ($y = 0; $y -lt $height; $y++) {
    $screen += ,([char[]]::new($width))
    $brightness += ,([int[]]::new($width))
}

# Random number generator (faster than Get-Random)
$rng = [System.Random]::new()

# Initialize columns
for ($x = 0; $x -lt $width; $x++) {
    $drops[$x] = $rng.Next(-$height, 0)
    $speeds[$x] = $rng.Next(1, 4)
    $lengths[$x] = $rng.Next(8, 25)
}

# Fill screen with random chars
for ($y = 0; $y -lt $height; $y++) {
    for ($x = 0; $x -lt $width; $x++) {
        $screen[$y][$x] = $chars[$rng.Next($charCount)]
    }
}

# Setup console
$originalBg = [Console]::BackgroundColor
$originalFg = [Console]::ForegroundColor
[Console]::BackgroundColor = 'Black'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host -NoNewline $HIDE_CURSOR
Write-Host -NoNewline $CLEAR

$sb = [System.Text.StringBuilder]::new($width * $height * 10)

try {
    while (-not [Console]::KeyAvailable) {
        # Check for resize
        $newWidth = [Console]::WindowWidth
        $newHeight = [Console]::WindowHeight
        if ($newWidth -ne $width -or $newHeight -ne $height) {
            $width = $newWidth
            $height = $newHeight
            $screen = @()
            $brightness = @()
            for ($y = 0; $y -lt $height; $y++) {
                $screen += ,([char[]]::new($width))
                $brightness += ,([int[]]::new($width))
            }
            $drops = [int[]]::new($width)
            $speeds = [int[]]::new($width)
            $lengths = [int[]]::new($width)
            for ($x = 0; $x -lt $width; $x++) {
                $drops[$x] = $rng.Next(-$height, 0)
                $speeds[$x] = $rng.Next(1, 4)
                $lengths[$x] = $rng.Next(8, 25)
            }
            for ($y = 0; $y -lt $height; $y++) {
                for ($x = 0; $x -lt $width; $x++) {
                    $screen[$y][$x] = $chars[$rng.Next($charCount)]
                }
            }
            Write-Host -NoNewline $CLEAR
        }

        # Update drops and brightness
        for ($x = 0; $x -lt $width; $x++) {
            # Move drop down
            $drops[$x] += $speeds[$x]
            $head = $drops[$x]
            $len = $lengths[$x]

            # Update brightness for this column
            for ($y = 0; $y -lt $height; $y++) {
                $dist = $head - $y
                if ($dist -ge 0 -and $dist -lt $len) {
                    # Part of the trail
                    if ($dist -eq 0) {
                        $brightness[$y][$x] = 3  # White head
                    } elseif ($dist -lt 3) {
                        $brightness[$y][$x] = 2  # Bright
                    } else {
                        $brightness[$y][$x] = 1  # Dim
                    }
                    # Randomly mutate character
                    if ($rng.Next(15) -eq 0) {
                        $screen[$y][$x] = $chars[$rng.Next($charCount)]
                    }
                } elseif ($dist -eq $len) {
                    $brightness[$y][$x] = 0  # Clear tail
                }
            }

            # Reset if off screen
            if ($head - $len -gt $height) {
                $drops[$x] = $rng.Next(-15, -5)
                $speeds[$x] = $rng.Next(1, 4)
                $lengths[$x] = $rng.Next(8, 25)
            }
        }

        # Build frame using StringBuilder
        [void]$sb.Clear()
        [void]$sb.Append($HOME_CURSOR)

        $lastBrightness = -1
        for ($y = 0; $y -lt $height; $y++) {
            for ($x = 0; $x -lt $width; $x++) {
                $b = $brightness[$y][$x]
                if ($b -ne $lastBrightness) {
                    switch ($b) {
                        0 { [void]$sb.Append("$ESC[${DimCode}m") }
                        1 { [void]$sb.Append("$ESC[${DimCode}m") }
                        2 { [void]$sb.Append("$ESC[${BrightCode}m") }
                        3 { [void]$sb.Append("$ESC[97m") }  # White
                    }
                    $lastBrightness = $b
                }
                if ($b -eq 0) {
                    [void]$sb.Append(' ')
                } else {
                    [void]$sb.Append($screen[$y][$x])
                }
            }
        }

        # Write entire frame at once
        Write-Host -NoNewline $sb.ToString()

        Start-Sleep -Milliseconds $Speed
    }
}
finally {
    # Cleanup
    $null = [Console]::ReadKey($true)
    Write-Host -NoNewline $SHOW_CURSOR
    Write-Host -NoNewline $RESET
    [Console]::BackgroundColor = $originalBg
    [Console]::ForegroundColor = $originalFg
    Clear-Host
    $neoName = "Neo_$($env:USERNAME)"
    Write-Host "Wake up, $neoName..." -ForegroundColor Green
}
