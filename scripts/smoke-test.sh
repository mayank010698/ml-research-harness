#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
if [[ $# -ne 1 ]]; then echo 'Usage: smoke-test.sh "<full smoke-check command>"' >&2; exit 2; fi
bash "$HARNESS_PROJECT_ROOT/scripts/validate-storage.sh"
# Marker is local to this particular worktree, not shared by default.
marker="$HARNESS_PROJECT_ROOT/.smoke-ok"
rm -f "$marker"
command=$1
printf 'Smoke command: %s\n' "$command"
bash -lc "$command"
sha=$(git -C "$HARNESS_PROJECT_ROOT" rev-parse HEAD)
printf 'sha=%s\ncommand=%s\ncompleted_utc=%s\n' "$sha" "$command" "$(date -u +%FT%TZ)" > "$marker"
echo 'Smoke command passed; marker recorded. Verify a short actual Slurm GPU smoke run separately.'
