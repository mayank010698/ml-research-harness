# ML Research Project — Agent Instructions

Follow `.claude/rules/` and load the applicable `.claude/skills/` procedure before creating or launching an experiment.

1. External storage: datasets, pretrained weights, checkpoints, outputs **and Slurm stdout/stderr** live outside any Git worktree. Validate storage paths.
2. Isolation: new code-changing research direction -> Git branch + separate worktree. Config/seed sweeps on unchanged code share one pinned commit.
3. Tracking: substantive experiments log to W&B; local smoke tests may be offline.
4. Git: small, meaningful commits explaining what changed and why; pin SHA before full runs.
5. Reproducibility: record resolved config, seeds, dataset/split/preprocessing, encoder/checkpoint, Git SHA, dependencies, hardware, W&B and Slurm identifiers.
6. Before expensive GPU runs: imports, forward/backward, tiny training, checkpoint/log checks, short Slurm test; ask user approval for resource expenditure.
7. Research memory: document hypothesis before work; record results, failed hypotheses, decisions and next steps afterward.
8. Never claim an experiment ran unless its logs or artifacts verify that it ran. Never invent metrics or change baselines silently.

At session start read `research/STATUS.md` and `research/PLAN.md`. Before ending use `/handoff`.
