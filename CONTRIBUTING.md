# Contributing to Matrix Command Experience

Thank you for your interest in contributing to Matrix Command Experience! This document provides guidelines and instructions for contributing.

## Code of Conduct

Be respectful and constructive in all interactions. We're all here because we love The Matrix and PowerShell.

## How to Contribute

### Reporting Bugs

1. Check existing issues to avoid duplicates
2. Use the bug report template
3. Include your PowerShell version (`$PSVersionTable.PSVersion`)
4. Specify which terminal you're using (Windows Terminal recommended)
5. Include steps to reproduce the issue

### Suggesting Features

1. Check existing issues and discussions
2. Use the feature request template
3. Describe the problem you're trying to solve
4. If suggesting a new effect, reference the Matrix scene that inspired it!

### Submitting Code

#### Getting Started

1. Fork the repository
2. Clone your fork:
   ```powershell
   git clone https://github.com/YOUR-USERNAME/matrix-command-experience.git
   cd matrix-command-experience
   ```
3. Create a feature branch:
   ```powershell
   git checkout -b feature/your-feature-name
   ```

#### Development Guidelines

##### Code Style

- Use consistent indentation (4 spaces)
- Use descriptive variable names
- Comment complex logic
- Follow PowerShell best practices

##### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Functions | Verb-Noun | `Show-MatrixRain` |
| Private functions | Verb-NounPrivate | `Write-FramePrivate` |
| Variables | $camelCase | `$frameBuffer` |
| Constants | $UPPER_CASE | `$DEFAULT_SPEED` |

##### Animation Guidelines

- Default speed: 33ms per frame
- Support `-Speed` parameter for customization
- Use StringBuilder for frame buffer efficiency
- Clear screen using ANSI codes: `[Console]::Write("$([char]27)[2J$([char]27)[H")`
- Support graceful exit on Escape key

##### Color Reference

```powershell
$ESC = [char]27
"$ESC[32m"  # Green (classic Matrix)
"$ESC[36m"  # Cyan (machine/sentinel)
"$ESC[31m"  # Red (danger)
"$ESC[35m"  # Magenta (Oracle)
"$ESC[97m"  # White (highlight)
"$ESC[90m"  # Dark gray (trails)
"$ESC[0m"   # Reset
```

#### Testing Your Changes

1. Test in Windows Terminal (primary target)
2. Test in PowerShell 5.1 and PowerShell 7+
3. Verify animations display correctly
4. Check for performance issues
5. Ensure graceful exit works

```powershell
# Import your modified module
Import-Module ./MatrixCommands.psm1 -Force

# Test your changes
neo
matrix
hacker -Wake
```

#### Submitting a Pull Request

1. Ensure your code follows the style guidelines
2. Update documentation if needed
3. Commit with clear messages:
   ```
   feat: add new Architect matrix variant
   fix: resolve flickering on large terminals
   docs: update README with new command
   ```
4. Push to your fork and create a PR
5. Fill out the PR template completely

### Creating New Effects

#### New Matrix Rain Variant

1. Create a new file: `matrix-yourvariant.ps1`
2. Follow the structure of existing variants
3. Export the function in `MatrixCommands.psm1`
4. Add to the `matrix` command switch
5. Document in README

Template:
```powershell
function Show-MatrixYourVariant {
    param(
        [int]$Speed = 33
    )

    # Your animation logic here
    # Use StringBuilder for performance
    # Support Escape key exit
}
```

#### New Hacker Sequence

1. Add to `MatrixCommands.psm1` in the hacker sequences section
2. Create a new switch parameter
3. Add typewriter messages themed to your sequence
4. Document in README

#### New Rabbit Hole

1. Combine a hacker sequence with a matrix variant
2. Add as a new function in `MatrixCommands.psm1`
3. Export the function
4. Document in README

## Questions?

- Open a Discussion for general questions
- Check the README troubleshooting section
- Look at existing code for examples

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

*"Free your mind."*
