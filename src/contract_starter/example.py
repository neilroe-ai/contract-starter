"""One real, typed function so the gates have something to check.

Replace this with the contract's actual code; keep it fully typed.
"""


def slugify(text: str) -> str:
    """Lowercase, trim, and hyphenate a string into a URL-safe slug."""
    cleaned = [c.lower() if c.isalnum() else "-" for c in text.strip()]
    slug = "".join(cleaned)
    while "--" in slug:
        slug = slug.replace("--", "-")
    return slug.strip("-")
