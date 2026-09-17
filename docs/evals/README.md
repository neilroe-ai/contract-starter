# Evals — measurement files for judgment-gated changes

Unit tests prove the code does what you coded. They **cannot** prove the change is a good idea.
A filter that passes every test can still be dead on arrival against real data.

So: some changes need a measurement, not just a green suite. **A change with no measurement
file here is not verified.**

## When a change is judgment-gated

Trigger on: changed defaults, thresholds or filters; anything that drops, transforms or reorders
upstream data; billing or quota logic; any assumption about how real-world data behaves.
*If unsure whether a change qualifies, it qualifies.*

## What a measurement file records

`docs/evals/YYYY-MM-DD-<focus>.md`:

- The assumptions, split into *verified* vs *merely plausible*.
- 10–20 realistic live cases with hard numbers (not unit tests).
- Human sign-off for anything client-visible.
- A re-measurement on real traffic within a day of shipping.

This is the "correct, not just green" gate. For client work it's the important one — the
expensive failure is a feature that works and is wrong.
