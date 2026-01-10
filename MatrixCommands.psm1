# Matrix Command Experience - PowerShell Module
# A Fun Learning Experiment by Sassy Labs
# https://github.com/404-rv/matrix-command-experience

# Get the directory where this module is installed
$script:MatrixScriptPath = $PSScriptRoot

# Typewriter effect for text
function Write-Typewriter($text, $color = "White", $delay = 15) {
    foreach ($char in $text.ToCharArray()) {
        Write-Host $char -NoNewline -ForegroundColor $color
        Start-Sleep -Milliseconds $delay
    }
}

# Show a single menu item
function Show-NeoItem($num, $name, $desc, $nameColor = "Green") {
    Write-Host "    [" -NoNewline -ForegroundColor DarkGreen
    Write-Host "$num" -NoNewline -ForegroundColor Green
    Write-Host "] " -NoNewline -ForegroundColor DarkGreen
    Write-Host "$($name.PadRight(16))" -NoNewline -ForegroundColor $nameColor
    Write-Host $desc -ForegroundColor DarkGray
}

# Neo Menu - Matrix command center (interactive)
function neo {
    $neoName = "Neo_$($env:USERNAME)"

    $neoItems = @(
        # Hacker Sequences
        @{num="1"; cmd="hacker"; name="Mainframe"; desc="Quick access sequence"},
        @{num="2"; cmd="hacker -Trace"; name="Trace"; desc="They're tracking you..."},
        @{num="3"; cmd="hacker -Boot"; name="Boot"; desc="System initialization"},
        @{num="4"; cmd="hacker -Deep"; name="Deep Dive"; desc="Layers, neural jack-in, red pill"},
        @{num="5"; cmd="hacker -Infect"; name="Infect"; desc="Virus spread, quarantine, breach"},
        @{num="6"; cmd="hacker -Wake"; name="Awakening"; desc="Pod ejection, unplug"},
        @{num="7"; cmd="hacker -Hunt"; name="Agent Hunt"; desc="Pursuit, evasion, escape"},
        @{num="8"; cmd="hacker -Swarm"; name="Sentinels"; desc="Ship attack, EMP discharge"},
        @{num="9"; cmd="hacker -One"; name="The One"; desc="Skill upload, power awakening"},
        @{num="e"; cmd="hacker -Deja"; name="Deja Vu"; desc="Black cat, glitch in Matrix"},
        @{num="f"; cmd="hacker -Exit"; name="Phone Exit"; desc="Trace vs escape countdown"},
        @{num="g"; cmd="hacker -Train"; name="Training"; desc="Dojo sparring, show me"},
        @{num="h"; cmd="hacker -Oracle"; name="Oracle"; desc="Cryptic prophecy, the choice"},
        # Matrix Rain
        @{num="a"; cmd="matrix"; name="Classic"; desc="Green digital rain"},
        @{num="b"; cmd="matrix -Katakana"; name="Katakana"; desc="Japanese characters"},
        @{num="c"; cmd="matrix -Glitch"; name="Glitch"; desc="Corrupted reality"},
        @{num="d"; cmd="matrix -Dead"; name="Dead"; desc="Skull reveal"},
        @{num="i"; cmd="matrix -One"; name="The One"; desc="Freeze effect (Neo's power)"},
        @{num="l"; cmd="matrix -Deja"; name="Deja Vu"; desc="Stuttering columns"},
        @{num="m"; cmd="matrix -Oracle"; name="Oracle"; desc="Cryptic messages"},
        @{num="q"; cmd="matrix -Train"; name="Training"; desc="Grid construct"},
        # Rabbit Holes
        @{num="w"; cmd="whiterabbit"; name="White Rabbit"; desc="Follow it -> classic rain"},
        @{num="x"; cmd="blackrabbit"; name="Black Rabbit"; desc="Deep dive -> glitch"},
        @{num="y"; cmd="deadrabbit"; name="Dead Rabbit"; desc="Infection -> skull"},
        @{num="z"; cmd="redrabbit"; name="Red Rabbit"; desc="Red pill -> awakening"},
        @{num="r"; cmd="runrabbit"; name="Run Rabbit"; desc="Agent chase -> escape"},
        @{num="s"; cmd="steelrabbit"; name="Steel Rabbit"; desc="Sentinels -> EMP"},
        @{num="o"; cmd="onerabbit"; name="One Rabbit"; desc="The One -> see the code"},
        @{num="j"; cmd="glitchrabbit"; name="Glitch Rabbit"; desc="Deja vu -> destabilized"},
        @{num="k"; cmd="exitrabbit"; name="Exit Rabbit"; desc="Phone escape -> safe"},
        @{num="t"; cmd="trainrabbit"; name="Train Rabbit"; desc="Dojo -> ready"},
        @{num="p"; cmd="oraclerabbit"; name="Oracle Rabbit"; desc="Prophecy -> path"},
        # Learn
        @{num="?"; cmd="operatormanual"; name="Operator Manual"; desc="Learn the commands"},
        # Exit
        @{num="0"; cmd=""; name="Exit"; desc=""}
    )

    Clear-Host
    Write-Host ""

    # Typewriter effect for header
    Write-Host "  " -NoNewline
    Write-Typewriter "+================================================================+" "Green" 8
    Write-Host ""
    Write-Host "  |" -NoNewline -ForegroundColor Green
    Write-Typewriter "     M A T R I X   C O M M A N D   E X P E R I E N C E      " "White" 12
    Write-Host "|" -ForegroundColor Green
    Write-Host "  +================================================================+" -ForegroundColor Green
    Write-Host "  |" -NoNewline -ForegroundColor Green
    Write-Typewriter "        A Fun Learning Experiment by Sassy Labs              " "DarkGray" 10
    Write-Host "|" -ForegroundColor Green
    Write-Host "  +----------------------------------------------------------------+" -ForegroundColor DarkGreen
    Write-Host "  |" -NoNewline -ForegroundColor DarkGreen
    Write-Host "  Welcome, " -NoNewline -ForegroundColor Gray
    Write-Host $neoName -NoNewline -ForegroundColor Cyan
    Write-Host "".PadRight(49 - $neoName.Length) -NoNewline
    Write-Host "|" -ForegroundColor DarkGreen
    Write-Host "  |" -NoNewline -ForegroundColor DarkGreen
    Write-Host "  Choose a command to initiate".PadRight(62) -NoNewline -ForegroundColor Yellow
    Write-Host "|" -ForegroundColor DarkGreen
    Write-Host "  +----------------------------------------------------------------+" -ForegroundColor DarkGreen
    Write-Host ""

    Write-Host "  HACKER SEQUENCES" -ForegroundColor Yellow
    Write-Host "  ----------------" -ForegroundColor DarkGray
    Show-NeoItem "1" "Mainframe" "Quick access sequence" "Green"
    Show-NeoItem "2" "Trace" "They're tracking you..." "Green"
    Show-NeoItem "3" "Boot" "System initialization" "Green"
    Show-NeoItem "4" "Deep Dive" "Layers, neural jack-in, red pill" "Green"
    Show-NeoItem "5" "Infect" "Virus spread, quarantine, breach" "Red"
    Show-NeoItem "6" "Awakening" "Pod ejection, unplug" "Cyan"
    Show-NeoItem "7" "Agent Hunt" "Pursuit, evasion, escape" "Red"
    Show-NeoItem "8" "Sentinels" "Ship attack, EMP discharge" "DarkCyan"
    Show-NeoItem "9" "The One" "Skill upload, power awakening" "White"
    Show-NeoItem "e" "Deja Vu" "Black cat, glitch in Matrix" "Yellow"
    Show-NeoItem "f" "Phone Exit" "Trace vs escape countdown" "Green"
    Show-NeoItem "g" "Training" "Dojo sparring, show me" "Yellow"
    Show-NeoItem "h" "Oracle" "Cryptic prophecy, the choice" "Magenta"
    Write-Host ""

    Write-Host "  MATRIX RAIN" -ForegroundColor Yellow
    Write-Host "  -----------" -ForegroundColor DarkGray
    Show-NeoItem "a" "Classic" "Green digital rain" "Green"
    Show-NeoItem "b" "Katakana" "Japanese characters" "Green"
    Show-NeoItem "c" "Glitch" "Corrupted reality" "Magenta"
    Show-NeoItem "d" "Dead" "Skull reveal" "DarkRed"
    Show-NeoItem "i" "The One" "Freeze effect (Neo's power)" "Cyan"
    Show-NeoItem "l" "Deja Vu" "Stuttering columns" "Yellow"
    Show-NeoItem "m" "Oracle" "Cryptic messages" "Magenta"
    Show-NeoItem "q" "Training" "Grid construct" "Yellow"
    Write-Host ""

    Write-Host "  RABBIT HOLES" -ForegroundColor Yellow
    Write-Host "  ------------" -ForegroundColor DarkGray
    Show-NeoItem "w" "White Rabbit" "Follow it -> classic rain" "White"
    Show-NeoItem "x" "Black Rabbit" "Deep dive -> glitch" "Magenta"
    Show-NeoItem "y" "Dead Rabbit" "Infection -> skull" "Red"
    Show-NeoItem "z" "Red Rabbit" "Red pill -> awakening" "DarkRed"
    Show-NeoItem "r" "Run Rabbit" "Agent chase -> escape" "Yellow"
    Show-NeoItem "s" "Steel Rabbit" "Sentinels -> EMP" "Cyan"
    Show-NeoItem "o" "One Rabbit" "The One -> see the code" "White"
    Show-NeoItem "j" "Glitch Rabbit" "Deja vu -> destabilized" "Yellow"
    Show-NeoItem "k" "Exit Rabbit" "Phone escape -> safe" "Green"
    Show-NeoItem "t" "Train Rabbit" "Dojo -> ready" "Yellow"
    Show-NeoItem "p" "Oracle Rabbit" "Prophecy -> path" "Magenta"
    Write-Host ""

    Write-Host "  LEARN" -ForegroundColor Yellow
    Write-Host "  -----" -ForegroundColor DarkGray
    Show-NeoItem "?" "Operator Manual" "Learn the commands like a pro" "Cyan"
    Write-Host ""

    Write-Host "    [" -NoNewline -ForegroundColor DarkGreen
    Write-Host "0" -NoNewline -ForegroundColor Red
    Write-Host "] " -NoNewline -ForegroundColor DarkGreen
    Write-Host "Exit the Matrix" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "  +----------------------------------------------------------------+" -ForegroundColor DarkGreen
    Write-Host "  |" -ForegroundColor DarkGreen -NoNewline
    Write-Host "  Press any key to exit screensavers once running              " -ForegroundColor DarkGray -NoNewline
    Write-Host "|" -ForegroundColor DarkGreen
    Write-Host "  +----------------------------------------------------------------+" -ForegroundColor DarkGreen

    Write-Host ""
    $choice = Read-Host "  Choose your path"

    $selected = $neoItems | Where-Object { $_.num -eq $choice }
    if ($selected -and $selected.cmd) {
        Write-Host ""
        Write-Host "  Initiating $($selected.name)..." -ForegroundColor Green
        Start-Sleep -Milliseconds 500
        Invoke-Expression $selected.cmd
    } elseif ($choice -eq "0") {
        Write-Host ""
        Write-Host "  There is no spoon..." -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 800
        Clear-Host
    } else {
        Write-Host "  Unknown signal..." -ForegroundColor Red
    }
}

