#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/common.sh"
python3 - "$HARNESS_PROJECT_ROOT" <<'PYCODE'
import os, pathlib, subprocess, sys
root=pathlib.Path(sys.argv[1]).resolve()
try:
    paths=subprocess.check_output(['git','-C',str(root),'worktree','list','--porcelain'],text=True)
    worktrees=[pathlib.Path(line[9:]).resolve() for line in paths.splitlines() if line.startswith('worktree ')]
except subprocess.CalledProcessError:
    worktrees=[root]
errors=[]
for key in ('DATA_ROOT','MODEL_ROOT','OUTPUT_ROOT','SLURM_LOG_ROOT'):
    value=os.environ.get(key,'')
    if not value or not pathlib.Path(value).is_absolute():
        errors.append(f'{key} must be an absolute configured path')
        continue
    p=pathlib.Path(value).resolve()
    if any(p == wt or wt in p.parents for wt in worktrees):
        errors.append(f'{key}={p} is inside a Git worktree')
    else:
        print(f'{key}: {p}')
if errors:
    print('\n'.join(errors),file=sys.stderr)
    sys.exit(1)
print('External storage paths validated. (Directories need not exist yet.)')
PYCODE
