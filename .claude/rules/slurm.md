# Slurm launch policy

- Never submit GPU-consuming jobs without the user's approval of GPU count, walltime, partition and workload.
- Do not assume the target cluster has a particular partition, account, module, or filesystem.
- First do import, forward/backward, tiny training and checkpoint/logging checks; then a short Slurm GPU job on the target system.
- `sbatch --test-only` is a submission validation, NOT a runtime smoke test.
- Set absolute stdout/stderr paths outside the repo; create their directories before submission.
- Ensure unique experiment run paths. Record returned Slurm job ID and W&B ID.
- Never embed passwords or API keys in job scripts.
