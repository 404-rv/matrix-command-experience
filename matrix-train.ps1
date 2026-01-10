<#
.SYNOPSIS
    Matrix Digital Rain with Training/Dojo Grid Pattern
.DESCRIPTION
    Matrix rain with a more structured, grid-like appearance.
    Occasional horizontal scan lines and grid patterns like a training construct.
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
$CYAN = "$ESC[96m"
$DIM_CYAN = "$ESC[36m"

# Character set - more structured/digital looking
$gridChars = '01+-|=[]{}:<>#'
$matrixChars = '0123456789ABCDEF'
$chars = ($gridChars + $matrixChars).ToCharArray()
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

# Initialize columns - more uniform for grid feel
for ($x = 0; $x -lt $width; $x++) {
    $drops[$x] = $rng.Next(-$height, 0)
    # More uniform speeds for grid pattern
    $speeds[$x] = if ($x % 4 -eq 0) { 2 } else { $rng.Next(1, 3) }
    $lengths[$x] = $rng.Next(10, 20)
}

# Fill screen with random chars
for ($y = 0; $y -lt $height; $y++) {
    for ($x = 0; $x -lt $width; $x++) {
        $screen[$y][$x] = $chars[$rng.Next($charCount)]
    }
}

# Grid line state
$gridLineY = -1
$gridLineActive = $false
$gridLineFrame = 0
$nextGridLine = $rng.Next(60, 120)

# Horizontal pulse
$pulseY = -1
$pulseActive = $false
$pulseFrame = 0
$nextPulse = $rng.Next(90, 180)

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

        # Grid line timing (horizontal scan)
        if (-not $gridLineActive -and $frameCount -ge $nextGridLine) {
            $gridLineActive = $true
            $gridLineY = 0
            $gridLineFrame = 0
        }

        if ($gridLineActive) {
            $gridLineFrame++
            $gridLineY = [Math]::Floor($gridLineFrame / 2)
            if ($gridLineY -ge $height) {
                $gridLineActive = $false
                $nextGridLine = $frameCount + $rng.Next(120, 240)
            }
        }

        # Horizontal pulse (bright line across)
        if (-not $pulseActive -and $frameCount -ge $nextPulse) {
            $pulseActive = $true
            $pulseY = $rng.Next(5, $height - 5)
            $pulseFrame = 0
        }

        if ($pulseActive) {
            $pulseFrame++
            if ($pulseFrame -gt 10) {
                $pulseActive = $false
                $nextPulse = $frameCount + $rng.Next(150, 300)
            }
        }

        # Update drops
        for ($x = 0; $x -lt $width; $x++) {
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
                    if ($rng.Next(20) -eq 0) {
                        $screen[$y][$x] = $chars[$rng.Next($charCount)]
                    }
                } elseif ($dist -eq $len) {
                    $brightness[$y][$x] = 0
                }
            }

            if ($head - $len -gt $height) {
                $drops[$x] = $rng.Next(-15, -5)
                $speeds[$x] = if ($x % 4 -eq 0) { 2 } else { $rng.Next(1, 3) }
                $lengths[$x] = $rng.Next(10, 20)
            }
        }

        # Build frame
        [void]$sb.Clear()
        [void]$sb.Append($HOME_CURSOR)

        $lastColor = ""
        for ($y = 0; $y -lt $height; $y++) {
            # Check for grid effects on this row
            $isGridLine = $gridLineActive -and ($y -eq $gridLineY -or $y -eq $gridLineY - 1)
            $isPulseLine = $pulseActive -and [Math]::Abs($y - $pulseY) -le 1
            $isGridRow = ($y % 8 -eq 0)  # Horizontal grid lines every 8 rows

            for ($x = 0; $x -lt $width; $x++) {
                $b = $brightness[$y][$x]
                $color = ""
                $char = $null

                # Grid column markers every 10 columns
                $isGridCol = ($x % 10 -eq 0)

                if ($isGridLine) {
                    # Scanning grid line - yellow/cyan
                    if ($b -gt 0) {
                        $color = $CYAN
                    } else {
                        $color = $DIM_CYAN
                        $char = '-'
                    }
                } elseif ($isPulseLine) {
                    # Pulse line - bright
                    if ($b -gt 0) {
                        $color = $WHITE
                    } else {
                        $color = $YELLOW
                        $char = '='
                    }
                } elseif ($isGridRow -and $b -eq 0) {
                    # Subtle grid row markers
                    $color = $DIM_GREEN
                    $char = if ($isGridCol) { '+' } else { '-' }
                } elseif ($isGridCol -and $b -eq 0) {
                    # Subtle grid column markers
                    $color = $DIM_GREEN
                    $char = '|'
                } else {
                    # Normal rain with slightly different coloring
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

                if ($char) {
                    [void]$sb.Append($char)
                } elseif ($b -eq 0) {
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
    Write-Host "Do you think that's air you're breathing?" -ForegroundColor Yellow
    Write-Host "TRAINING SIMULATION COMPLETE" -ForegroundColor Green
}
