# Git and worktree policy

- Use a new branch and dedicated worktree for each independent code-changing research direction.
- Use the same pinned commit with config variation and W&B groups for hyperparameter/seed sweeps.
- Do not check out one branch simultaneously in multiple worktrees; Git typically blocks this.
- Before starting a full experiment, commit intentional code/config changes and capture `git rev-parse HEAD`.
- Do not automatically merge, reset, delete, or discard other researchers' changes.
- Commits should explain intent, method, and any relevant research hypothesis.
