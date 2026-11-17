---
name: submit-slurm
description: Safely prepare and submit a reviewed Slurm experiment job with external logging.
disable-model-invocation: true
---

1. Identify exact branch, clean pinned SHA, config, data/encoder version and W&B project/group.
2. Run storage validation and ensure external `SLURM_LOG_ROOT` exists.
3. Inspect the job script: cluster/account/partition, GPU count, memory, walltime, job name, stdout/stderr, and module/conda setup. Substitute real path values; do not submit placeholders.
4. Confirm a completed real smoke job, not just `sbatch --test-only`.
5. Show the full command, estimated GPU-hours, and paths. Obtain user approval; do not approve on the user's behalf.
6. Prefer `bash scripts/submit-slurm.sh <job-script> [args...]` which requires a smoke marker and terminal confirmation.
7. Parse returned job ID from Slurm's output, record job ID and W&B ID, monitor completion, and summarize outcome.
