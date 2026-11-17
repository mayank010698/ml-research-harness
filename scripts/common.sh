#!/usr/bin/env bash
set -euo pipefail
HARNESS_PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
if [[ -f "$HARNESS_PROJECT_ROOT/.env" ]]; then
  set -a
  # .env must be a trusted shell-compatible file.
  source "$HARNESS_PROJECT_ROOT/.env"
  set +a
fi
