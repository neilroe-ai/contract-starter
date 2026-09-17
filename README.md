# contract-starter

A repeatable engineering setup to drop onto a new contract on day one. Python + TypeScript,
gated by one pre-commit hook, with agent guidance and decision records built in.

The point of this repo is that a stranger — or you in four months — can pick it up cold.

## Quick start

```bash
just setup     # install Python (uv) + JS/TS (npm) dev deps
just check     # lint + typecheck + test — the gate before every commit
just --list    # every command this repo can run
```

Optional but recommended:

```bash
pip install pre-commit && pre-commit install   # run the gate automatically on commit
cp .env.example .env                            # then fill in real values (.env is gitignored)
```

## What is checked — and what is not

Honesty matters more than looking thorough. Right now:

| Check | Runs on | Enforced by |
|---|---|---|
| Format (ruff, biome) | commit + `just fmt` | pre-commit hook |
| Lint (ruff, biome) | commit + `just lint` | pre-commit hook |
| Types (mypy strict, tsc strict) | commit + `just typecheck` | pre-commit hook |
| Tests (pytest, vitest) | `just test` / `just check` | you, before commit |

**Not checked (on purpose):**

- **No CI.** There is no `.github/workflows/`. On a solo, no-deploy repo, CI buys a slower commit and a
  badge. Add it the moment there's a second contributor or a deploy — and update this table in the same commit.
- **Tests are not in the pre-commit hook** (only format/lint/types are, to keep commits fast). `just check`
  runs them; run it before you commit. If that discipline slips, move `pytest`/`vitest` into the hook.
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
.pre-commit-config.yaml   the one hook
src/ , tests/             one real typed example per language + its tests
.env.example              the only committed env file
```

## Skills this repo leans on

It doesn't reimplement what's already installed. It points at `grilling`, `tdd`, `code-review`,
`handoff`, `diagnosing-bugs`, `writing-for-agents`, `archify`, and `git-guardrails-claude-code`.
See `AGENTS.md` → "Find current facts".
