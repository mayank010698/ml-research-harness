# ML Research Agent Harness

Reusable, version-controlled conventions for ML research with Claude Code, Git worktrees, W&B, and Slurm.

## Quick start

```bash
# From the harness checkout
bash scripts/init-project.sh /path/to/your/ml-repo
cd /path/to/your/ml-repo
cp .env.example .env
# Edit .env to point to external, persistent/scratch storage.
# Start Claude Code in the repo and try /new-experiment.
```

The installer does **not** overwrite existing files. Review the changes and commit them to your project. The canonical harness repository remains separate and can evolve independently.

## What lives where

- `CLAUDE.md`: concise policies read by Claude.
- `.claude/rules/`: detailed policies.
- `.claude/skills/`: explicit workflows (`/new-experiment`, `/smoke-test`, `/submit-slurm`, `/handoff`).
- `scripts/`: agent-independent validation, worktree, and launch helpers.
- `research/`: plans, findings, status, decisions (installed from templates).
- `.env` (ignored): external directory configuration; never commit secrets.

## First commands

```bash
bash scripts/validate-storage.sh
bash scripts/create-worktree.sh exp/inner-steps ../nwgf-inner-steps main
bash scripts/smoke-test.sh 'python -c "import torch; print(torch.__version__)"'
# In a project worktree, after a successful short training smoke test:
# bash scripts/submit-slurm.sh slurm/train.sbatch  # interactive confirmation
```

## Limitations and safeguards

- The provided smoke test command is an example, **not** a complete model forward/backward/train check. Customize it to the codebase.
- `submit-slurm.sh` requires a project-specific smoke-test marker and explicit confirmation; that marker does not prove your Slurm run will succeed.
- Slurm stdout/stderr paths must exist **before submission**; use `scripts/prepare-slurm.sh` with a configured `SLURM_LOG_ROOT`.
- `.env` is loaded by helper scripts, not automatically by every `sbatch` or Python process. Export vars in your job environment or pass `--export` as needed.
- Scratch may be purged: copy important outputs and conclusions to persistent storage / W&B.
- These instructions are conventions; agents can make mistakes. Launch scripts provide narrower technical checks but do not fully sandbox arbitrary shell commands.
- A new Git worktree generally requires a different branch; seed sweeps should share a pinned SHA/config variants.

Documentation: https://code.claude.com/docs/en/skills, https://code.claude.com/docs/en/settings