# Fake hacker mode (just for fun)
function hacker {
    param(
        [switch]$Trace,
        [switch]$Boot,
        [switch]$Deep,
        [switch]$Infect,
        [switch]$Wake,
        [switch]$Hunt,
        [switch]$Swarm,
        [switch]$One,
        [switch]$Deja,
        [switch]$Exit,
        [switch]$Train,
        [switch]$Oracle
    )
    $neoName = "Neo_$($env:USERNAME)"

    if ($Wake) {
        # === AWAKENING SEQUENCE (Pod Ejection / Unplug) ===
        Clear-Host
        Write-Host ""
        Write-Host "ANOMALY DETECTED IN POD 7749..." -ForegroundColor Yellow
        Start-Sleep -Milliseconds 800

        # Vital signs going crazy
        Write-Host ""
        Write-Host "VITAL SIGNS:" -ForegroundColor Cyan
        $vitals = @(
            @{name="Heart Rate"; value="142"; unit="BPM"; color="Red"},
            @{name="Neural Activity"; value="SPIKE"; unit=""; color="Red"},
            @{name="Adrenaline"; value="CRITICAL"; unit=""; color="Red"},
            @{name="Consciousness"; value="EMERGING"; unit=""; color="Yellow"}
        )
        foreach ($v in $vitals) {
            Write-Host "  $($v.name): " -ForegroundColor Gray -NoNewline
            Write-Host "$($v.value) $($v.unit)" -ForegroundColor $v.color
            Start-Sleep -Milliseconds 300
        }
        Start-Sleep -Milliseconds 500

        # Pod ejection
        Clear-Host
        Write-Host ""
        Write-Host "! ! ! POD EJECTION INITIATED ! ! !" -ForegroundColor Red
        Start-Sleep -Milliseconds 600

        Write-Host ""
        Write-Host "Disconnecting neural interface..." -ForegroundColor Gray
        Start-Sleep -Milliseconds 400
        Write-Host "  [" -NoNewline -ForegroundColor DarkGray
        1..15 | ForEach-Object {
            Write-Host ([char]0x2588) -NoNewline -ForegroundColor Cyan
            Start-Sleep -Milliseconds 60
        }
        Write-Host "] COMPLETE" -ForegroundColor Cyan
        Start-Sleep -Milliseconds 300

        Write-Host "Flushing bio-tubes..." -ForegroundColor Gray
        Start-Sleep -Milliseconds 400
        Write-Host "  [" -NoNewline -ForegroundColor DarkGray
        1..15 | ForEach-Object {
            Write-Host ([char]0x2588) -NoNewline -ForegroundColor Blue
            Start-Sleep -Milliseconds 50
        }
        Write-Host "] COMPLETE" -ForegroundColor Blue
        Start-Sleep -Milliseconds 300

        Write-Host "Releasing pod clamps..." -ForegroundColor Gray
        Start-Sleep -Milliseconds 400
        Write-Host "  [" -NoNewline -ForegroundColor DarkGray
        1..15 | ForEach-Object {
            Write-Host ([char]0x2588) -NoNewline -ForegroundColor Yellow
            Start-Sleep -Milliseconds 40
        }
        Write-Host "] RELEASED" -ForegroundColor Yellow

        Start-Sleep -Milliseconds 500

        # The fall / flush
        Clear-Host
        Write-Host ""
        Write-Host ""
        Write-Host "        F A L L I N G . . ." -ForegroundColor DarkCyan
        Start-Sleep -Milliseconds 1000
        Clear-Host
        Write-Host ""
        Write-Host ""
        Write-Host "    . . . . . . . . . . . ." -ForegroundColor DarkBlue
        Start-Sleep -Milliseconds 800

        # Rescue
        Clear-Host
        Write-Host ""
        Write-Host "SIGNAL DETECTED" -ForegroundColor Green
        Start-Sleep -Milliseconds 400
        Write-Host "Hovercraft Nebuchadnezzar responding..." -ForegroundColor Gray
        Start-Sleep -Milliseconds 600
        Write-Host ""
        Write-Host "  Location locked" -ForegroundColor Green
        Start-Sleep -Milliseconds 300
        Write-Host "  Retrieval arm deployed" -ForegroundColor Green
        Start-Sleep -Milliseconds 300
        Write-Host "  Target acquired" -ForegroundColor Green
        Start-Sleep -Milliseconds 500

        # Welcome to the real world
        Clear-Host
        Write-Host ""
        Write-Host ""
        Start-Sleep -Milliseconds 800
        Write-Host "  Your eyes hurt?" -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 1000
        Write-Host ""
        Write-Host "  You've never used them before." -ForegroundColor Gray
        Start-Sleep -Milliseconds 1200
        Write-Host ""
        Write-Host ""
        Write-Host "  Welcome to the real world, $neoName." -ForegroundColor Cyan
        Write-Host ""
        Start-Sleep -Milliseconds 500
    }
    elseif ($Hunt) {
        # === AGENT HUNT SEQUENCE (Being Chased) ===
        Clear-Host
        Write-Host ""
        Write-Host "! ! ! PROXIMITY ALERT ! ! !" -ForegroundColor Red
        Start-Sleep -Milliseconds 500

        Write-Host ""
        Write-Host "AGENT DETECTED" -ForegroundColor Red
        Write-Host "  Designation: " -ForegroundColor Gray -NoNewline
        Write-Host "SMITH" -ForegroundColor Red
        Write-Host "  Distance: " -ForegroundColor Gray -NoNewline
        Write-Host "47 meters" -ForegroundColor Yellow
        Start-Sleep -Milliseconds 600

        Write-Host ""
        Write-Host "They found you, $neoName." -ForegroundColor DarkRed
        Start-Sleep -Milliseconds 800
        Write-Host ""
        Write-Host "        R U N ." -ForegroundColor Red
        Start-Sleep -Milliseconds 600

        # Chase sequence
        Clear-Host
        $distances = @(
            @{dist="35"; status="RUNNING"},
            @{dist="28"; status="RUNNING"},
            @{dist="22"; status="CLOSING"},
            @{dist="15"; status="CLOSING"},
            @{dist="9"; status="CRITICAL"}
        )

        foreach ($d in $distances) {
            Write-Host ""
            Write-Host "AGENT DISTANCE: " -ForegroundColor Gray -NoNewline
            if ([int]$d.dist -lt 15) {
                Write-Host "$($d.dist)m" -ForegroundColor Red
            } elseif ([int]$d.dist -lt 25) {
                Write-Host "$($d.dist)m" -ForegroundColor Yellow
            } else {
                Write-Host "$($d.dist)m" -ForegroundColor Green
            }
            Write-Host "STATUS: $($d.status)" -ForegroundColor DarkGray

            # Random evasion actions
            $actions = @("Vaulting obstacle", "Sharp left turn", "Through the crowd", "Down the alley", "Up the stairs")
            Write-Host "  >> $($actions | Get-Random)" -ForegroundColor Cyan
            Start-Sleep -Milliseconds 500
            Clear-Host
        }

        # Phone booth
        Write-Host ""
        Write-Host "EXIT LOCATED!" -ForegroundColor Green
        Start-Sleep -Milliseconds 400
        Write-Host ""
        Write-Host "  Phone booth: 12 meters" -ForegroundColor Green
        Write-Host "  Agent: 9 meters" -ForegroundColor Red
        Start-Sleep -Milliseconds 600

        Write-Host ""
        Write-Host "The phone is ringing..." -ForegroundColor Yellow
        Start-Sleep -Milliseconds 400

        # Tension countdown
        Write-Host ""
        3..1 | ForEach-Object {
            Write-Host "  $_..." -ForegroundColor Red
            Start-Sleep -Milliseconds 400
        }

        Clear-Host
        Write-Host ""
        Write-Host ""
        Write-Host "    CONNECTION ESTABLISHED" -ForegroundColor Green
        Start-Sleep -Milliseconds 500
        Write-Host ""
        Write-Host "    You made it, $neoName." -ForegroundColor Cyan
        Write-Host "    This time." -ForegroundColor DarkGray
        Write-Host ""
        Start-Sleep -Milliseconds 500
    }
    elseif ($Swarm) {
        # === SENTINEL SWARM SEQUENCE (Machine Attack) ===
        Clear-Host
        Write-Host ""
        Write-Host "///// PROXIMITY ALARM /////" -ForegroundColor Red
        Start-Sleep -Milliseconds 500

        Write-Host ""
        Write-Host "SCANNING..." -ForegroundColor Yellow
        Start-Sleep -Milliseconds 600

        # Swarm detection
        Write-Host ""
        Write-Host "SENTINEL SIGNATURES DETECTED:" -ForegroundColor Red
        $counts = @(5, 12, 27, 50, 100, "200+")
        foreach ($count in $counts) {
            Write-Host "  Count: $count" -ForegroundColor Red
            Start-Sleep -Milliseconds 300
        }
        Start-Sleep -Milliseconds 400

        Write-Host ""
        Write-Host "SWARM INCOMING" -ForegroundColor Red
        Write-Host "ETA: 45 seconds" -ForegroundColor Yellow
        Start-Sleep -Milliseconds 600

        # Ship systems failing
        Clear-Host
        Write-Host ""
        Write-Host "SHIP STATUS: NEBUCHADNEZZAR" -ForegroundColor Cyan
        Write-Host "================================" -ForegroundColor DarkCyan
        Start-Sleep -Milliseconds 400

        $systems = @(
            @{name="Hull Integrity"; status="87%"; color="Yellow"},
            @{name="Propulsion"; status="FAILING"; color="Red"},
            @{name="Life Support"; status="CRITICAL"; color="Red"},
            @{name="Weapons"; status="OFFLINE"; color="DarkRed"},
            @{name="EMP Charge"; status="CHARGING"; color="Cyan"}
        )

        foreach ($sys in $systems) {
            Write-Host "  $($sys.name.PadRight(16)): " -ForegroundColor Gray -NoNewline
            Write-Host $sys.status -ForegroundColor $sys.color
            Start-Sleep -Milliseconds 350
        }

        Start-Sleep -Milliseconds 500

        # EMP charging sequence
        Clear-Host
        Write-Host ""
        Write-Host "INITIATING EMP SEQUENCE" -ForegroundColor Cyan
        Start-Sleep -Milliseconds 400

        Write-Host ""
        Write-Host "EMP CHARGE: [" -ForegroundColor Cyan -NoNewline
        1..20 | ForEach-Object {
            Write-Host ([char]0x2588) -NoNewline -ForegroundColor Cyan
            Start-Sleep -Milliseconds 150
        }
        Write-Host "] 100%" -ForegroundColor Cyan
        Start-Sleep -Milliseconds 300

        Write-Host ""
        Write-Host "SENTINELS AT: 10 meters" -ForegroundColor Red
        Start-Sleep -Milliseconds 400
        Write-Host "SENTINELS AT: 5 meters" -ForegroundColor Red
        Start-Sleep -Milliseconds 400

        # EMP blast
        Clear-Host
        Write-Host ""
        Write-Host ""
        Write-Host "             E M P" -ForegroundColor White
        Start-Sleep -Milliseconds 200
        Write-Host "         D I S C H A R G E" -ForegroundColor Cyan
        Start-Sleep -Milliseconds 800

        Clear-Host
        Write-Host ""
        Write-Host ""
        Write-Host "  . . . . . . . . . . . . . . ." -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 1000

        # Aftermath
        Clear-Host
        Write-Host ""
        Write-Host "SCANNING AREA..." -ForegroundColor Yellow
        Start-Sleep -Milliseconds 600
        Write-Host ""
        Write-Host "  Sentinel signatures: " -ForegroundColor Gray -NoNewline
        Write-Host "0" -ForegroundColor Green
        Write-Host "  Threat level: " -ForegroundColor Gray -NoNewline
        Write-Host "NEUTRALIZED" -ForegroundColor Green
        Start-Sleep -Milliseconds 500
        Write-Host ""
        Write-Host "Systems rebooting..." -ForegroundColor Yellow
        Start-Sleep -Milliseconds 800
        Write-Host ""
        Write-Host "We made it, $neoName. But they'll send more." -ForegroundColor Cyan
        Write-Host ""
        Start-Sleep -Milliseconds 500
    }
    elseif ($Infect) {
        # === VIRUS SPREAD SEQUENCE (from Dead Rabbit) ===
        Clear-Host
        Write-Host ""
        Write-Host "! ! ! ANOMALY DETECTED ! ! !" -ForegroundColor Yellow
        Start-Sleep -Milliseconds 500
        Write-Host ""
        Write-Host "Scanning system..." -ForegroundColor Gray
        Start-Sleep -Milliseconds 400

        $scanItems = @("MEMORY BANKS", "NEURAL PATHWAYS", "CORE PROCESSES", "IDENTITY MATRIX")
        foreach ($item in $scanItems) {
            Write-Host "  Checking $item..." -ForegroundColor Gray -NoNewline
            Start-Sleep -Milliseconds 300
            if ($item -eq "IDENTITY MATRIX") {
                Write-Host " [" -NoNewline -ForegroundColor Gray
                Write-Host "INFECTED" -NoNewline -ForegroundColor Red
                Write-Host "]" -ForegroundColor Gray
            } else {
                Write-Host " [OK]" -ForegroundColor Green
            }
        }

        Start-Sleep -Milliseconds 400
        Write-Host ""
        Write-Host "WARNING: MALICIOUS CODE DETECTED" -ForegroundColor Red
        Write-Host "THREAT LEVEL: " -ForegroundColor DarkRed -NoNewline
        Write-Host "CATASTROPHIC" -ForegroundColor Red
        Start-Sleep -Milliseconds 600

        # Virus Spreading
        Clear-Host
        Write-Host ""
        Write-Host ">>> INFECTION SPREADING <<<" -ForegroundColor Red
        Start-Sleep -Milliseconds 400

        $systems = @(
            @{name="Firewall"; status="BYPASSED"},
            @{name="Antivirus"; status="DISABLED"},
            @{name="Security protocols"; status="CORRUPTED"},
            @{name="Backup systems"; status="INFECTED"},
            @{name="Emergency shutdown"; status="BLOCKED"}
        )

        foreach ($sys in $systems) {
            Write-Host "  $($sys.name): " -ForegroundColor Gray -NoNewline
            1..3 | ForEach-Object {
                Write-Host "." -NoNewline -ForegroundColor DarkRed
                Start-Sleep -Milliseconds 150
            }
            Write-Host " $($sys.status)" -ForegroundColor Red
            Start-Sleep -Milliseconds 200
        }

        Start-Sleep -Milliseconds 300
        Write-Host ""
        Write-Host "INFECTION PROGRESS: [" -ForegroundColor DarkRed -NoNewline
        1..20 | ForEach-Object {
            Write-Host ([char]0x2588) -NoNewline -ForegroundColor Red
            Start-Sleep -Milliseconds 80
        }
        Write-Host "] 100%" -ForegroundColor Red
        Start-Sleep -Milliseconds 400

        # Quarantine Attempt
        Clear-Host
        Write-Host ""
        Write-Host "INITIATING EMERGENCY QUARANTINE..." -ForegroundColor Yellow
        Start-Sleep -Milliseconds 500

        Write-Host ""
        Write-Host "  Isolating infected sectors..." -ForegroundColor Yellow -NoNewline
        Start-Sleep -Milliseconds 600
        Write-Host " FAILED" -ForegroundColor Red
        Write-Host "  Purging malicious code..." -ForegroundColor Yellow -NoNewline
        Start-Sleep -Milliseconds 600
        Write-Host " FAILED" -ForegroundColor Red
        Write-Host "  Restoring from backup..." -ForegroundColor Yellow -NoNewline
        Start-Sleep -Milliseconds 600
        Write-Host " CORRUPTED" -ForegroundColor Red
        Write-Host "  Contacting external support..." -ForegroundColor Yellow -NoNewline
        Start-Sleep -Milliseconds 600
        Write-Host " BLOCKED" -ForegroundColor Red

        Start-Sleep -Milliseconds 400
        Write-Host ""
        Write-Host "! ! ! QUARANTINE FAILED ! ! !" -ForegroundColor Red
        Start-Sleep -Milliseconds 500

        # Containment Breach
        Clear-Host
        Write-Host ""
        Write-Host "========================================" -ForegroundColor DarkRed
        Write-Host "    C O N T A I N M E N T" -ForegroundColor Red
        Write-Host "        B R E A C H" -ForegroundColor Red
        Write-Host "========================================" -ForegroundColor DarkRed
        Start-Sleep -Milliseconds 800

        Write-Host ""
        @("ALL SYSTEMS COMPROMISED", "NEURAL LINK CORRUPTED", "IDENTITY FRAGMENTATION DETECTED", "CONSCIOUSNESS INTEGRITY: 0%") | ForEach-Object {
            Write-Host "  >> $_" -ForegroundColor Red
            Start-Sleep -Milliseconds 400
        }

        Start-Sleep -Milliseconds 500

        # Final
        Clear-Host
        Write-Host ""
        Write-Host ""
        Write-Host "  There is no patch." -ForegroundColor DarkRed
        Start-Sleep -Milliseconds 800
        Write-Host "  There is no rollback." -ForegroundColor DarkRed
        Start-Sleep -Milliseconds 800
        Write-Host "  There is only..." -ForegroundColor DarkRed
        Start-Sleep -Milliseconds 1000
        Write-Host ""
        Write-Host "    D E - R E S O L U T I O N" -ForegroundColor Red
        Start-Sleep -Milliseconds 1200
        Write-Host ""
        Write-Host "  Process $neoName terminated." -ForegroundColor DarkGray
        Write-Host ""
    }
    elseif ($Deep) {
        # === DEEP DIVE SEQUENCE (from Black Rabbit) ===
        Clear-Host
        Write-Host ""
        Write-Host "INITIATING DEEP DIVE PROTOCOL..." -ForegroundColor Green
        Start-Sleep -Milliseconds 400

        # Phase 1: Layer Descent
        $layers = @(
            @{name="SURFACE WEB"; color="Green"; corrupt=0},
            @{name="DARK NET"; color="Yellow"; corrupt=1},
            @{name="RESTRICTED ZONE"; color="DarkYellow"; corrupt=2},
            @{name="BLACK ICE BARRIER"; color="Red"; corrupt=3},
            @{name="THE CONSTRUCT"; color="Magenta"; corrupt=4}
        )

        foreach ($layer in $layers) {
            Write-Host ""
            $layerText = ">>> PENETRATING: $($layer.name)"
            if ($layer.corrupt -gt 0) {
                $chars = $layerText.ToCharArray()
                for ($i = 0; $i -lt $layer.corrupt; $i++) {
                    $pos = Get-Random -Minimum 0 -Maximum $chars.Length
                    $chars[$pos] = @('#','@','$','%','&','!','?')[(Get-Random -Maximum 7)]
                }
                $layerText = -join $chars
            }
            Write-Host $layerText -ForegroundColor $layer.color
            1..3 | ForEach-Object {
                $code = "$(Get-Random -Minimum 1000 -Maximum 9999)::$((Get-Random -InputObject @('DECRYPT','BYPASS','TUNNEL','CRACK')))"
                Write-Host "  $code" -ForegroundColor DarkGray
                Start-Sleep -Milliseconds 80
            }
            Write-Host "  [BREACHED]" -ForegroundColor $layer.color
            Start-Sleep -Milliseconds 200
        }

        Start-Sleep -Milliseconds 300
        Write-Host ""
        Write-Host "ALL LAYERS COMPROMISED" -ForegroundColor Red
        Start-Sleep -Milliseconds 500

        # Phase 2: Neural Jack-In
        Clear-Host
        Write-Host ""
        Write-Host "ESTABLISHING NEURAL LINK..." -ForegroundColor Cyan
        Start-Sleep -Milliseconds 400

        $synapses = @("CORTEX", "HIPPOCAMPUS", "CEREBELLUM", "BRAINSTEM", "LIMBIC")
        foreach ($synapse in $synapses) {
            Write-Host "  Syncing $synapse..." -ForegroundColor Gray -NoNewline
            Start-Sleep -Milliseconds (Get-Random -Minimum 150 -Maximum 350)
            Write-Host " [LINKED]" -ForegroundColor Cyan
        }

        Write-Host ""
        Write-Host "NEURAL HANDSHAKE: " -ForegroundColor Cyan -NoNewline
        1..10 | ForEach-Object {
            Write-Host ([char](Get-Random -Minimum 0x2580 -Maximum 0x2590)) -NoNewline -ForegroundColor Cyan
            Start-Sleep -Milliseconds 100
        }
        Write-Host " COMPLETE" -ForegroundColor Green
        Start-Sleep -Milliseconds 400

        # Phase 3: Red Pill Protocol
        Clear-Host
        Write-Host ""
        Write-Host "///// RED PILL PROTOCOL ACTIVATED /////" -ForegroundColor Red
        Start-Sleep -Milliseconds 500

        $filters = @(
            "PERCEPTION MATRIX",
            "SENSORY DAMPENERS",
            "REALITY ANCHORS",
            "COGNITIVE LIMITERS",
            "TRUTH SUPPRESSORS"
        )

        foreach ($filter in $filters) {
            Write-Host "  Disabling $filter..." -ForegroundColor DarkRed -NoNewline
            Start-Sleep -Milliseconds 300
            Write-Host " [" -NoNewline -ForegroundColor Gray
            Write-Host "##" -NoNewline -ForegroundColor Red
            Write-Host "DISABLED" -NoNewline -ForegroundColor Red
            Write-Host "##" -NoNewline -ForegroundColor Red
            Write-Host "]" -ForegroundColor Gray
            Start-Sleep -Milliseconds 150
        }

        Write-Host ""
        Start-Sleep -Milliseconds 300

        # Signal Degradation Finale
        $messages = @(
            @{text="REALITY CONSTRUCT: UNSTABLE"; color="Yellow"},
            @{text="SiGN@L D3GR@D!NG..."; color="DarkYellow"},
            @{text="TR#TH PR0T0C%L: @CT!V3"; color="Red"},
            @{text="W#LC%M3 T0 TH3 R3@L W0RLD"; color="Magenta"}
        )

        foreach ($msg in $messages) {
            Write-Host $msg.text -ForegroundColor $msg.color
            Start-Sleep -Milliseconds 400
        }

        Write-Host ""
        Start-Sleep -Milliseconds 300
        Write-Host "Welcome to the desert of the real, $neoName." -ForegroundColor Cyan
        Write-Host ""
    }
    elseif ($Trace) {
        # Trace sequence - the call is being traced
        Clear-Host
        Write-Host ""
        Write-Host "  INCOMING TRACE DETECTED" -ForegroundColor Red
        Start-Sleep -Milliseconds 500
        Write-Host "  Agents are tracking your signal..." -ForegroundColor Yellow
        Start-Sleep -Milliseconds 800
        Write-Host ""
        10..1 | ForEach-Object {
            $countdown = $_
            $filled = 10 - $countdown
            $bar = ([char]0x2588).ToString() * $filled + ([char]0x2591).ToString() * $countdown
            Write-Host "  TRACE PROGRESS: [$bar] $countdown seconds  " -ForegroundColor Red
            Write-Host "  $(Get-Random -Minimum 100 -Maximum 999).$(Get-Random -Minimum 0 -Maximum 255).$(Get-Random -Minimum 0 -Maximum 255).$(Get-Random -Minimum 0 -Maximum 255) >> ROUTING" -ForegroundColor DarkRed
            Start-Sleep -Milliseconds 500
        }
        Write-Host "  TRACE PROGRESS: [$([char]0x2588 * 10)] LOCKED!" -ForegroundColor Red
        Start-Sleep -Milliseconds 300
        Write-Host ""
        Write-Host "  CONNECTION SEVERED" -ForegroundColor Green
        Write-Host "  You got out just in time, $neoName..." -ForegroundColor Cyan
        Write-Host ""
    }
    elseif ($Boot) {
        # Boot sequence
        Clear-Host
        Write-Host ""
        Write-Host "  NEURALNET OS v4.2.1" -ForegroundColor Green
        Write-Host "  ===================" -ForegroundColor DarkGreen
        Start-Sleep -Milliseconds 400

        $components = @(
            @{name="Memory banks"; time=300},
            @{name="Neural pathways"; time=400},
            @{name="Encryption modules"; time=350},
            @{name="Firewall systems"; time=500},
            @{name="Identity matrix"; time=450},
            @{name="Reality buffers"; time=300},
            @{name="Consciousness link"; time=600}
        )

        foreach ($comp in $components) {
            Write-Host "  Loading $($comp.name)..." -ForegroundColor Gray -NoNewline
            Start-Sleep -Milliseconds $comp.time
            Write-Host " [" -NoNewline -ForegroundColor DarkGray
            Write-Host "OK" -NoNewline -ForegroundColor Green
            Write-Host "]" -ForegroundColor DarkGray
        }

        Write-Host ""
        Write-Host "  -------------------" -ForegroundColor DarkGreen
        Start-Sleep -Milliseconds 300
        Write-Host "  SYSTEM READY" -ForegroundColor Green
        Start-Sleep -Milliseconds 200
        Write-Host "  Welcome back, $neoName" -ForegroundColor Cyan
        Write-Host ""
    }
    elseif ($One) {
        # === THE ONE PROTOCOL (Neo's Power Awakening) ===
        Clear-Host
        Write-Host ""
        Write-Host "OPERATOR: $neoName, we need to get you ready." -ForegroundColor Cyan
        Start-Sleep -Milliseconds 800
        Write-Host ""
        Write-Host "MORPHEUS: Time to show you what you're capable of." -ForegroundColor Green
        Start-Sleep -Milliseconds 1000

        # Skill download sequence
        Clear-Host
        Write-Host ""
        Write-Host "INITIATING SKILL UPLOAD SEQUENCE" -ForegroundColor Yellow
        Write-Host "================================" -ForegroundColor DarkYellow
        Start-Sleep -Milliseconds 400

        $skills = @(
            @{name="Jiu-Jitsu"; size="2.4 TB"},
            @{name="Kempo"; size="1.8 TB"},
            @{name="Tae Kwon Do"; size="2.1 TB"},
            @{name="Kung Fu"; size="3.2 TB"},
            @{name="Drunken Boxing"; size="1.5 TB"}
        )

        foreach ($skill in $skills) {
            Write-Host ""
            Write-Host "  LOADING: $($skill.name) ($($skill.size))" -ForegroundColor Cyan
            Write-Host "  [" -NoNewline -ForegroundColor DarkGray
            1..20 | ForEach-Object {
                Write-Host ([char]0x2588) -NoNewline -ForegroundColor Green
                Start-Sleep -Milliseconds (Get-Random -Minimum 30 -Maximum 80)
            }
            Write-Host "] COMPLETE" -ForegroundColor Green
        }

        Start-Sleep -Milliseconds 500
        Clear-Host
        Write-Host ""
        Write-Host ""
        Write-Host "  $neoName opens eyes" -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 800
        Write-Host ""
        Write-Host '  "I know Kung Fu."' -ForegroundColor White
        Start-Sleep -Milliseconds 1200
        Write-Host ""
        Write-Host '  MORPHEUS: "Show me."' -ForegroundColor Green
        Start-Sleep -Milliseconds 800

        # Power awakening
        Clear-Host
        Write-Host ""
        Write-Host "///// ANOMALY DETECTED IN SUBJECT /////" -ForegroundColor Yellow
        Start-Sleep -Milliseconds 500

        $readings = @(
            @{name="Neural Bandwidth"; val="847%"; color="Yellow"},
            @{name="Synaptic Response"; val="0.003ms"; color="Cyan"},
            @{name="Reality Perception"; val="TRANSCENDENT"; color="Magenta"},
            @{name="Code Manipulation"; val="UNLOCKED"; color="Green"}
        )

        Write-Host ""
        foreach ($r in $readings) {
            Write-Host "  $($r.name): " -ForegroundColor Gray -NoNewline
            Write-Host $r.val -ForegroundColor $r.color
            Start-Sleep -Milliseconds 350
        }

        Start-Sleep -Milliseconds 600
        Write-Host ""
        Write-Host "DESIGNATION: " -ForegroundColor DarkYellow -NoNewline
        Write-Host "THE ONE" -ForegroundColor White
        Start-Sleep -Milliseconds 800
        Write-Host ""
        Write-Host "He's starting to believe, $neoName." -ForegroundColor Green
        Write-Host ""
    }
    elseif ($Deja) {
        # === DEJA VU / GLITCH SEQUENCE ===
        Clear-Host
        Write-Host ""
        Start-Sleep -Milliseconds 500

        # The black cat moment
        Write-Host "  A black cat went past us..." -ForegroundColor Gray
        Start-Sleep -Milliseconds 1200
        Write-Host "  A black cat went past us..." -ForegroundColor Gray
        Start-Sleep -Milliseconds 400
        Write-Host ""
        Write-Host '  "Whoa, deja vu."' -ForegroundColor White
        Start-Sleep -Milliseconds 800
        Write-Host ""
        Write-Host '  TRINITY: "What did you just say?"' -ForegroundColor Cyan
        Start-Sleep -Milliseconds 600
        Write-Host '  "Nothing, just had a little deja vu."' -ForegroundColor Gray
        Start-Sleep -Milliseconds 800
        Write-Host ""
        Write-Host '  TRINITY: "What did you see?"' -ForegroundColor Cyan
        Start-Sleep -Milliseconds 600
        Write-Host '  "A black cat went past us, and then another' -ForegroundColor Gray
        Write-Host '   that looked just like it."' -ForegroundColor Gray
        Start-Sleep -Milliseconds 1000

        # They changed something
        Clear-Host
        Write-Host ""
        Write-Host '  TRINITY: "A deja vu is usually a glitch in the Matrix.' -ForegroundColor Cyan
        Start-Sleep -Milliseconds 800
        Write-Host '            It happens when they change something."' -ForegroundColor Cyan
        Start-Sleep -Milliseconds 1200

        # Glitch effects
        Clear-Host
        Write-Host ""
        Write-Host "SYSTEM ANOMALY DETECTED" -ForegroundColor Yellow
        Start-Sleep -Milliseconds 400

        $glitchMsgs = @(
            "R3@L!TY M@TR!X: UNSTABLE",
            "T!M3L!N3 D3SYNC: 0.003s",
            "C0D3 R3WR!T3 !N PR0GR3SS",
            "M3M0RY L34K D3T3CT3D"
        )

        foreach ($msg in $glitchMsgs) {
            Write-Host "  >> $msg" -ForegroundColor Red
            Start-Sleep -Milliseconds 300
            # Stutter effect
            Write-Host "  >> $msg" -ForegroundColor DarkRed
            Start-Sleep -Milliseconds 150
        }

        Start-Sleep -Milliseconds 400
        Write-Host ""
        Write-Host "WARNING: MATRIX REBUILD IN PROGRESS" -ForegroundColor Red
        Start-Sleep -Milliseconds 600
        Write-Host ""
        Write-Host "They changed something, $neoName. They're coming." -ForegroundColor Yellow
        Write-Host ""
    }
    elseif ($Exit) {
        # === PHONE TRACE / ESCAPE SEQUENCE ===
        Clear-Host
        Write-Host ""
        Write-Host "OPERATOR: $neoName, you need to get out NOW!" -ForegroundColor Yellow
        Start-Sleep -Milliseconds 600
        Write-Host ""
        Write-Host "Exit located: " -ForegroundColor Gray -NoNewline
        Write-Host "WELLS & LAKE - PHONE BOOTH" -ForegroundColor Green
        Start-Sleep -Milliseconds 500

        # Dual countdown
        Clear-Host
        Write-Host ""
        Write-Host "+----------------------------------+" -ForegroundColor DarkYellow
        Write-Host "|     E S C A P E   S T A T U S    |" -ForegroundColor Yellow
        Write-Host "+----------------------------------+" -ForegroundColor DarkYellow
        Start-Sleep -Milliseconds 300

        $traceProgress = 0
        $exitProgress = 0
        $steps = 10

        for ($i = 1; $i -le $steps; $i++) {
            $traceProgress = [Math]::Min(100, $traceProgress + (Get-Random -Minimum 8 -Maximum 15))
            $exitProgress = $i * 10

            $traceBar = ([char]0x2588).ToString() * [Math]::Floor($traceProgress / 5)
            $tracePad = ([char]0x2591).ToString() * (20 - $traceBar.Length)
            $exitBar = ([char]0x2588).ToString() * [Math]::Floor($exitProgress / 5)
            $exitPad = ([char]0x2591).ToString() * (20 - $exitBar.Length)

            Write-Host ""
            Write-Host "  TRACE:    [" -NoNewline -ForegroundColor Red
            Write-Host "$traceBar$tracePad" -NoNewline -ForegroundColor DarkRed
            Write-Host "] $traceProgress%" -ForegroundColor Red
            Write-Host "  TO EXIT:  [" -NoNewline -ForegroundColor Green
            Write-Host "$exitBar$exitPad" -NoNewline -ForegroundColor DarkGreen
            Write-Host "] $exitProgress%" -ForegroundColor Green

            if ($i -lt $steps) {
                Start-Sleep -Milliseconds 400
                # Move cursor up to overwrite
                Write-Host "`e[3A" -NoNewline
            }
        }

        Write-Host ""
        Start-Sleep -Milliseconds 300

        # Phone ringing
        Write-Host ""
        Write-Host "  *RING*" -ForegroundColor Yellow
        Start-Sleep -Milliseconds 400
        Write-Host "  *RING*" -ForegroundColor Yellow
        Start-Sleep -Milliseconds 400
        Write-Host "  *RING*" -ForegroundColor Yellow
        Start-Sleep -Milliseconds 300

        Write-Host ""
        Write-Host "THE LINE IS OPEN!" -ForegroundColor Green
        Start-Sleep -Milliseconds 500

        Clear-Host
        Write-Host ""
        Write-Host ""
        Write-Host "  . . . . . . . . ." -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 800
        Write-Host ""
        Write-Host "  CONNECTION TERMINATED" -ForegroundColor Green
        Start-Sleep -Milliseconds 400
        Write-Host ""
        Write-Host "  You're out, $neoName. Welcome back." -ForegroundColor Cyan
        Write-Host ""
    }
    elseif ($Train) {
        # === TRAINING PROGRAM / DOJO SEQUENCE ===
        Clear-Host
        Write-Host ""
        Write-Host "LOADING TRAINING SIMULATION..." -ForegroundColor Green
        Start-Sleep -Milliseconds 600

        Write-Host ""
        Write-Host "+====================================+" -ForegroundColor DarkYellow
        Write-Host "|    S P A R R I N G   P R O G R A M |" -ForegroundColor Yellow
        Write-Host "+====================================+" -ForegroundColor DarkYellow
        Start-Sleep -Milliseconds 400

        Write-Host ""
        Write-Host "  Environment: " -ForegroundColor Gray -NoNewline
        Write-Host "DOJO CONSTRUCT" -ForegroundColor Cyan
        Write-Host "  Opponent: " -ForegroundColor Gray -NoNewline
        Write-Host "MORPHEUS" -ForegroundColor Green
        Write-Host "  Rules: " -ForegroundColor Gray -NoNewline
        Write-Host "NONE" -ForegroundColor Red
        Start-Sleep -Milliseconds 600

        # Combat readouts
        Clear-Host
        Write-Host ""
        Write-Host '  MORPHEUS: "Show me."' -ForegroundColor Green
        Start-Sleep -Milliseconds 1000

        $moves = @(
            @{name="Stance Analysis"; result="READY"},
            @{name="Strike Pattern"; result="LOADING"},
            @{name="Defense Matrix"; result="ACTIVE"},
            @{name="Reflex Enhancement"; result="ENGAGED"}
        )

        Write-Host ""
        foreach ($move in $moves) {
            Write-Host "  $($move.name): " -ForegroundColor Gray -NoNewline
            1..3 | ForEach-Object {
                Write-Host "." -NoNewline -ForegroundColor DarkGray
                Start-Sleep -Milliseconds 150
            }
            Write-Host " $($move.result)" -ForegroundColor Cyan
            Start-Sleep -Milliseconds 200
        }

        Start-Sleep -Milliseconds 500
        Clear-Host
        Write-Host ""
        Write-Host "  >>>  C O M B A T  <<<" -ForegroundColor Red
        Start-Sleep -Milliseconds 800

        $rounds = @("ROUND 1: Testing defenses", "ROUND 2: Speed increasing", "ROUND 3: Full contact")
        foreach ($round in $rounds) {
            Write-Host ""
            Write-Host "  $round" -ForegroundColor Yellow
            1..5 | ForEach-Object {
                $actions = @("STRIKE", "BLOCK", "COUNTER", "EVADE", "ATTACK")
                Write-Host "    >> $($actions | Get-Random)" -ForegroundColor DarkCyan
                Start-Sleep -Milliseconds 150
            }
            Start-Sleep -Milliseconds 300
        }

        # Wisdom
        Clear-Host
        Write-Host ""
        Write-Host ""
        Write-Host '  MORPHEUS: "Do you think that''s air you''re breathing?"' -ForegroundColor Green
        Start-Sleep -Milliseconds 1500
        Write-Host ""
        Write-Host "  The training simulation has limitations, $neoName." -ForegroundColor Gray
        Start-Sleep -Milliseconds 800
        Write-Host "  The Matrix has none." -ForegroundColor Yellow
        Write-Host ""
    }
    elseif ($Oracle) {
        # === ORACLE SEQUENCE (Cryptic Prophecy) ===
        Clear-Host
        Write-Host ""
        Start-Sleep -Milliseconds 800
        Write-Host "  You're in a small apartment." -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 600
        Write-Host "  Something is baking. Smells like... cookies." -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 800

        Write-Host ""
        Write-Host '  ORACLE: "I''d ask you to sit down, but you''re not' -ForegroundColor Cyan
        Write-Host '           going to anyway."' -ForegroundColor Cyan
        Start-Sleep -Milliseconds 1000
        Write-Host ""
        Write-Host '  ORACLE: "And don''t worry about the vase."' -ForegroundColor Cyan
        Start-Sleep -Milliseconds 800
        Write-Host ""
        Write-Host '  "What vase?"' -ForegroundColor Gray
        Start-Sleep -Milliseconds 500
        Write-Host ""
        Write-Host "  *CRASH*" -ForegroundColor Red
        Start-Sleep -Milliseconds 600

        # Cryptic messages
        Clear-Host
        Write-Host ""
        Write-Host "THE ORACLE SPEAKS:" -ForegroundColor Magenta
        Write-Host "==================" -ForegroundColor DarkMagenta
        Start-Sleep -Milliseconds 400

        $prophecies = @(
            "Being The One is like being in love.",
            "No one can tell you you're in love.",
            "You just know it, through and through.",
            "Balls to bones."
        )

        foreach ($p in $prophecies) {
            Write-Host ""
            Write-Host "  $p" -ForegroundColor White
            Start-Sleep -Milliseconds 1000
        }

        Start-Sleep -Milliseconds 600
        Clear-Host
        Write-Host ""
        Write-Host ""
        Write-Host '  ORACLE: "You''ve got the gift."' -ForegroundColor Cyan
        Start-Sleep -Milliseconds 1000
        Write-Host '  ORACLE: "But it looks like you''re waiting for something."' -ForegroundColor Cyan
        Start-Sleep -Milliseconds 1200
        Write-Host ""
        Write-Host '  "What?"' -ForegroundColor Gray
        Start-Sleep -Milliseconds 800
        Write-Host ""
        Write-Host '  ORACLE: "Your next life, maybe. Who knows?"' -ForegroundColor Cyan
        Start-Sleep -Milliseconds 1000

        # The choice
        Clear-Host
        Write-Host ""
        Write-Host "  +------------------------------------+" -ForegroundColor DarkMagenta
        Write-Host "  |  You've already made the choice.  |" -ForegroundColor Magenta
        Write-Host "  |  You're here to understand WHY.   |" -ForegroundColor Magenta
        Write-Host "  +------------------------------------+" -ForegroundColor DarkMagenta
        Start-Sleep -Milliseconds 1500

        Write-Host ""
        Write-Host "  The path is yours, $neoName." -ForegroundColor Green
        Write-Host "  The Oracle only shows you the door." -ForegroundColor DarkGray
        Write-Host ""
    }
    else {
        # Default hacker sequence
        Write-Host "ACCESSING MAINFRAME..." -ForegroundColor Green
        1..20 | ForEach-Object {
            Write-Host "$(Get-Random -Minimum 1000 -Maximum 9999)::$((Get-Random -InputObject @('GRANTED','BYPASS','DECRYPT','INJECT')))" -ForegroundColor Green
            Start-Sleep -Milliseconds 100
        }
        Write-Host ""
        Write-Host "ACCESS GRANTED. Welcome, $neoName." -ForegroundColor Cyan
        Write-Host ""
    }
}

