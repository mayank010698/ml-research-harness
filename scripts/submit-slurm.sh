#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
if [[ $# -lt 1 ]]; then echo 'Usage: submit-slurm.sh <job.sbatch> [sbatch args...]' >&2; exit 2; fi
job=$1; shift
bash "$HARNESS_PROJECT_ROOT/scripts/prepare-slurm.sh"
[[ -f "$job" ]] || { echo "Missing Slurm script: $job" >&2; exit 1; }
if grep -Eq 'TEMPLATE: replace this line|^#SBATCH --(output|error)' "$job"; then
  echo 'Remove template command and hard-coded log directives before submitting. External paths are supplied by this wrapper.' >&2
  exit 1
fi
marker="$HARNESS_PROJECT_ROOT/.smoke-ok"
[[ -f "$marker" ]] || { echo 'Missing successful worktree smoke marker; run scripts/smoke-test.sh first.' >&2; exit 1; }
sha=$(git -C "$HARNESS_PROJECT_ROOT" rev-parse HEAD)
grep -Fxq "sha=$sha" "$marker" || { echo 'Smoke marker is from a different commit.' >&2; exit 1; }
if [[ -n "$(git -C "$HARNESS_PROJECT_ROOT" status --porcelain --untracked-files=no)" ]]; then
  echo 'Working tree has uncommitted tracked changes. Commit intentional changes before launching.' >&2
  exit 1
fi
# An independent Slurm smoke GPU job is still required; this script cannot verify it automatically.
printf 'Job script: %s\nSHA: %s\nExternal logs: %s\n' "$job" "$sha" "$SLURM_LOG_ROOT"
printf 'Confirm actual short Slurm GPU smoke test completed and GPU/time budget is approved. Type SUBMIT: '
read -r confirmation
[[ "$confirmation" == SUBMIT ]] || { echo 'Cancelled.'; exit 1; }
# Slurm's --output path is resolved by sbatch at submission. Directory already exists.
result=$(sbatch --parsable --output="$SLURM_LOG_ROOT/%x-%j.out" --error="$SLURM_LOG_ROOT/%x-%j.err" "$@" "$job")
echo "Submitted Slurm job: $result"
echo 'Record the job ID, SHA, run config, and W&B ID in the experiment record.'
