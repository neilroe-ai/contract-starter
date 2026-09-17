# Architecture Decision Records (for client repos)

Numbered ADRs live here in a **client/contract repo**. (The template track's own conventions
use the case-law table in `../decisions.md` instead.)

Create this lazily — write the first ADR when a real decision earns one, not before.

## Does a decision deserve an ADR? All three must hold

1. **Hard to reverse** — the cost of changing your mind later is meaningful.
2. **Surprising without context** — a future reader will wonder "why on earth did they do it this way?"
3. **The result of a real trade-off** — there were genuine alternatives, and one was picked for reasons.

If it's easy to reverse, skip it (you'll just reverse it). If it's not surprising, nobody will
wonder why. If there was no real alternative, there's nothing to record.

## Format

`docs/adr/NNNN-short-slug.md`. The body is **1–3 sentences**: the context, the decision, the why.
Status, alternatives and consequences are optional and most ADRs won't need them. Never rewrite an
old ADR to hide history — a changed decision is a *new* ADR that supersedes it. The agent may remind
you an ADR is due; only the operator writes it.

Example:

```
# 0001 — Postgres over SQLite for the booking store

Bookings need concurrent writes from the webhook and the admin UI; SQLite's writer lock
would serialise them. Chose Postgres. Alternative (SQLite + queue) rejected as more moving
parts for the same guarantee.
```