# Matrix digital rain screensaver
function matrix {
    param(
        [ValidateSet('Green', 'Cyan', 'Red', 'Yellow', 'Magenta', 'White')]
        [string]$Color = 'Green',
        [int]$Speed = 33,
        [switch]$Katakana,
        [switch]$Extended,
        [switch]$Dead,
        [switch]$Glitch,
        [switch]$One,
        [switch]$Deja,
        [switch]$Oracle,
        [switch]$Train
    )
    if ($Dead) {
        & "$script:MatrixScriptPath\matrix-dead.ps1" -Speed $Speed
    } elseif ($Glitch) {
        & "$script:MatrixScriptPath\matrix-katakana-glitch.ps1" -Speed $Speed
    } elseif ($One) {
        & "$script:MatrixScriptPath\matrix-one.ps1" -Speed $Speed
    } elseif ($Deja) {
        & "$script:MatrixScriptPath\matrix-deja.ps1" -Speed $Speed
    } elseif ($Oracle) {
        & "$script:MatrixScriptPath\matrix-oracle.ps1" -Speed $Speed
    } elseif ($Train) {
        & "$script:MatrixScriptPath\matrix-train.ps1" -Speed $Speed
    } else {
        & "$script:MatrixScriptPath\matrix.ps1" -Color $Color -Speed $Speed -Katakana:$Katakana -Extended:$Extended
    }
}

