#!/usr/bin/env bash
# Bootstrap a fresh git worktree for one task = one worktree = one agent session.
# The #1 failure is gitignored files silently missing — a fresh worktree has only
# TRACKED files. So we copy .env (never symlink it) and install deps here.
#
# A worktree separates checkouts; it is NOT an execution or security sandbox.
set -euo pipefail

BRANCH="${1:?usage: scripts/setup-worktree.sh <branch-name>}"
ROOT="$(git rev-parse --show-toplevel)"
DEST="${ROOT}/../$(basename "$ROOT")-${BRANCH}"

git worktree add -b "$BRANCH" "$DEST"

# Copy env (copy, never symlink — an agent editing a symlinked .env corrupts the original).
[ -f "${ROOT}/.env" ] && cp "${ROOT}/.env" "${DEST}/.env" && echo "copied .env"

# Install deps in the new worktree (never symlink node_modules — bundlers refuse to resolve it).
cd "$DEST"
[ -f pyproject.toml ] && command -v uv >/dev/null && uv sync
[ -f package.json ]  && command -v npm >/dev/null && npm install

echo "worktree ready at: $DEST"
echo "review/merge/push happen in the primary checkout ($ROOT), which stays on the main branch."
