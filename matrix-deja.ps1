<#
.SYNOPSIS
    Matrix Digital Rain with Deja Vu Stutter Effect
.DESCRIPTION
    Matrix rain that stutters and repeats - like a glitch in the Matrix.
    Columns randomly stutter, repeat, or momentarily duplicate.
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
$YELLOW = "$ESC[93m"
$DIM_YELLOW = "$ESC[33m"
$RED = "$ESC[91m"

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
$stutterState = [int[]]::new($width)  # 0=normal, >0=stutter countdown
$lastDropPos = [int[]]::new($width)   # For stutter repeat

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
    $stutterState[$x] = 0
    $lastDropPos[$x] = $drops[$x]
}

# Fill screen with random chars
for ($y = 0; $y -lt $height; $y++) {
    for ($x = 0; $x -lt $width; $x++) {
        $screen[$y][$x] = $chars[$rng.Next($charCount)]
    }
}

# Global stutter event
$globalStutter = $false
$globalStutterStart = 0
$globalStutterDuration = 0
$nextGlobalStutter = $rng.Next(60, 150)

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

        # Check for global stutter event (all columns stutter together)
        if (-not $globalStutter -and $frameCount -ge $nextGlobalStutter) {
            $globalStutter = $true
            $globalStutterStart = $frameCount
            $globalStutterDuration = $rng.Next(8, 20)  # Short stutter
        }

        if ($globalStutter -and ($frameCount - $globalStutterStart) -gt $globalStutterDuration) {
            $globalStutter = $false
            $nextGlobalStutter = $frameCount + $rng.Next(90, 200)
        }

        # Update drops
        for ($x = 0; $x -lt $width; $x++) {
            # Random individual column stutter
            if ($stutterState[$x] -eq 0 -and $rng.Next(200) -eq 0) {
                $stutterState[$x] = $rng.Next(5, 15)  # Stutter for 5-15 frames
                $lastDropPos[$x] = $drops[$x]
            }

            # Handle stutter
            if ($stutterState[$x] -gt 0 -or $globalStutter) {
                # During stutter: occasionally jump back to previous position
                if ($rng.Next(3) -eq 0) {
                    $drops[$x] = $lastDropPos[$x]
                }
                if (-not $globalStutter) {
                    $stutterState[$x]--
                }
            } else {
                $lastDropPos[$x] = $drops[$x]
            }

            $drops[$x] += $speeds[$x]
            $head = $drops[$x]
            $len = $lengths[$x]

            for ($y = 0; $y -lt $height; $y++) {
                $dist = $head - $y
                if ($dist -ge 0 -and $dist -lt $len) {
                    if ($dist -eq 0) {
                        $brightness[$y][$x] = 3
                    } elseif ($dist -lt 3) {
                        $brightness[$y][$x] = 2
                    } else {
                        $brightness[$y][$x] = 1
                    }
                    # More character mutation during stutter
                    $mutateChance = if ($stutterState[$x] -gt 0 -or $globalStutter) { 5 } else { 15 }
                    if ($rng.Next($mutateChance) -eq 0) {
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
                $stutterState[$x] = 0
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
                $isStuttering = $stutterState[$x] -gt 0 -or $globalStutter

                if ($isStuttering -and $b -gt 0) {
                    # Yellow/orange tint during stutter
                    switch ($b) {
                        1 { $color = $DIM_YELLOW }
                        2 { $color = $YELLOW }
                        3 { $color = $WHITE }
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
        Start-Sleep -Milliseconds $Speed
    }
}
finally {
    $null = [Console]::ReadKey($true)
    Write-Host -NoNewline $SHOW_CURSOR
    Write-Host -NoNewline $RESET
    [Console]::BackgroundColor = $originalBg
    [Console]::ForegroundColor = $originalFg
    Clear-Host
    Write-Host "A deja vu is usually a glitch in the Matrix..." -ForegroundColor Yellow
    Write-Host "It happens when they change something." -ForegroundColor DarkYellow
}