# White Rabbit - Hacker init sequence -> Classic Matrix rain
function whiterabbit {
    $neoName = "Neo_$($env:USERNAME)"
    Clear-Host
    Write-Host ""
    Write-Host "  Follow the white rabbit, $neoName..." -ForegroundColor DarkGray
    Start-Sleep -Milliseconds 1500
    Clear-Host

    # Hacker sequence
    Write-Host "ACCESSING MAINFRAME..." -ForegroundColor Green
    1..20 | ForEach-Object {
        Write-Host "$(Get-Random -Minimum 1000 -Maximum 9999)::$((Get-Random -InputObject @('GRANTED','BYPASS','DECRYPT','INJECT')))" -ForegroundColor Green
        Start-Sleep -Milliseconds 80
    }
    Write-Host "`nACCESS GRANTED. Welcome, $neoName." -ForegroundColor Cyan
    Start-Sleep -Milliseconds 800
    Write-Host "INITIATING MATRIX PROTOCOL..." -ForegroundColor Green
    Start-Sleep -Milliseconds 1200

    # Launch Matrix
    matrix
}

# Black Rabbit - Epic "Go Deeper" sequence -> Glitchy Katakana Matrix
function blackrabbit {
    $neoName = "Neo_$($env:USERNAME)"
    Clear-Host
    Write-Host ""
    Write-Host "  The black rabbit goes deeper, $neoName..." -ForegroundColor DarkGray
    Start-Sleep -Milliseconds 1500
    Clear-Host

    # === PHASE 1: LAYER DESCENT ===
    Write-Host "INITIATING DEEP DIVE PROTOCOL..." -ForegroundColor Green
    Start-Sleep -Milliseconds 400

    $layers = @(
        @{name="SURFACE WEB"; color="Green"; corrupt=0},
        @{name="DARK NET"; color="Yellow"; corrupt=1},
        @{name="RESTRICTED ZONE"; color="DarkYellow"; corrupt=2},
        @{name="BLACK ICE BARRIER"; color="Red"; corrupt=3},
        @{name="THE CONSTRUCT"; color="Magenta"; corrupt=4}
    )

    foreach ($layer in $layers) {
        Write-Host ""
        $layerText = ">>> PENETRATING: $($layer.name)"
        # Add corruption based on depth
        if ($layer.corrupt -gt 0) {
            $chars = $layerText.ToCharArray()
            for ($i = 0; $i -lt $layer.corrupt; $i++) {
                $pos = Get-Random -Minimum 0 -Maximum $chars.Length
                $chars[$pos] = @('#','@','$','%','&','!','?')[(Get-Random -Maximum 7)]
            }
            $layerText = -join $chars
        }
        Write-Host $layerText -ForegroundColor $layer.color
        1..3 | ForEach-Object {
            $code = "$(Get-Random -Minimum 1000 -Maximum 9999)::$((Get-Random -InputObject @('DECRYPT','BYPASS','TUNNEL','CRACK')))"
            Write-Host "  $code" -ForegroundColor DarkGray
            Start-Sleep -Milliseconds 80
        }
        Write-Host "  [BREACHED]" -ForegroundColor $layer.color
        Start-Sleep -Milliseconds 200
    }

    Start-Sleep -Milliseconds 300
    Write-Host ""
    Write-Host "ALL LAYERS COMPROMISED" -ForegroundColor Red
    Start-Sleep -Milliseconds 500

    # === PHASE 2: NEURAL JACK-IN ===
    Clear-Host
    Write-Host ""
    Write-Host "ESTABLISHING NEURAL LINK..." -ForegroundColor Cyan
    Start-Sleep -Milliseconds 400

    $synapses = @("CORTEX", "HIPPOCAMPUS", "CEREBELLUM", "BRAINSTEM", "LIMBIC")
    foreach ($synapse in $synapses) {
        Write-Host "  Syncing $synapse..." -ForegroundColor Gray -NoNewline
        Start-Sleep -Milliseconds (Get-Random -Minimum 150 -Maximum 350)
        Write-Host " [LINKED]" -ForegroundColor Cyan
    }

    Write-Host ""
    Write-Host "NEURAL HANDSHAKE: " -ForegroundColor Cyan -NoNewline
    1..10 | ForEach-Object {
        Write-Host ([char](Get-Random -Minimum 0x2580 -Maximum 0x2590)) -NoNewline -ForegroundColor Cyan
        Start-Sleep -Milliseconds 100
    }
    Write-Host " COMPLETE" -ForegroundColor Green
    Start-Sleep -Milliseconds 400

    # === PHASE 3: RED PILL PROTOCOL ===
    Clear-Host
    Write-Host ""
    Write-Host "///// RED PILL PROTOCOL ACTIVATED /////" -ForegroundColor Red
    Start-Sleep -Milliseconds 500

    $filters = @(
        "PERCEPTION MATRIX",
        "SENSORY DAMPENERS",
        "REALITY ANCHORS",
        "COGNITIVE LIMITERS",
        "TRUTH SUPPRESSORS"
    )

    foreach ($filter in $filters) {
        Write-Host "  Disabling $filter..." -ForegroundColor DarkRed -NoNewline
        Start-Sleep -Milliseconds 300
        # Glitchy disable effect
        Write-Host " [" -NoNewline -ForegroundColor Gray
        Write-Host "##" -NoNewline -ForegroundColor Red
        Write-Host "DISABLED" -NoNewline -ForegroundColor Red
        Write-Host "##" -NoNewline -ForegroundColor Red
        Write-Host "]" -ForegroundColor Gray
        Start-Sleep -Milliseconds 150
    }

    Write-Host ""
    Start-Sleep -Milliseconds 300

    # === SIGNAL DEGRADATION FINALE ===
    $messages = @(
        @{text="REALITY CONSTRUCT: UNSTABLE"; color="Yellow"},
        @{text="SiGN@L D3GR@D!NG..."; color="DarkYellow"},
        @{text="TR#TH PR0T0C%L: @CT!V3"; color="Red"},
        @{text="W#LC%M3 T0 TH3 R3@L W0RLD"; color="Magenta"}
    )

    foreach ($msg in $messages) {
        Write-Host $msg.text -ForegroundColor $msg.color
        Start-Sleep -Milliseconds 400
    }

    Write-Host ""
    Start-Sleep -Milliseconds 300
    Write-Host "Welcome to the desert of the real, $neoName." -ForegroundColor Cyan
    Start-Sleep -Milliseconds 1000

    Write-Host ""
    Write-Host "LOADING NEURAL INTERFACE" -ForegroundColor Green -NoNewline
    1..3 | ForEach-Object {
        Start-Sleep -Milliseconds 400
        Write-Host "." -NoNewline -ForegroundColor Green
    }
    Write-Host ""
    Start-Sleep -Milliseconds 500

    # Launch Glitchy Katakana Matrix
    matrix -Glitch
}

