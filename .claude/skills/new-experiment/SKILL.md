---
name: new-experiment
description: Plan and initialize a reproducible ML experiment in a new worktree when code changes; use pinned commits for config sweeps.
disable-model-invocation: true
---

When requested to create an experiment:
1. Read `research/PLAN.md`, `research/STATUS.md` and related notes.
2. Write a short hypothesis, baseline, metrics, budget, and success/failure criteria before modifying code.
3. Ask which base branch to branch from if unclear; for code changes create a descriptive branch and worktree with `scripts/create-worktree.sh`.
4. Create `research/experiments/<ID>-<slug>/experiment.md` based on the template; do not overwrite an existing experiment.
5. Specify exact dataset/split, feature encoder/pretrained weights, evaluation protocol, seeds and resolved config.
6. Verify configured external paths with `scripts/validate-storage.sh`.
7. Implement minimal code changes and commit coherently before full runs.
8. Set W&B project/group and a unique output directory for each run.
9. Run `/smoke-test` and obtain explicit user approval before any expensive Slurm submission.
10. Keep experiment record updated with Git SHA, W&B run links, Slurm IDs and conclusions.
