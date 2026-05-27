#!/usr/bin/env bash
set -euo pipefail

CLAUDE="$HOME/.local/bin/claude"
FALLBACK="vault backup: $(date '+%Y-%m-%d %H:%M:%S')"

files="$(git diff --cached --name-only 2>/dev/null | head -30)"
[[ -z "$files" ]] && { printf '%s\n' "$FALLBACK"; exit 0; }

result="$(printf '%s' "$files" | \
    "$CLAUDE" --model claude-haiku-4-5-20251001 -p \
    "Write a single-line git commit message (max 72 chars, plain text, no quotes, no markdown) summarizing changes to these Obsidian vault files. Lead with a verb (e.g. 'update', 'add', 'edit'). Do not include a prefix like 'feat:' or 'chore:'." \
    2>/dev/null)" || true

printf '%s\n' "${result:-$FALLBACK}"