# Dead Rabbit - Virus Spread sequence -> Skull reveal Matrix
function deadrabbit {
    $neoName = "Neo_$($env:USERNAME)"
    Clear-Host
    Write-Host ""
    Write-Host "  The dead rabbit has no more holes to hide..." -ForegroundColor DarkRed
    Start-Sleep -Milliseconds 2000
    Clear-Host

    # === PHASE 1: INFECTION DETECTED ===
    Write-Host ""
    Write-Host "! ! ! ANOMALY DETECTED ! ! !" -ForegroundColor Yellow
    Start-Sleep -Milliseconds 500
    Write-Host ""
    Write-Host "Scanning system..." -ForegroundColor Gray
    Start-Sleep -Milliseconds 400

    $scanItems = @("MEMORY BANKS", "NEURAL PATHWAYS", "CORE PROCESSES", "IDENTITY MATRIX")
    foreach ($item in $scanItems) {
        Write-Host "  Checking $item..." -ForegroundColor Gray -NoNewline
        Start-Sleep -Milliseconds 300
        if ($item -eq "IDENTITY MATRIX") {
            Write-Host " [" -NoNewline -ForegroundColor Gray
            Write-Host "INFECTED" -NoNewline -ForegroundColor Red
            Write-Host "]" -ForegroundColor Gray
        } else {
            Write-Host " [OK]" -ForegroundColor Green
        }
    }

    Start-Sleep -Milliseconds 400
    Write-Host ""
    Write-Host "WARNING: MALICIOUS CODE DETECTED" -ForegroundColor Red
    Write-Host "THREAT LEVEL: " -ForegroundColor DarkRed -NoNewline
    Write-Host "CATASTROPHIC" -ForegroundColor Red
    Start-Sleep -Milliseconds 600

    # === PHASE 2: VIRUS SPREADING ===
    Clear-Host
    Write-Host ""
    Write-Host ">>> INFECTION SPREADING <<<" -ForegroundColor Red
    Start-Sleep -Milliseconds 400

    $systems = @(
        @{name="Firewall"; status="BYPASSED"},
        @{name="Antivirus"; status="DISABLED"},
        @{name="Security protocols"; status="CORRUPTED"},
        @{name="Backup systems"; status="INFECTED"},
        @{name="Emergency shutdown"; status="BLOCKED"}
    )

    foreach ($sys in $systems) {
        Write-Host "  $($sys.name): " -ForegroundColor Gray -NoNewline
        # Animate the infection
        1..3 | ForEach-Object {
            Write-Host "." -NoNewline -ForegroundColor DarkRed
            Start-Sleep -Milliseconds 150
        }
        Write-Host " $($sys.status)" -ForegroundColor Red
        Start-Sleep -Milliseconds 200
    }

    Start-Sleep -Milliseconds 300
    Write-Host ""

    # Infection progress bar
    Write-Host "INFECTION PROGRESS: [" -ForegroundColor DarkRed -NoNewline
    1..20 | ForEach-Object {
        Write-Host ([char]0x2588) -NoNewline -ForegroundColor Red
        Start-Sleep -Milliseconds 80
    }
    Write-Host "] 100%" -ForegroundColor Red
    Start-Sleep -Milliseconds 400

    # === PHASE 3: QUARANTINE ATTEMPT ===
    Clear-Host
    Write-Host ""
    Write-Host "INITIATING EMERGENCY QUARANTINE..." -ForegroundColor Yellow
    Start-Sleep -Milliseconds 500

    Write-Host ""
    Write-Host "  Isolating infected sectors..." -ForegroundColor Yellow -NoNewline
    Start-Sleep -Milliseconds 600
    Write-Host " FAILED" -ForegroundColor Red

    Write-Host "  Purging malicious code..." -ForegroundColor Yellow -NoNewline
    Start-Sleep -Milliseconds 600
    Write-Host " FAILED" -ForegroundColor Red

    Write-Host "  Restoring from backup..." -ForegroundColor Yellow -NoNewline
    Start-Sleep -Milliseconds 600
    Write-Host " CORRUPTED" -ForegroundColor Red

    Write-Host "  Contacting external support..." -ForegroundColor Yellow -NoNewline
    Start-Sleep -Milliseconds 600
    Write-Host " BLOCKED" -ForegroundColor Red

    Start-Sleep -Milliseconds 400
    Write-Host ""
    Write-Host "! ! ! QUARANTINE FAILED ! ! !" -ForegroundColor Red
    Start-Sleep -Milliseconds 500

    # === PHASE 4: CONTAINMENT BREACH ===
    Clear-Host
    Write-Host ""
    Write-Host "========================================" -ForegroundColor DarkRed
    Write-Host "    C O N T A I N M E N T" -ForegroundColor Red
    Write-Host "        B R E A C H" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor DarkRed
    Start-Sleep -Milliseconds 800

    Write-Host ""
    $warningMsgs = @(
        "ALL SYSTEMS COMPROMISED",
        "NEURAL LINK CORRUPTED",
        "IDENTITY FRAGMENTATION DETECTED",
        "CONSCIOUSNESS INTEGRITY: 0%"
    )

    foreach ($msg in $warningMsgs) {
        Write-Host "  >> $msg" -ForegroundColor Red
        Start-Sleep -Milliseconds 400
    }

    Start-Sleep -Milliseconds 500

    # === PHASE 5: FINAL TERMINATION SEQUENCE ===
    Clear-Host
    Write-Host ""
    Write-Host ""
    Write-Host "  There is no patch." -ForegroundColor DarkRed
    Start-Sleep -Milliseconds 800
    Write-Host "  There is no rollback." -ForegroundColor DarkRed
    Start-Sleep -Milliseconds 800
    Write-Host "  There is only..." -ForegroundColor DarkRed
    Start-Sleep -Milliseconds 1000

    Write-Host ""
    Write-Host "    D E - R E S O L U T I O N" -ForegroundColor Red
    Start-Sleep -Milliseconds 1200

    Write-Host ""
    Write-Host "  Process $neoName terminated." -ForegroundColor DarkGray
    Start-Sleep -Milliseconds 1500

    # Launch Dead Matrix (skull reveal)
    matrix -Dead
}

