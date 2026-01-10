<#
.SYNOPSIS
    Matrix Digital Rain with Skull + Progress Bar
.DESCRIPTION
    Matrix rain that reveals a skull with a looping progress bar below.
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
$YELLOW = "$ESC[93m"

# Character set
$chars = '0123456789:."=*+-<>|!#$%&/\~'.ToCharArray()
$charCount = $chars.Length

# Skull ASCII art (will be centered on screen)
$skullArt = @(
'                    uuuuuuu                    '
'                uu$$$$$$$$$$$uu                '
'             uu$$$$$$$$$$$$$$$$$uu             '
'            u$$$$$$$$$$$$$$$$$$$$$u            '
'           u$$$$$$$$$$$$$$$$$$$$$$$u           '
'          u$$$$$$$$$$$$$$$$$$$$$$$$$u          '
'          u$$$$$$$$$$$$$$$$$$$$$$$$$u          '
'          u$$$$$$"   "$$$"   "$$$$$$u          '
'          "$$$$"      u$u       $$$$"          '
'           $$$u       u$u       u$$$           '
'           $$$u      u$$$u      u$$$           '
'            "$$$$uu$$$   $$$uu$$$$"            '
'             "$$$$$$$"   "$$$$$$$"             '
'               u$$$$$$$u$$$$$$$u               '
'                u$"$"$"$"$"$"$u                '
'     uuu        $$u$ $ $ $ $u$$       uuu      '
'    u$$$$        $$$$$u$u$u$$$       u$$$$     '
'     $$$$$uu      "$$$$$$$$$"     uu$$$$$$     '
'   u$$$$$$$$$$$uu    """""    uuuu$$$$$$$$$$   '
'   $$$$"""$$$$$$$$$$uuu   uu$$$$$$$$$"""$$$"   '
'    """      ""$$$$$$$$$$$uu ""$"""            '
'              uuuu ""$$$$$$$$$$uuu             '
'     u$$$uuu$$$$$$$$$uu ""$$$$$$$$$$$uuu$$$    '
'     $$$$$$$$$$""""           ""$$$$$$$$$$$"   '
'      "$$$$$"                      ""$$$$""    '
'        $$$"                         $$$$"     '
)

# Get dimensions
$width = [Console]::WindowWidth
$height = [Console]::WindowHeight

# Calculate skull position (centered)
$skullHeight = $skullArt.Count
$skullWidth = ($skullArt | ForEach-Object { $_.Length } | Measure-Object -Maximum).Maximum
$skullStartY = [Math]::Max(0, [Math]::Floor(($height - $skullHeight - 4) / 2))
$skullStartX = [Math]::Max(0, [Math]::Floor(($width - $skullWidth) / 2))

# Progress bar settings
$barWidth = 40
$barY = $skullStartY + $skullHeight + 2
$barStartX = [Math]::Floor(($width - $barWidth - 2) / 2)
$progress = 0
$progressSpeed = 0.5  # How fast bar fills (per frame)
$barResetting = $false
$resetCounter = 0

# Create skull mask
$skullMask = @{}
for ($sy = 0; $sy -lt $skullArt.Count; $sy++) {
    $line = $skullArt[$sy]
    for ($sx = 0; $sx -lt $line.Length; $sx++) {
        if ($line[$sx] -ne ' ') {
            $screenY = $skullStartY + $sy
            $screenX = $skullStartX + $sx
            if ($screenY -lt $height -and $screenX -lt $width) {
                $key = "$screenY,$screenX"
                $skullMask[$key] = $true
            }
        }
    }
}

# Initialize arrays
$drops = [int[]]::new($width)
$speeds = [int[]]::new($width)
$lengths = [int[]]::new($width)
$revealed = @{}

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
    $drops[$x] = $rng.Next(-$height * 2, 0)
    $speeds[$x] = $rng.Next(1, 4)
    $lengths[$x] = $rng.Next(8, 20)
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

$sb = [System.Text.StringBuilder]::new($width * $height * 15)
$frameCount = 0

