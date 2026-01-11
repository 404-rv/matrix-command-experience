# Matrix Command Experience

**A Fun Learning Experiment by Sassy Labs**

Transform your PowerShell terminal into a Matrix-themed command center with digital rain effects, hacker sequences, and interactive experiences.

![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue)
![Windows Terminal](https://img.shields.io/badge/Windows%20Terminal-Recommended-brightgreen)
![License](https://img.shields.io/badge/license-MIT-green)

## Quick Start

```powershell
# 1. Clone the repository
git clone https://github.com/404-rv/matrix-command-experience.git

# 2. Navigate to the folder
cd matrix-command-experience

# 3. Run the installer
.\Install-MatrixCommands.ps1

# 4. Start the Matrix!
neo
```

## Requirements

### Required
- **Windows PowerShell 5.1+** or **PowerShell Core 7+**
- **Windows Terminal** (strongly recommended) or any terminal supporting ANSI escape codes

### Recommended
- **Unicode-capable font** for the best experience:
  - Cascadia Code (comes with Windows Terminal)
  - Cascadia Mono
  - Consolas
  - Any Nerd Font (FiraCode Nerd Font, JetBrains Mono Nerd Font, etc.)

### Why Windows Terminal?
The classic Command Prompt (cmd) and older PowerShell hosts don't fully support ANSI escape codes. Windows Terminal provides:
- Full ANSI color support
- Unicode character rendering (Katakana, block characters)
- Better performance for animations

## Installation Options

### Option 1: Quick Install (Recommended)
```powershell
# Clone and run installer
git clone https://github.com/404-rv/matrix-command-experience.git
cd matrix-command-experience
.\Install-MatrixCommands.ps1
```

The installer will:
1. Create an install directory (`Documents\MatrixCommands`)
2. Copy all Matrix scripts
3. Add the module to your PowerShell profile
4. Load the commands immediately

### Option 2: Custom Location
```powershell
.\Install-MatrixCommands.ps1 -InstallPath "D:\Scripts\Matrix"
```

### Option 3: Manual Installation
1. Download or clone this repository
2. Copy all `.ps1` files and `MatrixCommands.psm1` to your desired location
3. Add this line to your PowerShell profile (`$PROFILE`):
   ```powershell
   . "C:\path\to\MatrixCommands.psm1"
   ```
4. Reload your profile: `. $PROFILE`

### Finding Your Profile
```powershell
# Show profile path
$PROFILE

# Create profile if it doesn't exist
if (!(Test-Path $PROFILE)) { New-Item -Path $PROFILE -Force }

# Open profile in notepad
notepad $PROFILE
```

## Features

### Hacker Sequences
Terminal animations inspired by The Matrix trilogy:

| Command | Theme | Effect |
|---------|-------|--------|
| `hacker` | Mainframe | Quick access sequence |
| `hacker -Trace` | Trace | They're tracking you... |
| `hacker -Boot` | Boot | System initialization |
| `hacker -Deep` | Deep Dive | Layers, neural jack-in, red pill |
| `hacker -Infect` | Infection | Virus spread, containment breach |
| `hacker -Wake` | Awakening | Pod ejection, unplug |
| `hacker -Hunt` | Agent Hunt | Pursuit, evasion, escape |
| `hacker -Swarm` | Sentinels | Ship attack, EMP discharge |
| `hacker -One` | The One | Skill upload, power awakening |
| `hacker -Deja` | Deja Vu | Black cat, glitch in Matrix |
| `hacker -Exit` | Phone Exit | Trace vs escape countdown |
| `hacker -Train` | Training | Dojo sparring program |
| `hacker -Oracle` | Oracle | Cryptic prophecy |

### Matrix Rain Variants
Digital rain screensavers with different effects:

| Command | Effect |
|---------|--------|
| `matrix` | Classic green rain |
| `matrix -Katakana` | Japanese half-width Katakana characters |
| `matrix -Glitch` | Corrupted, flickering glitch effect |
| `matrix -Dead` | Skull slowly reveals in the rain |
| `matrix -One` | Freeze effect (Neo stops the bullets) |
| `matrix -Deja` | Stuttering columns (glitch in the Matrix) |
| `matrix -Oracle` | Cryptic messages fade in/out |
| `matrix -Train` | Grid construct (dojo training pattern) |

### Rabbit Holes
Complete experiences combining a hacker sequence with matching rain:

| Command | Journey |
|---------|---------|
| `whiterabbit` | Classic intro -> matrix rain |
| `blackrabbit` | Deep dive -> glitch matrix |
| `deadrabbit` | Infection -> skull matrix |
| `redrabbit` | Red pill -> awakening |
| `runrabbit` | Agent chase -> escape |
| `steelrabbit` | Sentinels -> EMP -> cyan matrix |
| `onerabbit` | The One -> freeze matrix |
| `glitchrabbit` | Deja vu -> stutter matrix |
| `exitrabbit` | Phone escape -> safe |
| `trainrabbit` | Dojo training -> grid matrix |
| `oraclerabbit` | Prophecy -> oracle matrix |

### Animated Intro
When you launch `neo`, you'll experience the iconic Matrix intro:
1. **"Wake up, Neo..."** - Typewriter messages fade in and out
2. **White Rabbit** - ASCII rabbit hops across your screen
3. **Digital Rain Burst** - Brief cascade of Matrix code
4. **"Knock, knock, Neo."** - Final message before menu

Press **Enter** at any time to skip the intro.

### Interactive Menu
Type `neo` to launch the Matrix Command Experience menu with:
- Animated intro sequence (press Enter to skip)
- Typewriter effect header animation
- All commands organized by category
- Operator Manual (`?`) to learn commands with themed "skill upload" presentation

## Usage

### Quick Start
```powershell
# Launch the interactive menu (with intro)
neo

# Skip the intro animation
neo -SkipIntro

# Run a hacker sequence directly
hacker -Wake

# Start matrix rain
matrix

# Full rabbit hole experience
whiterabbit
```

### Exiting Animations
- **Matrix rain**: Press any key to exit
- **Hacker sequences**: Press **Escape** at any time to exit
- **Intro sequence**: Press **Enter** to skip

### Customization

#### Speed
All matrix variants accept a `-Speed` parameter (default: 33ms):
```powershell
matrix -Speed 20        # Faster
matrix -Speed 50        # Slower
matrix -One -Speed 40   # Freeze effect, custom speed
```

#### Colors
The classic matrix function supports color options:
```powershell
matrix -Color Green    # Default
matrix -Color Cyan     # Machine aesthetic
matrix -Color Red      # Danger mode
matrix -Color Magenta  # Oracle vibes
```

## Troubleshooting

### Characters look wrong or garbled
- **Solution**: Use Windows Terminal with a Unicode-capable font
- Check your font supports: Japanese Katakana (ア, カ, サ) and block characters (█, ░)
- Try: Cascadia Code, Consolas, or any Nerd Font

### Colors don't display
- **Solution**: Use Windows Terminal instead of Command Prompt
- Ensure your terminal supports ANSI escape codes
- Try running: `$host.UI.SupportsVirtualTerminal` (should return `True`)

### Commands not found after installation
- Reload your profile: `. $PROFILE`
- Or restart your terminal
- Verify the module is loaded: `Get-Command neo`

### Animation is too slow/fast
- Adjust the `-Speed` parameter (lower = faster)
- Default is 33ms per frame

## File Structure
```
matrix-command-experience/
├── Install-MatrixCommands.ps1  # Installer script
├── MatrixCommands.psm1         # PowerShell module with all functions
├── matrix.ps1                  # Classic matrix rain engine
├── matrix-dead.ps1             # Skull reveal variant
├── matrix-deja.ps1             # Stuttering columns
├── matrix-katakana-glitch.ps1  # Glitchy effect
├── matrix-one.ps1              # Freeze effect
├── matrix-oracle.ps1           # Cryptic messages
├── matrix-train.ps1            # Grid construct
└── README.md                   # This file
```

## Technical Details
- Pure PowerShell (no external dependencies)
- ANSI escape codes for colors and cursor control
- StringBuilder for efficient frame rendering
- Half-width Katakana (0xFF66-0xFF9D) for authentic Matrix feel
- Screen buffer management for smooth animations

## Credits
- Created by **Sassy Labs**
- Built with Claude Code
- Inspired by The Matrix trilogy (Warner Bros.)

## License
MIT License - Feel free to use, modify, and distribute!

---

*"There is no spoon."*
