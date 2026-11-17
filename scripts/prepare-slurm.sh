#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
bash "$HARNESS_PROJECT_ROOT/scripts/validate-storage.sh"
: "${SLURM_LOG_ROOT:?Set SLURM_LOG_ROOT}"
mkdir -p -- "$SLURM_LOG_ROOT"
echo "Ready: $SLURM_LOG_ROOT"
