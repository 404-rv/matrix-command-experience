# Changelog

All notable changes to Matrix Command Experience will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Issue templates (bug report, feature request, question)
- Pull request template
- GitHub Actions workflow for PowerShell validation
- CONTRIBUTING.md with development guidelines
- This CHANGELOG.md

## [1.0.0] - 2026-01-16

### Added
- Initial release of Matrix Command Experience
- **Hacker Sequences**: 12 themed terminal animations
  - Boot, Trace, Deep Dive, Infection, Awakening
  - Agent Hunt, Sentinels, The One, Deja Vu
  - Phone Exit, Training, Oracle
- **Matrix Rain Variants**: 8 digital rain effects
  - Classic, Katakana, Glitch, Dead (skull)
  - One (freeze), Deja (stutter), Oracle, Train (grid)
- **Rabbit Holes**: 11 complete experiences
  - whiterabbit, blackrabbit, deadrabbit, redrabbit
  - runrabbit, steelrabbit, onerabbit, glitchrabbit
  - exitrabbit, trainrabbit, oraclerabbit
- **Interactive Menu** (`neo` command)
  - Animated intro sequence
  - Typewriter effect header
  - Operator manual with skill upload presentation
- **Installation Options**
  - Quick installer script
  - Custom path support
  - Manual installation guide
- **Customization**
  - Speed parameter for all animations
  - Color options for classic matrix

### Technical
- Pure PowerShell implementation (no external dependencies)
- ANSI escape codes for colors and cursor control
- StringBuilder for efficient frame rendering
- Half-width Katakana character support
- Windows Terminal optimized

---

*"The Matrix has you..."*
