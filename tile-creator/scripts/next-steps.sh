#!/usr/bin/env python3
"""Inspect a tile and output JSON with recommended next steps."""

import json
import os
import sys


def main():
    if len(sys.argv) < 2:
        print(json.dumps({"error": "Usage: next-steps.sh <path-to-tile>"}), file=sys.stderr)
        sys.exit(1)

    tile_path = sys.argv[1]
    tile_json_path = os.path.join(tile_path, "tile.json")

    if not os.path.isfile(tile_json_path):
        print(json.dumps({"error": f"No tile.json found at {tile_path}"}), file=sys.stderr)
        sys.exit(1)

    with open(tile_json_path) as f:
        tile = json.load(f)

    skills = tile.get("skills", {})
    has_skills = bool(skills)
    steps = []

    if has_skills:
        review_cmds = []
        for name, val in skills.items():
            skill_path = val.get("path", "")
            if skill_path:
                skill_dir = os.path.dirname(os.path.join(tile_path, skill_path))
                review_cmds.append(f"tessl skill review {skill_dir}")

        steps.append({
            "step": 1,
            "action": "review",
            "description": "Run skill review and optimize based on feedback",
            "commands": review_cmds,
            "details": "Review scores description and content quality with actionable suggestions. Iterate: run review, apply suggestions, re-run until scores are satisfactory.",
        })

    steps.append({
        "step": len(steps) + 1,
        "action": "evals",
        "description": "Generate and run eval scenarios",
        "commands": [
            f"tessl scenario generate {tile_path}",
            f"tessl scenario download <generation-id> --output {tile_path}/evals",
            f"tessl eval run {tile_path}",
        ],
        "details": "Generate eval scenarios, download them, review for correctness and coverage, then run to verify the tile behaves as expected.",
    })

    result = {
        "tile": tile_path,
        "has_skills": has_skills,
        "next_steps": steps,
    }
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
