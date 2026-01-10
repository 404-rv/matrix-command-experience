<#
.SYNOPSIS
    Matrix Katakana with Random Glitch Effects
.DESCRIPTION
    Matrix rain with Japanese characters that randomly glitches.
    Effects: Screen tear, color burst, static noise, freeze columns,
    scan lines, invert flash, corruption blocks, wave distortion,
    VHS tracking, and flicker.
    Subtle effects get chromatic color shift for visibility.
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
$RED = "$ESC[91m"
$DIM_RED = "$ESC[31m"
$CYAN = "$ESC[96m"
$DIM_CYAN = "$ESC[36m"
$YELLOW = "$ESC[93m"
$MAGENTA = "$ESC[95m"
$DIM_MAGENTA = "$ESC[35m"
$BLACK_BG = "$ESC[40m"
$GREEN_BG = "$ESC[42m"
$BLACK_FG = "$ESC[30m"

# Character sets
$halfWidthKatakana = (-join ([char[]](0xFF66..0xFF9D)))
$matrixSymbols = '0123456789:*<>|+-="@#$%&'
$katakanaChars = $halfWidthKatakana + $matrixSymbols
$chars = $katakanaChars.ToCharArray()
$charCount = $chars.Length
$glitchChars = '!@#$%^&*()_+-=[]{}|;:<>?/\~`'.ToCharArray()

# Get dimensions
$width = [Console]::WindowWidth
$height = [Console]::WindowHeight

# Initialize arrays
$drops = [int[]]::new($width)
$speeds = [int[]]::new($width)
$lengths = [int[]]::new($width)
$frozenColumns = [bool[]]::new($width)

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
    $frozenColumns[$x] = $false
}

# Fill screen with random chars
for ($y = 0; $y -lt $height; $y++) {
    for ($x = 0; $x -lt $width; $x++) {
        $screen[$y][$x] = $chars[$rng.Next($charCount)]
    }
}

# Glitch categories
$dramaticGlitches = @('tear', 'colorBurst', 'staticNoise', 'invert', 'flicker')
$subtleGlitches = @('freeze', 'scanLines', 'corruption', 'wave', 'vhs')
$glitchTypes = $dramaticGlitches + $subtleGlitches

# Chromatic colors for subtle glitches (cycle through these)
$chromaticPalettes = @(
    @{ dim = $DIM_CYAN; bright = $CYAN; name = 'cyan' },
    @{ dim = $DIM_MAGENTA; bright = $MAGENTA; name = 'magenta' },
    @{ dim = $DIM_RED; bright = $RED; name = 'red' }
)

$activeGlitch = $null
$glitchStartFrame = 0
$glitchDuration = 0
$nextGlitchFrame = $rng.Next(30, 90)  # 1-3 seconds at 30fps
$chromaticPalette = $null

# Glitch-specific state
$tearOffset = @{}
$colorBurstRows = @()
$staticNoiseRect = @{ x = 0; y = 0; w = 0; h = 0 }
$scanLineY = 0
$corruptionRect = @{ x = 0; y = 0; w = 0; h = 0 }
$wavePhase = 0
$vhsBandY = 0
$flickerRows = @()

# Setup console
$originalBg = [Console]::BackgroundColor
$originalFg = [Console]::ForegroundColor
[Console]::BackgroundColor = 'Black'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host -NoNewline $HIDE_CURSOR
Write-Host -NoNewline $CLEAR

$sb = [System.Text.StringBuilder]::new($width * $height * 15)
$frameCount = 0