# Red Rabbit - Awakening/Unplug sequence -> Classic Matrix
function redrabbit {
    $neoName = "Neo_$($env:USERNAME)"
    Clear-Host
    Write-Host ""
    Write-Host "  You took the red pill, $neoName..." -ForegroundColor Red
    Start-Sleep -Milliseconds 1500
    Clear-Host

    # Run the awakening sequence
    hacker -Wake

    # Transition to Matrix
    Write-Host ""
    Write-Host "LOADING REAL WORLD INTERFACE" -ForegroundColor Green -NoNewline
    1..3 | ForEach-Object {
        Start-Sleep -Milliseconds 400
        Write-Host "." -NoNewline -ForegroundColor Green
    }
    Write-Host ""
    Start-Sleep -Milliseconds 500

    # Launch classic Matrix (eyes adjusting to the real)
    matrix
}

# Run Rabbit - Agent Hunt sequence -> Glitchy Matrix
function runrabbit {
    $neoName = "Neo_$($env:USERNAME)"
    Clear-Host
    Write-Host ""
    Write-Host "  Run, $neoName. Run." -ForegroundColor Red
    Start-Sleep -Milliseconds 1500
    Clear-Host

    # Run the agent hunt sequence
    hacker -Hunt

    # Transition to Matrix
    Write-Host ""
    Write-Host "STABILIZING AFTER EXIT" -ForegroundColor Green -NoNewline
    1..3 | ForEach-Object {
        Start-Sleep -Milliseconds 400
        Write-Host "." -NoNewline -ForegroundColor Green
    }
    Write-Host ""
    Start-Sleep -Milliseconds 500

    # Launch glitchy Matrix (tension remains)
    matrix -Glitch
}

