<#
.SYNOPSIS
    Matrix Digital Rain with "The One" Freeze Effect
.DESCRIPTION
    Matrix rain that periodically freezes - like Neo stopping bullets.
    Random freeze events where all motion stops, then resumes.
    Press any key to exit.
#>

param(
    [int]$Speed = 33
)

# ANSI escape codes
$ESC = [char]27
$RESET = "$ESC[0m"
$HIDE_CURSOR = "$ESC[?25l"
$SHOW_CURSOR = "$ESC[?25h"
$CLEAR = "$ESC[2J"
$HOME_CURSOR = "$ESC[H"

# Colors
$DIM_GREEN = "$ESC[32m"
$BRIGHT_GREEN = "$ESC[92m"
$WHITE = "$ESC[97m"
$CYAN = "$ESC[96m"
$DIM_CYAN = "$ESC[36m"

# Character set
$halfWidthKatakana = (-join ([char[]](0xFF66..0xFF9D)))
$matrixSymbols = '0123456789:*<>|+-="@#$%&'
$katakanaChars = $halfWidthKatakana + $matrixSymbols
$chars = $katakanaChars.ToCharArray()
$charCount = $chars.Length

# Get dimensions
$width = [Console]::WindowWidth
$height = [Console]::WindowHeight

# Initialize arrays
$drops = [int[]]::new($width)
$speeds = [int[]]::new($width)
$lengths = [int[]]::new($width)

# Screen buffer
$screen = @()
$brightness = @()
for ($y = 0; $y -lt $height; $y++) {
    $screen += ,([char[]]::new($width))
    $brightness += ,([int[]]::new($width))
}

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

# Freeze state
$isFrozen = $false
$freezeStartFrame = 0
$freezeDuration = 0
$nextFreezeFrame = $rng.Next(90, 180)  # 3-6 seconds at 30fps
$freezeFlashPhase = 0

# Setup console
$originalBg = [Console]::BackgroundColor
$originalFg = [Console]::ForegroundColor
[Console]::BackgroundColor = 'Black'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host -NoNewline $HIDE_CURSOR
Write-Host -NoNewline $CLEAR

$sb = [System.Text.StringBuilder]::new($width * $height * 12)
$frameCount = 0

try {
    while (-not [Console]::KeyAvailable) {
        $frameCount++

        # Check if it's time to freeze
        if (-not $isFrozen -and $frameCount -ge $nextFreezeFrame) {
            $isFrozen = $true
            $freezeStartFrame = $frameCount
            $freezeDuration = $rng.Next(45, 90)  # 1.5-3 seconds frozen
            $freezeFlashPhase = 0
        }

        # Check if freeze should end
        if ($isFrozen -and ($frameCount - $freezeStartFrame) -gt $freezeDuration) {
            $isFrozen = $false
            $nextFreezeFrame = $frameCount + $rng.Next(120, 240)  # 4-8 seconds until next freeze
        }

        # Update freeze flash phase (for shimmer effect during freeze)
        if ($isFrozen) {
            $freezeFlashPhase++
        }

        # Only update drops if NOT frozen
        if (-not $isFrozen) {
            for ($x = 0; $x -lt $width; $x++) {
                $drops[$x] += $speeds[$x]
                $head = $drops[$x]
                $len = $lengths[$x]

                for ($y = 0; $y -lt $height; $y++) {
                    $dist = $head - $y
                    if ($dist -ge 0 -and $dist -lt $len) {
                        if ($dist -eq 0) {
                            $brightness[$y][$x] = 3  # White head
                        } elseif ($dist -lt 3) {
                            $brightness[$y][$x] = 2  # Bright
                        } else {
                            $brightness[$y][$x] = 1  # Dim
                        }
                        if ($rng.Next(15) -eq 0) {
                            $screen[$y][$x] = $chars[$rng.Next($charCount)]
                        }
                    } elseif ($dist -eq $len) {
                        $brightness[$y][$x] = 0
                    }
                }

                if ($head - $len -gt $height) {
                    $drops[$x] = $rng.Next(-15, -5)
                    $speeds[$x] = $rng.Next(1, 4)
                    $lengths[$x] = $rng.Next(8, 25)
                }
            }
        }

        # Build frame
        [void]$sb.Clear()
        [void]$sb.Append($HOME_CURSOR)

        $lastColor = ""
        for ($y = 0; $y -lt $height; $y++) {
            for ($x = 0; $x -lt $width; $x++) {
                $b = $brightness[$y][$x]
                $color = ""

                if ($isFrozen) {
                    # During freeze: cyan tint with occasional shimmer
                    $shimmer = (($freezeFlashPhase + $x + $y) % 20) -lt 2
                    if ($b -eq 0) {
                        $color = $DIM_CYAN
                    } elseif ($shimmer -and $b -gt 0) {
                        $color = $WHITE
                    } elseif ($b -eq 3) {
                        $color = $CYAN
                    } elseif ($b -eq 2) {
                        $color = $CYAN
                    } else {
                        $color = $DIM_CYAN
                    }
                } else {
                    # Normal colors
                    switch ($b) {
                        0 { $color = $DIM_GREEN }
                        1 { $color = $DIM_GREEN }
                        2 { $color = $BRIGHT_GREEN }
                        3 { $color = $WHITE }
                    }
                }

                if ($color -ne $lastColor) {
                    [void]$sb.Append($color)
                    $lastColor = $color
                }

                if ($b -eq 0) {
                    [void]$sb.Append(' ')
                } else {
                    [void]$sb.Append($screen[$y][$x])
                }
            }
        }

        Write-Host -NoNewline $sb.ToString()

        # Slower during freeze for dramatic effect
        if ($isFrozen) {
            Start-Sleep -Milliseconds ($Speed + 20)
        } else {
            Start-Sleep -Milliseconds $Speed
        }
    }
}
finally {
    $null = [Console]::ReadKey($true)
    Write-Host -NoNewline $SHOW_CURSOR
    Write-Host -NoNewline $RESET
    [Console]::BackgroundColor = $originalBg
    [Console]::ForegroundColor = $originalFg
    Clear-Host
    $neoName = "Neo_$($env:USERNAME)"
    Write-Host "He is starting to believe..." -ForegroundColor Cyan
    Write-Host "    - $neoName" -ForegroundColor Green
}
