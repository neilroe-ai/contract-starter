# Decisions — case law

This template's own conventions, as a table of what was admitted or rejected, with a
reason and a date. Reversals sit next to what they reversed (they don't get hidden in a
separate file). Cheaper to scan than numbered ADRs, and it makes changes of mind visible.

**Client repos use numbered ADRs instead** (`docs/adr/`) — the more familiar handover format.
This case-law table is for the template track's own conventions.

## Admissibility test

Every proposed addition to this template must answer:

1. **Does it improve the *surface* or the *loop*, and what does it cost per change?**
   Surface (files a stranger reads cold) is paid once per repo — spend generously. Loop
   (ceremony per change) is taxed on every change forever — stay mean.
2. Is it already enforced by a check, type, or config? If so it doesn't belong in prose.
3. Before adding machinery, is there machinery to delete?

## Case law

| Date | Decision | Verdict | Why |
|---|---|---|---|
| 2026-09-16 | **B for the surface, A for the loop; §4 risk taxonomy as the only escalator** | ✅ admitted | Handover correctness is a property of the artifact (paid once/repo); solo speed is a property of the per-change loop (taxed forever). Passes all three ADR tests: hard to reverse, surprising without context, a real trade-off. |
| 2026-09-16 | **One template, not two** (no service/pipeline split) | ✅ admitted | A second shape is a standing "which shape is this?" question at the top of every contract — loop cost levied on every engagement. Earns itself the first time a real contract can't start from this one. |
| 2026-09-16 | **AGENTS.md canonical; CLAUDE.md is a one-line pointer** | ✅ admitted | One source of truth written to the open convention. Pointer over symlink: survives Windows checkouts and explains itself to a cold reader. Direction stated at top of AGENTS.md so the setup skill reads it, not guesses. |
| 2026-09-16 | **Python + JS/TS toolchain from the start** | ✅ admitted | ruff (lint+format) + mypy (strict) + pytest; biome (lint+format) + tsc (strict) + vitest. Both shipped now per operator decision; JS layer is surface, paid once. |
| 2026-09-16 | **mypy strict from the start** | ✅ admitted | Strict is cheap on greenfield code and dear to retrofit. Relax per-module if it bites; record the relaxation here. |
| 2026-09-16 | **Editor-on-save + one pre-commit hook (format, lint, types, fast tests). No CI until a 2nd contributor or a deploy** | ✅ admitted | A gate point is loop cost. CI on a one-person, no-deploy repo buys a slower commit and a badge. README states what is and isn't checked, so the thin loop is honest, not hidden. |
| 2026-09-16 | **Extend the installed git-guardrails hook; don't write a second** | ✅ admitted | Two PreToolUse hooks on the Bash matcher collide. The deployed copy names the wanted behaviour (not just the ban) and parses JSON with python3 (no jq dependency). |

## How this file stays honest

Entries are phrased so drift is catchable. A periodic pass grades each confirmed or drifted;
**drifted entries are deleted, not annotated — a stale correction is worse than none.** Facts
that change (counts, paths, versions) don't belong here at all — point at the owning source.
An agent may *propose* an entry from a real run; promotion into this file is always an operator edit.
