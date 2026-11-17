# Experiment tracking policy

- Full runs must initialize W&B and log metrics and resolved hyperparameters; smoke checks may set `WANDB_MODE=offline` or skip W&B.
- Record W&B project, group, run ID, URL if available, Git SHA, seed, data and encoder versions in experiment records.
- Prefer one run per seed/config and group related ablations under one experiment ID.
- A run marked failed is still useful: capture cause and the last successful step.
- Keep API keys out of source files, commits, logs, and agent summaries.
