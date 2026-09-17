import { describe, expect, it } from "vitest";
import { slugify } from "../src/ts/example.js";

describe("slugify", () => {
  it("hyphenates words", () => {
    expect(slugify("Hello World")).toBe("hello-world");
  });

  it("trims and collapses separators", () => {
    expect(slugify("  Mu Surf --  Bodyboards!  ")).toBe("mu-surf-bodyboards");
  });

  it("handles empty input", () => {
    expect(slugify("   ")).toBe("");
  });
});
