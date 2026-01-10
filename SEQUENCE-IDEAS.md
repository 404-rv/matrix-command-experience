# Matrix Rain Sequence Ideas

## Current Inventory

| Hacker Sequence | Rabbit Command | Matrix Variant | Status |
|-----------------|----------------|----------------|--------|
| `hacker` (basic) | `whiterabbit` | `matrix` (classic) | DONE |
| `hacker -Trace` | - | - | DONE |
| `hacker -Boot` | - | - | DONE |
| `hacker -Deep` | `blackrabbit` | `matrix -Glitch` | DONE |
| `hacker -Infect` | `deadrabbit` | `matrix -Dead` | DONE |
| `hacker -Wake` | `redrabbit` | `matrix` (classic) | DONE |
| `hacker -Hunt` | `runrabbit` | `matrix -Glitch` | DONE |
| `hacker -Swarm` | `steelrabbit` | `matrix -Color Cyan` | DONE |
| `hacker -One` | `onerabbit` | `matrix -One` (freeze) | DONE |
| `hacker -Deja` | `glitchrabbit` | `matrix -Deja` (stutter) | DONE |
| `hacker -Exit` | `exitrabbit` | `matrix` (classic) | DONE |
| `hacker -Train` | `trainrabbit` | `matrix -Train` (grid) | DONE |
| `hacker -Oracle` | `oraclerabbit` | `matrix -Oracle` (messages) | DONE |

## Matrix Rain Variants

| Variant | File | Effect |
|---------|------|--------|
| Classic | `matrix.ps1` | Green digital rain |
| Katakana | `matrix.ps1 -Katakana` | Japanese characters |
| Glitch | `matrix-katakana-glitch.ps1` | Corrupted/flickering |
| Dead | `matrix-dead.ps1` | Skull reveal |
| **One** | `matrix-one.ps1` | Freeze effect (Neo stops bullets) |
| **Deja** | `matrix-deja.ps1` | Stuttering columns (reality glitch) |
| **Oracle** | `matrix-oracle.ps1` | Cryptic messages fade in/out |
| **Train** | `matrix-train.ps1` | Grid construct (dojo pattern) |

---

## Planned Sequences

### 1. Awakening / Unplugged - COMPLETED
**Theme:** Pod ejection sequence, waking up in the real world
**Status:** ✅ Implemented as `hacker -Wake` + `redrabbit`

---

### 2. Agent Hunt - COMPLETED
**Theme:** Being pursued by Agents
**Status:** ✅ Implemented as `hacker -Hunt` + `runrabbit`

---

### 3. The One Protocol - COMPLETED
**Theme:** Neo realizing his power
**Status:** ✅ Implemented as `hacker -One` + `onerabbit`

---

### 4. Sentinel Attack - COMPLETED
**Theme:** Machine swarm attack on ship
**Status:** ✅ Implemented as `hacker -Swarm` + `steelrabbit`

---

### 5. Phone Trace (Escape) - COMPLETED
**Theme:** Race to reach the exit
**Status:** ✅ Implemented as `hacker -Exit` + `exitrabbit`

---

### 6. Glitch / Deja Vu - COMPLETED
**Theme:** Reality hiccup
**Status:** ✅ Implemented as `hacker -Deja` + `glitchrabbit`

---

### 7. Architect / Oracle - COMPLETED
**Theme:** Cryptic prophecy/choice
**Status:** ✅ Implemented as `hacker -Oracle` + `oraclerabbit`

---

### 8. Training Program / Dojo - COMPLETED
**Theme:** Combat training simulation
**Status:** ✅ Implemented as `hacker -Train` + `trainrabbit`

---

## Build Priority - ALL COMPLETE! ✅

1. ~~**Awakening** - Great contrast to current "death" sequences~~ ✅ DONE
2. ~~**Agent Hunt** - High tension, action-oriented~~ ✅ DONE
3. ~~**The One** - Iconic Matrix moment~~ ✅ DONE
4. ~~**Glitch/Deja Vu** - Quick win, reuses glitch code~~ ✅ DONE
5. ~~**Sentinel Attack** - Dramatic, different aesthetic~~ ✅ DONE
6. ~~**Phone Trace** - Classic escape tension~~ ✅ DONE
7. ~~**Training/Dojo** - Fun callback~~ ✅ DONE
8. ~~**Oracle** - More philosophical, lower priority~~ ✅ DONE

---

## SOP for Building

1. Create hacker sequence first (`hacker -Flag`)
2. Test standalone
3. Create rabbit command that uses sequence + launches matrix
4. Create matrix variant if needed (new .ps1 file)
5. Update `neo` menu
6. Update `commands` help
7. Test full flow

---

## Notes

- All sequences should work in Windows PowerShell 5.1
- Use ASCII characters for borders (not Unicode box-drawing)
- Unicode OK for progress bars ([char]0x2588, [char]0x2591)
- Keep sequences 10-20 seconds before Matrix launch
- Test with `. $PROFILE` after each change
