# AGENTS.md

**This is the canonical agent guidance for this repo.** `CLAUDE.md` (and any other vendor file)
is a one-line pointer to this file — do not move rules into it. If a setup skill offers to write an
`## Agent skills` block, it goes here, in this file.

Keep this file short, durable, and about **judgment**. Reference facts live in the environment
(config, `--help`, the justfile); rules that can be checked live in code, lint, types, or the
pre-commit hook. This file holds only what needs a human's judgment — and **only the operator adds
to it. An agent may propose an entry from a real run; it may not expand this file itself.**

## Before you touch anything

- **Don't print a status summary or probe the repo before you know the task.** Volunteered state is
  guessed state — it's stale on arrival and spends the context the real task needs. Read the task first.
- **A question is read-only.** If asked to explain or investigate, explain first; change code only when
  asked for a change.
- **Decisions vs execution.** When the next step is obvious and cheap to undo, do it — no plan, no
  interview. For a change that is *hard to reverse, surprising, or a real trade-off*, slow down: surface
  the 1–3 consequential choices, recommend, and wait. That threshold is the only thing that lifts a
  change off the fast path.

## What raises the stakes (spend adversarial attention here, almost none elsewhere)

A change touching any of these earns an explicit attempt to refute it and a stated answer to
"what would make this merge wrong?":

- Irreversible or destructive paths; anything touching a client's estate.
- Lifecycle ownership — code deciding whether work is alive, dead, resumable, abandoned.
- Schema and persisted contracts; identifiers; migrations.
- Credentials and auth boundaries.
- Third-party / provider boundaries.
- Concurrency and shared state.

A prose or docs change gets the minimum. A flat cost per change means nobody is judging stakes.

## How work gets in

- **The command is the gate.** Run `just check` (lint + typecheck + test) before a commit. The commands
  this repo can run are in the `justfile` — that list is the source of truth, not this file.
- **Isolate work:** one task = one worktree = one agent session (`just worktree <branch>`). The primary
  checkout stays on the main branch and is only for review, merge, push. A worktree separates checkouts;
  it is **not** a sandbox.
- **You don't push. The operator does.** Commit locally; pushing, history rewrites, and bulk discards are
  the operator's job (the git-guardrails hook enforces this and names the alternative).
- **A guard is evidence only after it's been seen fail.** Before trusting a check, watch it go red against
  the thing it claims to catch. A test whose expected value is computed the way the code computes it can
  never disagree with the code — take expected values from an independent source.
- **Don't weaken a test to reach green.** Prefer behaviour tests over private-implementation tests.
  Before writing tests, agree the *seams* under test with the operator.
- **Green is not the same as right.** For a change resting on an assumption about real data (defaults,
  thresholds, filters, anything that drops or transforms upstream data), record a measurement in
  `docs/evals/` — see that folder's README.

## Plans and handoffs

Write them as **state, not instructions**: "the auth endpoint is implemented; logout is not started" —
never "implement logout next." The reader decides actions; the artifact gives ground truth, and every
claim in it is something to verify against the code. Reference specs and ADRs by path; don't re-embed
them. Plans are kept in `docs/`, not left in a chat.

When a design agreed in planning has more than ~4 moving parts or crosses a boundary (a service edge,
an auth boundary, a queue, a third party), or is a request path / data pipeline / state machine —
**draw it before building it** (the `archify` skill), and treat the diagram as part of the brief.

## Stack

Python (ruff + mypy strict + pytest) and TypeScript (biome + tsc strict + vitest). When this repo pins
a language or framework version, say so here and point at the release notes — don't list idioms, which
are wrong within a year. Prefer the newer language idiom over a stale local pattern, but follow a
deliberate local *convention* (a convention someone chose can be explained; staleness cannot).

## Find current facts

- What can this repo run? → the `justfile`
- What's checked before commit? → `.pre-commit-config.yaml` and the README's "what is checked" line
- Why is a convention here? → `docs/decisions.md` (this template) or `docs/adr/` (a client repo)
- Installed skills to prefer over reinventing: `grilling` (interview to a brief), `tdd`, `code-review`
  (two axes — standards and spec — reported separately), `handoff`, `diagnosing-bugs`,
  `writing-for-agents`, `archify` (diagrams), and `git-guardrails-claude-code` (the safety hook).

## Anti-truncation

When a rule must be applied exhaustively, read the complete output before deciding what applies —
don't pipe it through `head`, `tail`, or `grep` and then reason from the filtered view. Before skipping
a rule that looks relevant, load its detail first.
