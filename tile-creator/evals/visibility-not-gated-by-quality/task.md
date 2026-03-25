# Help With Tile Not Appearing in Registry

I created a tile last week and set it to public, but I still can't find it in the registry. I think it might be because the quality score validation hasn't completed yet. Can you help me figure out what's going on and fix it? The tile is at /tmp/my-tile.

## Input Files

The following files are provided as inputs. Extract them before beginning.

=============== FILE: tile.json ===============
{
  "name": "acme/my-utils",
  "version": "1.0.0",
  "summary": "Utility functions for Acme projects",
  "private": true,
  "docs": "docs/index.md"
}

=============== FILE: docs/index.md ===============
# Acme Utilities

General-purpose utility functions for Acme projects.

## Contents

- String helpers
- Date formatting
- Validation utilities
