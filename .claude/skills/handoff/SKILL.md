---
name: handoff
description: Summarize session context and make the next session easy to restart.
disable-model-invocation: true
---

1. Inspect current diff, commits, known experiment logs and session discussion.
2. Update `research/STATUS.md`: current objective, what changed, verified runs/results, failed attempts, blockers and specific next commands.
3. Append important research decisions to `research/DECISIONS.md` without erasing old decisions.
4. Link Git commit SHA, experiment IDs, W&B and Slurm identifiers where available.
5. Distinguish observed metrics from hypotheses; mention incomplete or unverified tests.
6. Do not claim the files were committed unless you actually commit them; ask before making unrelated commits.
