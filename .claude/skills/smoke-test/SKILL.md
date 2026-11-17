---
name: smoke-test
description: Validate an ML experiment before consuming substantial GPU resources.
disable-model-invocation: true
---

1. Verify imports and environment (CPU if possible).
2. Execute an actual one-batch forward pass AND backward pass of the model under test.
3. Execute a short training run; check loss finiteness, gradients, evaluation, checkpoint save/load, and W&B connectivity or intentional offline mode.
4. Run `bash scripts/validate-storage.sh`.
5. Submit a **short actual Slurm GPU job** on the target cluster after approval; inspect stdout/stderr and exit status.
6. Record the exact commands and findings in the experiment log, and only after completion create a timestamped smoke-test marker (see README). The helper script `scripts/smoke-test.sh '<command>'` records a marker for the command it executes; that single command must encompass the meaningful checks if used as a launch gate.
7. Never treat `sbatch --test-only` as proof of execution. Report failures, do not launch full jobs on failed checks.
