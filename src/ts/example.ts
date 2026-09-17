// One real, typed function so the JS/TS gates have something to check.
// Replace with the contract's actual code; keep it fully typed.

export function slugify(text: string): string {
  return text
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}
