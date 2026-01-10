# Matrix Command Experience

**A Fun Learning Experiment by Sassy Labs**

Transform your PowerShell terminal into a Matrix-themed command center with digital rain effects, hacker sequences, and interactive experiences.

![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## Features

### Hacker Sequences
Terminal animations inspired by The Matrix trilogy:
- `hacker` - Quick mainframe access
- `hacker -Trace` - They're tracking you...
- `hacker -Boot` - System boot sequence
- `hacker -Deep` - Deep dive: layers, jack-in, red pill
- `hacker -Infect` - Virus spread, containment breach
- `hacker -Wake` - Pod ejection, awakening
- `hacker -Hunt` - Agent pursuit, escape
- `hacker -Swarm` - Sentinel attack, EMP
- `hacker -One` - The One: skill upload
- `hacker -Deja` - Deja vu: black cat glitch
- `hacker -Exit` - Phone trace escape
- `hacker -Train` - Dojo sparring program
- `hacker -Oracle` - Cryptic prophecy

### Matrix Rain Variants
Digital rain screensavers with different effects:
- `matrix` - Classic green rain
- `matrix -Katakana` - Japanese characters
- `matrix -Glitch` - Corrupted, flickering
- `matrix -Dead` - Skull reveal
- `matrix -One` - Freeze effect (Neo's power)
- `matrix -Deja` - Stuttering columns
- `matrix -Oracle` - Cryptic messages in rain
- `matrix -Train` - Grid construct (dojo)

### Rabbit Holes
Complete experiences combining sequences with rain:
- `whiterabbit` - Classic intro -> matrix rain
- `blackrabbit` - Deep dive -> glitch matrix
- `deadrabbit` - Infection -> skull matrix
- `redrabbit` - Red pill -> awakening
- `runrabbit` - Agent chase -> escape
- `steelrabbit` - Sentinels -> EMP -> cyan matrix
- `onerabbit` - The One -> freeze matrix
- `glitchrabbit` - Deja vu -> stutter matrix
- `exitrabbit` - Phone escape -> safe
- `trainrabbit` - Dojo training -> grid matrix
- `oraclerabbit` - Prophecy -> oracle matrix

### Interactive Menu
Type `neo` to launch the Matrix Command Experience menu with:
- Typewriter effect header
- All commands organized by category
- Operator Manual (`?`) to learn commands

## Installation

### Quick Install
1. Download or clone this repository
2. Copy the contents of `Install-MatrixCommands.ps1` to your PowerShell profile
3. Reload your profile: `. $PROFILE`
4. Type `neo` to start!

### Manual Install
1. Copy the `.ps1` files to a folder (e.g., `C:\Dev\_PROJECTS\_SCRIPTS\matrix-rain\`)
2. Add the function definitions to your PowerShell profile
3. Update the paths in the `matrix` function to point to your `.ps1` files

### Finding Your Profile
```powershell
# Show profile path
$PROFILE

# Create profile if it doesn't exist
if (!(Test-Path $PROFILE)) { New-Item -Path $PROFILE -Force }

# Open profile in notepad
notepad $PROFILE
```

## Requirements
- Windows PowerShell 5.1+ or PowerShell Core 7+
- A terminal that supports ANSI escape codes (Windows Terminal recommended)

## Usage

### Quick Start
```powershell
# Launch the interactive menu
neo

# Run a hacker sequence directly
hacker -Wake

# Start matrix rain
matrix

# Full rabbit hole experience
whiterabbit
```

### Exiting Screensavers
Press any key to exit the matrix rain effects.

## Customization

### Speed
All matrix variants accept a `-Speed` parameter (default: 33ms):
```powershell
matrix -Speed 20        # Faster
matrix -Speed 50        # Slower
matrix -One -Speed 40   # Freeze effect, custom speed
```

### Colors
The classic matrix function supports color options:
```powershell
matrix -Color Green    # Default
matrix -Color Cyan     # Machine aesthetic
matrix -Color Red      # Danger mode
matrix -Color Magenta  # Oracle vibes
```

## File Structure
```
matrix-rain/
├── matrix.ps1                  # Classic matrix rain
├── matrix-dead.ps1             # Skull reveal variant
├── matrix-deja.ps1             # Stuttering columns
├── matrix-katakana-glitch.ps1  # Glitchy effect
├── matrix-one.ps1              # Freeze effect
├── matrix-oracle.ps1           # Cryptic messages
├── matrix-train.ps1            # Grid construct
├── SEQUENCE-IDEAS.md           # Development notes
└── README.md                   # This file
```

## Credits
- Created by **Sassy Labs**
- Built with Claude Code
- Inspired by The Matrix trilogy (Warner Bros.)

## License
MIT License - Feel free to use, modify, and distribute!

---

*"There is no spoon."*
