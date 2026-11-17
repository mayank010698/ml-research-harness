#!/usr/bin/env bash
set -euo pipefail
if [[ $# -ne 3 ]]; then echo 'Usage: create-worktree.sh <new-branch> <directory> <base-ref>' >&2; exit 2; fi
branch=$1; directory=$2; base=$3
git rev-parse --is-inside-work-tree >/dev/null
if git show-ref --verify --quiet "refs/heads/$branch"; then echo "Branch already exists: $branch" >&2; exit 1; fi
if [[ -e "$directory" ]]; then echo "Directory already exists: $directory" >&2; exit 1; fi
git worktree add -b "$branch" "$directory" "$base"
echo "Created worktree at $directory on $branch"
