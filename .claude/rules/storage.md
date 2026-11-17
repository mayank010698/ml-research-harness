# Storage policy

- Use `DATA_ROOT`, `MODEL_ROOT`, `OUTPUT_ROOT`, `SLURM_LOG_ROOT` from `.env` or exported environment.
- They must be absolute paths outside the entire Git repository and its linked worktrees. Avoid symlinks resolving into a worktree.
- Put Slurm `--output` and `--error` in `SLURM_LOG_ROOT`; create paths before `sbatch`.
- Give each run a unique output directory; avoid races across jobs.
- Keep small configs and human-readable conclusions in Git; never commit datasets, checkpoints, credentials, `.env`, or generated logs.
- External scratch is not archival; transfer significant records to a persistent location.
