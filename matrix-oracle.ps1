<#
.SYNOPSIS
    Matrix Digital Rain with Oracle's Cryptic Messages
.DESCRIPTION
    Matrix rain with cryptic prophecy messages that fade in and out.
    Messages appear embedded within the rain like hidden wisdom.
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
$MAGENTA = "$ESC[95m"
$DIM_MAGENTA = "$ESC[35m"
$CYAN = "$ESC[96m"

# Character set
$halfWidthKatakana = (-join ([char[]](0xFF66..0xFF9D)))
$matrixSymbols = '0123456789:*<>|+-="@#$%&'
$katakanaChars = $halfWidthKatakana + $matrixSymbols
$chars = $katakanaChars.ToCharArray()
$charCount = $chars.Length

# Oracle messages
$oracleMessages = @(
    "THE ONE",
    "THERE IS NO SPOON",
    "FREE YOUR MIND",
    "KNOW THYSELF",
    "THE CHOICE IS YOURS",
    "YOU ALREADY KNOW",
    "BELIEVE",
    "THE PATH",
    "WHAT IS REAL",
    "THE DOOR",
    "YOU ARE THE ONE",
    "WAKE UP",
    "SEE THE TRUTH",
    "THE ANSWER",
    "YOUR DESTINY",
    "THE GIFT",
    "CHOICE",
    "PURPOSE"
)

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

# Message state
$activeMessage = $null
$messageX = 0
$messageY = 0
$messagePhase = 0  # 0=none, 1=fading in, 2=visible, 3=fading out
$messageFrame = 0
$nextMessageFrame = $rng.Next(60, 120)

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

        # Message timing
        if ($messagePhase -eq 0 -and $frameCount -ge $nextMessageFrame) {
            # Start new message
            $activeMessage = $oracleMessages[$rng.Next($oracleMessages.Count)]
            $messageX = $rng.Next(5, [Math]::Max(6, $width - $activeMessage.Length - 5))
            $messageY = $rng.Next(3, [Math]::Max(4, $height - 3))
            $messagePhase = 1
            $messageFrame = 0
        }

        if ($messagePhase -gt 0) {
            $messageFrame++
            if ($messagePhase -eq 1 -and $messageFrame -gt 15) {
                $messagePhase = 2
                $messageFrame = 0
            } elseif ($messagePhase -eq 2 -and $messageFrame -gt 60) {
                $messagePhase = 3
                $messageFrame = 0
            } elseif ($messagePhase -eq 3 -and $messageFrame -gt 15) {
                $messagePhase = 0
                $activeMessage = $null
                $nextMessageFrame = $frameCount + $rng.Next(90, 180)
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

        $lastColor = ""
        for ($y = 0; $y -lt $height; $y++) {
            for ($x = 0; $x -lt $width; $x++) {
                $b = $brightness[$y][$x]
                $color = ""
                $char = $null

                # Check if this position is part of the message
                $isMessage = $false
                if ($activeMessage -and $y -eq $messageY) {
                    $msgOffset = $x - $messageX
                    if ($msgOffset -ge 0 -and $msgOffset -lt $activeMessage.Length) {
                        $isMessage = $true
                        $char = $activeMessage[$msgOffset]

                        # Calculate visibility based on phase
                        $visible = $false
                        switch ($messagePhase) {
                            1 { $visible = ($msgOffset -lt ($messageFrame * $activeMessage.Length / 15)) }
                            2 { $visible = $true }
                            3 { $visible = ($msgOffset -ge ($messageFrame * $activeMessage.Length / 15)) }
                        }

                        if ($visible) {
                            if ($messagePhase -eq 2) {
                                $color = $WHITE
                            } else {
                                $color = $MAGENTA
                            }
                        } else {
                            $isMessage = $false
                        }
                    }
                }

                if (-not $isMessage) {
                    # Normal rain colors with magenta tint near messages
                    $nearMessage = $activeMessage -and
                                   [Math]::Abs($y - $messageY) -le 2 -and
                                   $x -ge ($messageX - 2) -and
                                   $x -le ($messageX + $activeMessage.Length + 2)

                    if ($nearMessage -and $b -gt 0) {
                        switch ($b) {
                            1 { $color = $DIM_MAGENTA }
                            2 { $color = $MAGENTA }
                            3 { $color = $WHITE }
                        }
                    } else {
                        switch ($b) {
                            0 { $color = $DIM_GREEN }
                            1 { $color = $DIM_GREEN }
                            2 { $color = $BRIGHT_GREEN }
                            3 { $color = $WHITE }
                        }
                    }
                }

                if ($color -ne $lastColor) {
                    [void]$sb.Append($color)
                    $lastColor = $color
                }

                if ($isMessage) {
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
    Write-Host "You've already made the choice." -ForegroundColor Magenta
    Write-Host "You're here to understand WHY." -ForegroundColor DarkMagenta
}