try {
    while (-not [Console]::KeyAvailable) {
        $frameCount++

        # Update progress bar
        if (-not $barResetting) {
            $progress += $progressSpeed
            if ($progress -ge $barWidth) {
                $barResetting = $true
                $resetCounter = 0
            }
        } else {
            $resetCounter++
            if ($resetCounter -gt 30) {  # Pause before reset
                $progress = 0
                $barResetting = $false
            }
        }

        # Update drops and brightness
        for ($x = 0; $x -lt $width; $x++) {
            $drops[$x] += $speeds[$x]
            $head = $drops[$x]
            $len = $lengths[$x]

            for ($y = 0; $y -lt $height; $y++) {
                $key = "$y,$x"
                $isSkull = $skullMask.ContainsKey($key)
                $dist = $head - $y

                if ($dist -ge 0 -and $dist -lt $len) {
                    if ($dist -eq 0) {
                        $brightness[$y][$x] = 3  # White head
                    } elseif ($dist -lt 3) {
                        $brightness[$y][$x] = 2  # Bright
                    } else {
                        $brightness[$y][$x] = 1  # Dim
                    }

                    if ($isSkull -and $dist -eq $len - 1) {
                        $revealed[$key] = $true
                    }

                    if ($rng.Next(15) -eq 0) {
                        $screen[$y][$x] = $chars[$rng.Next($charCount)]
                    }
                } elseif ($dist -eq $len) {
                    if (-not $revealed.ContainsKey($key)) {
                        $brightness[$y][$x] = 0
                    }
                }

                if ($revealed.ContainsKey($key)) {
                    $brightness[$y][$x] = 4  # Skull (red)
                }
            }

            if ($head - $len -gt $height) {
                $drops[$x] = $rng.Next(-20, -5)
                $speeds[$x] = $rng.Next(1, 4)
                $lengths[$x] = $rng.Next(8, 20)
            }
        }

        # Build frame
        [void]$sb.Clear()
        [void]$sb.Append($HOME_CURSOR)

        $lastBrightness = -1
        for ($y = 0; $y -lt $height; $y++) {
            for ($x = 0; $x -lt $width; $x++) {
                # Check if this is part of the progress bar
                $isBar = ($y -eq $barY) -and ($x -ge $barStartX) -and ($x -lt $barStartX + $barWidth + 2)

                if ($isBar) {
                    $barPos = $x - $barStartX
                    if ($barPos -eq 0) {
                        # Left bracket
                        [void]$sb.Append($DIM_RED)
                        [void]$sb.Append('[')
                    } elseif ($barPos -eq $barWidth + 1) {
                        # Right bracket
                        [void]$sb.Append($DIM_RED)
                        [void]$sb.Append(']')
                    } else {
                        # Bar content
                        $fillPos = $barPos - 1
                        if ($barResetting) {
                            # During reset, show corrupted/glitchy
                            if ($rng.Next(3) -eq 0) {
                                [void]$sb.Append($BRIGHT_GREEN)
                                [void]$sb.Append($chars[$rng.Next($charCount)])
                            } else {
                                [void]$sb.Append($DIM_GREEN)
                                [void]$sb.Append(' ')
                            }
                        } elseif ($fillPos -lt [Math]::Floor($progress)) {
                            # Filled portion
                            [void]$sb.Append($RED)
                            [void]$sb.Append([char]0x2588)  # Full block
                        } else {
                            # Empty portion
                            [void]$sb.Append($DIM_RED)
                            [void]$sb.Append([char]0x2591)  # Light shade
                        }
                    }
                    $lastBrightness = -1
                } else {
                    $b = $brightness[$y][$x]
                    if ($b -ne $lastBrightness) {
                        switch ($b) {
                            0 { [void]$sb.Append($DIM_GREEN) }
                            1 { [void]$sb.Append($DIM_GREEN) }
                            2 { [void]$sb.Append($BRIGHT_GREEN) }
                            3 { [void]$sb.Append($WHITE) }
                            4 { [void]$sb.Append($DIM_RED) }
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
    $neoName = "Mr. Anderson"
    Write-Host "Hello, $neoName..." -ForegroundColor Red
    Write-Host "    - Agt_Smith_101" -ForegroundColor DarkGray
}
