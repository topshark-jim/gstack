#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

python3 - <<'PY'
from pathlib import Path

skills = sorted(path.parent.name for path in Path("skills").glob("*/SKILL.md"))
expected = [
    "browse",
    "plan-ceo-review",
    "plan-eng-review",
    "retro",
    "review",
    "ship",
]
if skills != expected:
    raise SystemExit(f"expected skills {expected}, got {skills}")
PY

forbidden_agent='cl''aude'
forbidden_hidden='\.cl''aude'
forbidden_question='Ask''UserQuestion'
if rg -n -i "${forbidden_agent}|${forbidden_hidden}|${forbidden_question}" skills README.md >/tmp/gstack-forbidden.txt; then
  cat /tmp/gstack-forbidden.txt
  exit 1
fi

npx -y skills add "$ROOT" --list >/tmp/gstack-skills-list.txt
cat /tmp/gstack-skills-list.txt

for skill in browse plan-ceo-review plan-eng-review retro review ship; do
  if ! rg -q "(^|[^[:alnum:]-])$skill($|[^[:alnum:]-])" /tmp/gstack-skills-list.txt; then
    echo "missing skill in discovery output: $skill"
    exit 1
  fi
done