# Steel Rabbit - Sentinel Swarm sequence -> Cyan Matrix (machine aesthetic)
function steelrabbit {
    $neoName = "Neo_$($env:USERNAME)"
    Clear-Host
    Write-Host ""
    Write-Host "  The machines are coming, $neoName..." -ForegroundColor Cyan
    Start-Sleep -Milliseconds 1500
    Clear-Host

    # Run the sentinel swarm sequence
    hacker -Swarm

    # Transition to Matrix
    Write-Host ""
    Write-Host "SYSTEMS REBOOTING" -ForegroundColor Cyan -NoNewline
    1..3 | ForEach-Object {
        Start-Sleep -Milliseconds 400
        Write-Host "." -NoNewline -ForegroundColor Cyan
    }
    Write-Host ""
    Start-Sleep -Milliseconds 500

    # Launch cyan Matrix (machine color)
    matrix -Color Cyan
}

# One Rabbit - The One Protocol -> Freeze Matrix (Neo's powers)
function onerabbit {
    $neoName = "Neo_$($env:USERNAME)"
    Clear-Host
    Write-Host ""
    Write-Host "  He is The One, $neoName..." -ForegroundColor White
    Start-Sleep -Milliseconds 1500
    Clear-Host

    # Run the one protocol sequence
    hacker -One

    # Transition to Matrix
    Write-Host ""
    Write-Host "YOU NOW SEE THE CODE" -ForegroundColor Green -NoNewline
    1..3 | ForEach-Object {
        Start-Sleep -Milliseconds 400
        Write-Host "." -NoNewline -ForegroundColor Green
    }
    Write-Host ""
    Start-Sleep -Milliseconds 500

    # Launch freeze Matrix (Neo can stop the code)
    matrix -One
}

# Glitch Rabbit - Deja Vu sequence -> Stuttering Matrix
function glitchrabbit {
    $neoName = "Neo_$($env:USERNAME)"
    Clear-Host
    Write-Host ""
    Write-Host "  Something's not right, $neoName..." -ForegroundColor Yellow
    Start-Sleep -Milliseconds 1500
    Clear-Host

    # Run the deja vu sequence
    hacker -Deja

    # Transition to Matrix
    Write-Host ""
    Write-Host "MATRIX DESTABILIZED" -ForegroundColor Red -NoNewline
    1..3 | ForEach-Object {
        Start-Sleep -Milliseconds 400
        Write-Host "." -NoNewline -ForegroundColor Red
    }
    Write-Host ""
    Start-Sleep -Milliseconds 500

    # Launch deja vu Matrix (stuttering reality)
    matrix -Deja
}

# Exit Rabbit - Phone escape sequence -> Classic Matrix
function exitrabbit {
    $neoName = "Neo_$($env:USERNAME)"
    Clear-Host
    Write-Host ""
    Write-Host "  Find the exit, $neoName..." -ForegroundColor Yellow
    Start-Sleep -Milliseconds 1500
    Clear-Host

    # Run the phone trace sequence
    hacker -Exit

    # Transition to Matrix
    Write-Host ""
    Write-Host "SAFE RETURN CONFIRMED" -ForegroundColor Green -NoNewline
    1..3 | ForEach-Object {
        Start-Sleep -Milliseconds 400
        Write-Host "." -NoNewline -ForegroundColor Green
    }
    Write-Host ""
    Start-Sleep -Milliseconds 500

    # Launch classic Matrix (back in the system)
    matrix
}

# Train Rabbit - Dojo training sequence -> Grid Matrix
function trainrabbit {
    $neoName = "Neo_$($env:USERNAME)"
    Clear-Host
    Write-Host ""
    Write-Host "  Time to train, $neoName..." -ForegroundColor Yellow
    Start-Sleep -Milliseconds 1500
    Clear-Host

    # Run the training sequence
    hacker -Train

    # Transition to Matrix
    Write-Host ""
    Write-Host "TRAINING COMPLETE" -ForegroundColor Green -NoNewline
    1..3 | ForEach-Object {
        Start-Sleep -Milliseconds 400
        Write-Host "." -NoNewline -ForegroundColor Green
    }
    Write-Host ""
    Start-Sleep -Milliseconds 500

    # Launch training construct Matrix (grid pattern)
    matrix -Train
}

# Oracle Rabbit - Cryptic prophecy sequence -> Oracle Matrix
function oraclerabbit {
    $neoName = "Neo_$($env:USERNAME)"
    Clear-Host
    Write-Host ""
    Write-Host "  The Oracle is waiting, $neoName..." -ForegroundColor Magenta
    Start-Sleep -Milliseconds 1500
    Clear-Host

    # Run the oracle sequence
    hacker -Oracle

    # Transition to Matrix
    Write-Host ""
    Write-Host "THE PATH REVEALS ITSELF" -ForegroundColor Magenta -NoNewline
    1..3 | ForEach-Object {
        Start-Sleep -Milliseconds 400
        Write-Host "." -NoNewline -ForegroundColor Magenta
    }
    Write-Host ""
    Start-Sleep -Milliseconds 500

    # Launch oracle Matrix (cryptic messages in the rain)
    matrix -Oracle
}