try {
    while (-not [Console]::KeyAvailable) {
        $frameCount++

        # Check if it's time for a new glitch
        if ($activeGlitch -eq $null -and $frameCount -ge $nextGlitchFrame) {
            $activeGlitch = $glitchTypes[$rng.Next($glitchTypes.Count)]
            $glitchStartFrame = $frameCount
            $glitchDuration = $rng.Next(8, 25)  # 0.25 - 0.8 seconds

            # If subtle glitch, pick a chromatic color palette
            if ($subtleGlitches -contains $activeGlitch) {
                $chromaticPalette = $chromaticPalettes[$rng.Next($chromaticPalettes.Count)]
            } else {
                $chromaticPalette = $null
            }

            # Initialize glitch-specific state
            switch ($activeGlitch) {
                'tear' {
                    $tearOffset = @{}
                    $tearCount = $rng.Next(5, 12)
                    for ($i = 0; $i -lt $tearCount; $i++) {
                        $row = $rng.Next($height)
                        $tearOffset[$row] = $rng.Next(-20, 21)
                    }
                }
                'colorBurst' {
                    $colorBurstRows = @()
                    $burstCount = $rng.Next(10, 25)
                    for ($i = 0; $i -lt $burstCount; $i++) {
                        $colorBurstRows += $rng.Next($height)
                    }
                }
                'staticNoise' {
                    $staticNoiseRect.x = $rng.Next([Math]::Max(1, $width - 30))
                    $staticNoiseRect.y = $rng.Next([Math]::Max(1, $height - 15))
                    $staticNoiseRect.w = $rng.Next(15, 40)
                    $staticNoiseRect.h = $rng.Next(8, 20)
                }
                'freeze' {
                    for ($x = 0; $x -lt $width; $x++) {
                        $frozenColumns[$x] = ($rng.Next(2) -eq 0)  # 50% freeze
                    }
                }
                'scanLines' {
                    $scanLineY = 0
                }
                'invert' {
                    # Full screen invert, no special init
                }
                'corruption' {
                    $corruptionRect.x = $rng.Next([Math]::Max(1, $width - 25))
                    $corruptionRect.y = $rng.Next([Math]::Max(1, $height - 12))
                    $corruptionRect.w = $rng.Next(15, 35)
                    $corruptionRect.h = $rng.Next(6, 15)
                }
                'wave' {
                    $wavePhase = 0
                }
                'vhs' {
                    $vhsBandY = $rng.Next($height)
                }
                'flicker' {
                    $flickerRows = @()
                    $flickerCount = $rng.Next(15, 40)
                    for ($i = 0; $i -lt $flickerCount; $i++) {
                        $flickerRows += $rng.Next($height)
                    }
                }
            }
        }

        # Check if glitch should end
        if ($activeGlitch -ne $null -and ($frameCount - $glitchStartFrame) -gt $glitchDuration) {
            # Cleanup glitch state
            if ($activeGlitch -eq 'freeze') {
                for ($x = 0; $x -lt $width; $x++) {
                    $frozenColumns[$x] = $false
                }
            }
            $activeGlitch = $null
            $chromaticPalette = $null
            $nextGlitchFrame = $frameCount + $rng.Next(90, 150)  # 3-5 seconds
        }

        # Update glitch animations
        if ($activeGlitch -eq 'scanLines') {
            $scanLineY = ($scanLineY + 4) % $height
        }
        if ($activeGlitch -eq 'wave') {
            $wavePhase += 0.4
        }
        if ($activeGlitch -eq 'vhs') {
            $vhsBandY = ($vhsBandY + 3) % $height
        }

        # Update drops and brightness
        for ($x = 0; $x -lt $width; $x++) {
            # Skip frozen columns
            if ($frozenColumns[$x]) { continue }

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

        # Build frame
        [void]$sb.Clear()
        [void]$sb.Append($HOME_CURSOR)

        # Invert flash - set background at start
        if ($activeGlitch -eq 'invert') {
            [void]$sb.Append($GREEN_BG)
            [void]$sb.Append($BLACK_FG)
        }

        $lastColor = ""
        for ($y = 0; $y -lt $height; $y++) {
            # Calculate row offset for screen tear
            $rowOffset = 0
            if ($activeGlitch -eq 'tear' -and $tearOffset.ContainsKey($y)) {
                $rowOffset = $tearOffset[$y]
            }

            # Wave distortion offset
            if ($activeGlitch -eq 'wave') {
                $rowOffset += [int]([Math]::Sin($y * 0.2 + $wavePhase) * 8)
            }

            for ($x = 0; $x -lt $width; $x++) {
                # Apply row offset
                $srcX = ($x - $rowOffset + $width) % $width

                $b = $brightness[$y][$srcX]
                $char = $screen[$y][$srcX]
                $color = ""

                # Check for various glitch effects
                $inStaticNoise = ($activeGlitch -eq 'staticNoise' -and
                    $x -ge $staticNoiseRect.x -and $x -lt ($staticNoiseRect.x + $staticNoiseRect.w) -and
                    $y -ge $staticNoiseRect.y -and $y -lt ($staticNoiseRect.y + $staticNoiseRect.h))

                $inCorruption = ($activeGlitch -eq 'corruption' -and
                    $x -ge $corruptionRect.x -and $x -lt ($corruptionRect.x + $corruptionRect.w) -and
                    $y -ge $corruptionRect.y -and $y -lt ($corruptionRect.y + $corruptionRect.h))

                $inScanLine = ($activeGlitch -eq 'scanLines' -and
                    ($y -ge $scanLineY -and $y -lt $scanLineY + 4))

                $inVhsBand = ($activeGlitch -eq 'vhs' -and
                    ($y -ge $vhsBandY -and $y -lt $vhsBandY + 8))

                $inFlicker = ($activeGlitch -eq 'flicker' -and $flickerRows -contains $y)

                $inColorBurst = ($activeGlitch -eq 'colorBurst' -and $colorBurstRows -contains $y)

                # Apply effects
                if ($inStaticNoise) {
                    $color = @($RED, $CYAN, $YELLOW, $WHITE, $MAGENTA)[$rng.Next(5)]
                    $char = $glitchChars[$rng.Next($glitchChars.Length)]
                } elseif ($inCorruption) {
                    if ($rng.Next(2) -eq 0) {
                        $char = $glitchChars[$rng.Next($glitchChars.Length)]
                    }
                    # Corruption uses chromatic colors
                    $color = @($chromaticPalette.bright, $chromaticPalette.dim, $WHITE)[$rng.Next(3)]
                } elseif ($inScanLine) {
                    # Scan lines: dark version of chromatic color
                    $color = "$ESC[90m"
                } elseif ($inVhsBand) {
                    $rowOffset += $rng.Next(-5, 6)
                    $srcX = ($x - $rowOffset + $width) % $width
                    $char = $screen[$y][$srcX]
                    # VHS band uses chromatic colors
                    $color = @($chromaticPalette.bright, $chromaticPalette.dim)[$rng.Next(2)]
                } elseif ($inFlicker) {
                    $color = "$ESC[30m"  # Black (invisible)
                    $char = ' '
                } elseif ($inColorBurst) {
                    $color = @($RED, $CYAN, $YELLOW, $MAGENTA)[$rng.Next(4)]
                } elseif ($activeGlitch -eq 'invert') {
                    $color = $BLACK_FG
                } elseif ($chromaticPalette -ne $null) {
                    # Chromatic color shift for subtle glitches
                    switch ($b) {
                        0 { $color = $chromaticPalette.dim }
                        1 { $color = $chromaticPalette.dim }
                        2 { $color = $chromaticPalette.bright }
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

                if ($b -eq 0 -and -not $inStaticNoise -and -not $inCorruption -and -not $inVhsBand) {
                    [void]$sb.Append(' ')
                } else {
                    [void]$sb.Append($char)
                }
            }
        }

        # Reset after invert
        if ($activeGlitch -eq 'invert') {
            [void]$sb.Append($BLACK_BG)
            [void]$sb.Append($RESET)
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
    $neoName = "Neo_$($env:USERNAME)"
    Write-Host "Signal lost..." -ForegroundColor Cyan
    Write-Host "The Matrix has you, $neoName..." -ForegroundColor Green
}
