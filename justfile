# Every command this repo can run. The commands AGENTS.md claims work are these.
# `just` with no target lists them.

default:
    @just --list

# Install Python + JS/TS dev dependencies.
setup:
    uv sync
    npm install

# Format everything (Python + JS/TS).
fmt:
    uv run ruff format .
    npm run fmt

# Lint (no writes) — fails on findings.
lint:
    uv run ruff check .
    npm run lint

# Type-check both languages (mypy strict + tsc).
typecheck:
    uv run mypy
    npm run typecheck

# Run all tests.
test:
    uv run pytest
    npm test

# The gate: what must be green before a commit. Mirrors the pre-commit hook.
check: lint typecheck test

# Create an isolated worktree for one task (see scripts/setup-worktree.sh).
worktree branch:
    ./scripts/setup-worktree.sh {{branch}}
