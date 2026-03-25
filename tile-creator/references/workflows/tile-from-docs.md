## Creating Tiles from Existing Context or Documentation

For creating new tiles that are based on already existing context, such as documentation, other tiles, agent .md and .mdc files, etc.

### Workflow

1. **Study the content**: Read the existing context that the user wants to transform into a tile. Plan how to restructure and enhance into agent-efficient tile(s). Determine content type using the decision checklist in SKILL.md: docs, skills, or rules (usually just one). Decide on an **absolute output path** and use it for all subsequent operations.

2. **Create structure**: Use the scaffolding method from SKILL.md (MCP tool or CLI) with your absolute output path.

3. **Copy existing content into tile structure**: Copy and rename existing files into the scaffolded directories. Do NOT rewrite content — move files first, then edit in place.

4. **Read the relevant format references**: Familiarise yourself with the relevant format(s):
   - **Docs format**: See ../docs-format.md
   - **Rules format**: See ../rules-format.md
   - **Skills format**: See ../skills-format.md

5. **Edit copied files in place**: Modify the already-copied files to match the required format. Do NOT rewrite from scratch — make targeted edits for clarity, structure, and agent efficiency. Write new markdown files only where gaps exist.

6. **Set visibility**: Ask the user whether this tile should be public (discoverable by anyone) or private (workspace-only). The default is private. To make it public, set `"private": false` in tile.json or use the `--public` CLI flag. Visibility is a manual setting — it is not gated by quality score or any review process.

7. **Validate and interpret lint output**:
   ```bash
   tessl tile lint /absolute/path/to/tile
   ```

   **Interpreting results:**
   - **Errors** (must fix): missing tile.json fields, unreachable markdown files, invalid frontmatter
   - **Warnings** (evaluate case-by-case): broken links to source code files (e.g., `src/lib/foo.ts`) are expected in documentation tiles — they reference code in the documented repo, not the tile itself. Safely ignored.
   - **Token counts**: informational, no action needed unless unusually high

   Fix errors, re-run lint until errors are resolved. Report remaining warnings to the user with explanation.

8. **Next steps**: After the tile passes lint, create a `next-steps.sh` script in the tile root that runs quality checks for this tile. The script should:
   - Run `tessl skill review <path-to-skill>` for each skill in the tile (skip if no skills)
   - Run `tessl scenario generate <tile-path>` to generate eval scenarios
   - Run `tessl eval run <tile-path>` to evaluate the tile

   Make the script executable. Tell the user to review it and run it when ready.

### Tile Structure

```
my-tile/
├── tile.json
├── docs/           # Documentation (optional)
│   └── index.md
├── rules/          # Rules/steering (optional)
│   └── my-rule.md
└── skills/         # Skills (optional)
    └── my-skill/
        └── SKILL.md
```