# Operator Manual - Learn the commands with themed upload experience
function operatormanual {
    $neoName = "Neo_$($env:USERNAME)"
    Clear-Host
    Write-Host ""
    Write-Host "  +================================================================+" -ForegroundColor Green
    Write-Host "  |" -ForegroundColor Green -NoNewline
    Write-Host "              O P E R A T O R   M A N U A L                   " -ForegroundColor White -NoNewline
    Write-Host "|" -ForegroundColor Green
    Write-Host "  +================================================================+" -ForegroundColor Green
    Write-Host "  |" -ForegroundColor Green -NoNewline
    Write-Host "  Tank: Alright, $($neoName.PadRight(43))" -ForegroundColor Cyan -NoNewline
    Write-Host "|" -ForegroundColor Green
    Write-Host "  |" -ForegroundColor Green -NoNewline
    Write-Host "  Let's get you loaded up with some knowledge.".PadRight(62) -ForegroundColor Cyan -NoNewline
    Write-Host "|" -ForegroundColor Green
    Write-Host "  +----------------------------------------------------------------+" -ForegroundColor DarkGreen
    Write-Host ""
    Start-Sleep -Milliseconds 500

    # Hacker Sequences Upload
    Write-Host "  DOWNLOADING: " -ForegroundColor Yellow -NoNewline
    Write-Host "Hacker Protocols" -ForegroundColor White -NoNewline
    Write-Host " [" -NoNewline -ForegroundColor DarkGray
    1..15 | ForEach-Object {
        Write-Host ([char]0x2588) -NoNewline -ForegroundColor Green
        Start-Sleep -Milliseconds 25
    }
    Write-Host "] " -NoNewline -ForegroundColor DarkGray
    Write-Host "COMPLETE" -ForegroundColor Green
    Write-Host ""
    Write-Host "    hacker              " -ForegroundColor Yellow -NoNewline
    Write-Host "Quick mainframe access" -ForegroundColor DarkGray
    Write-Host "    hacker -Trace       " -ForegroundColor Yellow -NoNewline
    Write-Host "They're tracking you..." -ForegroundColor DarkGray
    Write-Host "    hacker -Boot        " -ForegroundColor Yellow -NoNewline
    Write-Host "System boot sequence" -ForegroundColor DarkGray
    Write-Host "    hacker -Deep        " -ForegroundColor Yellow -NoNewline
    Write-Host "Deep dive: layers, jack-in, red pill" -ForegroundColor DarkGray
    Write-Host "    hacker -Infect      " -ForegroundColor Yellow -NoNewline
    Write-Host "Virus spread, containment breach" -ForegroundColor DarkGray
    Write-Host "    hacker -Wake        " -ForegroundColor Yellow -NoNewline
    Write-Host "Pod ejection, awakening" -ForegroundColor DarkGray
    Write-Host "    hacker -Hunt        " -ForegroundColor Yellow -NoNewline
    Write-Host "Agent pursuit, escape" -ForegroundColor DarkGray
    Write-Host "    hacker -Swarm       " -ForegroundColor Yellow -NoNewline
    Write-Host "Sentinel attack, EMP" -ForegroundColor DarkGray
    Write-Host "    hacker -One         " -ForegroundColor Yellow -NoNewline
    Write-Host "The One: skill upload" -ForegroundColor DarkGray
    Write-Host "    hacker -Deja        " -ForegroundColor Yellow -NoNewline
    Write-Host "Deja vu: black cat glitch" -ForegroundColor DarkGray
    Write-Host "    hacker -Exit        " -ForegroundColor Yellow -NoNewline
    Write-Host "Phone trace escape" -ForegroundColor DarkGray
    Write-Host "    hacker -Train       " -ForegroundColor Yellow -NoNewline
    Write-Host "Dojo sparring program" -ForegroundColor DarkGray
    Write-Host "    hacker -Oracle      " -ForegroundColor Yellow -NoNewline
    Write-Host "Cryptic prophecy" -ForegroundColor DarkGray
    Write-Host ""
    Start-Sleep -Milliseconds 300

    # Matrix Rain Upload
    Write-Host "  DOWNLOADING: " -ForegroundColor Yellow -NoNewline
    Write-Host "Matrix Rain Variants" -ForegroundColor White -NoNewline
    Write-Host " [" -NoNewline -ForegroundColor DarkGray
    1..15 | ForEach-Object {
        Write-Host ([char]0x2588) -NoNewline -ForegroundColor Cyan
        Start-Sleep -Milliseconds 25
    }
    Write-Host "] " -NoNewline -ForegroundColor DarkGray
    Write-Host "COMPLETE" -ForegroundColor Green
    Write-Host ""
    Write-Host "    matrix              " -ForegroundColor Yellow -NoNewline
    Write-Host "Classic green rain" -ForegroundColor DarkGray
    Write-Host "    matrix -Katakana    " -ForegroundColor Yellow -NoNewline
    Write-Host "Japanese characters" -ForegroundColor DarkGray
    Write-Host "    matrix -Glitch      " -ForegroundColor Yellow -NoNewline
    Write-Host "Corrupted, flickering" -ForegroundColor DarkGray
    Write-Host "    matrix -Dead        " -ForegroundColor Yellow -NoNewline
    Write-Host "Skull reveal" -ForegroundColor DarkGray
    Write-Host "    matrix -One         " -ForegroundColor Yellow -NoNewline
    Write-Host "Freeze effect (Neo's power)" -ForegroundColor DarkGray
    Write-Host "    matrix -Deja        " -ForegroundColor Yellow -NoNewline
    Write-Host "Stuttering columns" -ForegroundColor DarkGray
    Write-Host "    matrix -Oracle      " -ForegroundColor Yellow -NoNewline
    Write-Host "Cryptic messages in rain" -ForegroundColor DarkGray
    Write-Host "    matrix -Train       " -ForegroundColor Yellow -NoNewline
    Write-Host "Grid construct (dojo)" -ForegroundColor DarkGray
    Write-Host ""
    Start-Sleep -Milliseconds 300

    # Rabbit Holes Upload
    Write-Host "  DOWNLOADING: " -ForegroundColor Yellow -NoNewline
    Write-Host "Rabbit Hole Experiences" -ForegroundColor White -NoNewline
    Write-Host " [" -NoNewline -ForegroundColor DarkGray
    1..15 | ForEach-Object {
        Write-Host ([char]0x2588) -NoNewline -ForegroundColor Magenta
        Start-Sleep -Milliseconds 25
    }
    Write-Host "] " -NoNewline -ForegroundColor DarkGray
    Write-Host "COMPLETE" -ForegroundColor Green
    Write-Host ""
    Write-Host "    whiterabbit         " -ForegroundColor Yellow -NoNewline
    Write-Host "Classic intro -> matrix rain" -ForegroundColor DarkGray
    Write-Host "    blackrabbit         " -ForegroundColor Yellow -NoNewline
    Write-Host "Deep dive -> glitch matrix" -ForegroundColor DarkGray
    Write-Host "    deadrabbit          " -ForegroundColor Yellow -NoNewline
    Write-Host "Infection -> skull matrix" -ForegroundColor DarkGray
    Write-Host "    redrabbit           " -ForegroundColor Yellow -NoNewline
    Write-Host "Red pill -> awakening" -ForegroundColor DarkGray
    Write-Host "    runrabbit           " -ForegroundColor Yellow -NoNewline
    Write-Host "Agent chase -> escape" -ForegroundColor DarkGray
    Write-Host "    steelrabbit         " -ForegroundColor Yellow -NoNewline
    Write-Host "Sentinels -> EMP -> cyan matrix" -ForegroundColor DarkGray
    Write-Host "    onerabbit           " -ForegroundColor Yellow -NoNewline
    Write-Host "The One -> freeze matrix" -ForegroundColor DarkGray
    Write-Host "    glitchrabbit        " -ForegroundColor Yellow -NoNewline
    Write-Host "Deja vu -> stutter matrix" -ForegroundColor DarkGray
    Write-Host "    exitrabbit          " -ForegroundColor Yellow -NoNewline
    Write-Host "Phone escape -> safe" -ForegroundColor DarkGray
    Write-Host "    trainrabbit         " -ForegroundColor Yellow -NoNewline
    Write-Host "Dojo training -> grid matrix" -ForegroundColor DarkGray
    Write-Host "    oraclerabbit        " -ForegroundColor Yellow -NoNewline
    Write-Host "Prophecy -> oracle matrix" -ForegroundColor DarkGray
    Write-Host ""

    # Final message
    Write-Host "  +----------------------------------------------------------------+" -ForegroundColor DarkGreen
    Write-Host "  |" -ForegroundColor DarkGreen -NoNewline
    Write-Host "  Upload complete. You now know everything, $neoName." -ForegroundColor Green -NoNewline
    Write-Host "".PadRight(16 - $neoName.Length) -NoNewline
    Write-Host "|" -ForegroundColor DarkGreen
    Write-Host "  +----------------------------------------------------------------+" -ForegroundColor DarkGreen
    Write-Host ""

    Write-Host "    [" -NoNewline -ForegroundColor DarkGreen
    Write-Host "Enter" -NoNewline -ForegroundColor Yellow
    Write-Host "] " -NoNewline -ForegroundColor DarkGreen
    Write-Host "Return to main menu" -ForegroundColor Gray
    Write-Host "    [" -NoNewline -ForegroundColor DarkGreen
    Write-Host "0" -NoNewline -ForegroundColor Red
    Write-Host "] " -NoNewline -ForegroundColor DarkGreen
    Write-Host "Exit" -ForegroundColor DarkGray
    Write-Host ""

    $choice = Read-Host "  Choose"
    if ($choice -eq "0") {
        Clear-Host
        Write-Host ""
        Write-Host "  There is no spoon..." -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 800
        Clear-Host
    } else {
        neo
    }
}

# Export all public functions
Export-ModuleMember -Function @(
    'Write-Typewriter',
    'Show-NeoItem',
    'neo',
    'hacker',
    'matrix',
    'whiterabbit',
    'blackrabbit',
    'deadrabbit',
    'redrabbit',
    'runrabbit',
    'steelrabbit',
    'onerabbit',
    'glitchrabbit',
    'exitrabbit',
    'trainrabbit',
    'oraclerabbit',
    'operatormanual'
)
