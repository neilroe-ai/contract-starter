# contract-starter

A repeatable engineering setup to drop onto a new contract on day one. Python + TypeScript,
gated by the machine-wide git hooks, with agent guidance and decision records built in.

The point of this repo is that a stranger — or you in four months — can pick it up cold.

## Quick start

```bash
just setup     # install Python (uv) + JS/TS (npm) dev deps
just check     # lint + typecheck + test — the gate before every commit
just --list    # every command this repo can run
```

Optional but recommended:

```bash
cp .env.example .env   # then fill in real values (.env is gitignored)
```

⛔ **Do not `pip install pre-commit`, and never re-add `.pre-commit-config.yaml`.**
This repo's commit gate is the machine-wide hook system in `~/.githooks`; a
`.pre-commit-config.yaml` sets a local `core.hooksPath` and disarms it. The one
that used to live here named ruff, mypy and biome and never ran once, because the
binary was never installed. What this repo declares is in `.guardrails`, and
`sh ~/.githooks/doctor .` reports what is actually armed.

## What is checked — and what is not

Honesty matters more than looking thorough. Right now:

| Check | Runs on | Enforced by |
|---|---|---|
| Secrets, real data, keys | every commit | `~/.githooks` layer 1 — never skippable |
| Lint (ruff, biome), on staged files | every commit | `.guardrails` `commit=` |
| Tests (pytest, vitest) | every push | `.guardrails` `push=` |
| Format, types | `just fmt` / `just typecheck` / `just check` | you, before commit |

**Not checked (on purpose):**

- **No CI.** There is no `.github/workflows/`. On a solo, no-deploy repo, CI buys a slower commit and a
  badge. Add it the moment there's a second contributor or a deploy — and update this table in the same commit.
- **Tests are not in the commit gate** — they run at push, to keep commits fast. `just check` runs the
  lot; run it before you commit. Move a check between `commit=` and `push=` in `.guardrails`, not into a
  new hook.
- **Format and types are not gated at all yet.** `just check` runs them and nothing stops a commit that
  skips it. Add them to `.guardrails` `commit=` when that discipline slips — and update this table in the
  same commit.
- **`docs/adr/` and `docs/evals/` are created lazily** — they hold a README until the first real entry.
- The example `slugify` in `src/` exists only to give the gates something real to check. Delete it when
  the contract's real code lands.

## Layout

```
AGENTS.md                 canonical agent guidance (CLAUDE.md is a one-line pointer)
justfile                  every command the repo can run
docs/decisions.md         case-law table — this template's own conventions
docs/adr/                 numbered ADRs — for a client repo (lazy)
docs/evals/               measurement files for judgment-gated changes (lazy)
scripts/setup-worktree.sh bootstrap a fresh worktree (copies .env, installs deps)
pyproject.toml            ruff + mypy(strict) + pytest config
package.json / biome.json / tsconfig.json   biome + tsc(strict) + vitest config
.guardrails               what ~/.githooks runs here, at commit and at push
src/ , tests/             one real typed example per language + its tests
.env.example              the only committed env file
```

## Skills this repo leans on

It doesn't reimplement what's already installed. It points at `grilling`, `tdd`, `code-review`,
`handoff`, `diagnosing-bugs`, `writing-for-agents`, `archify`, and `git-guardrails-claude-code`.
See `AGENTS.md` → "Find current facts".
