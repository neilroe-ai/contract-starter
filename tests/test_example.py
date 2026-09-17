"""Expected values come from an independent source (worked examples), never
recomputed the way the code does — a tautological test can never disagree
with the code (workflow-v1 §4)."""

from contract_starter.example import slugify


def test_slugify_basic() -> None:
    assert slugify("Hello World") == "hello-world"


def test_slugify_trims_and_collapses() -> None:
    assert slugify("  Mu Surf --  Bodyboards!  ") == "mu-surf-bodyboards"


def test_slugify_empty() -> None:
    assert slugify("   ") == ""
