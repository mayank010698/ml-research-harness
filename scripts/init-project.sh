#!/usr/bin/env bash
set -euo pipefail
if [[ $# -ne 1 ]]; then echo 'Usage: init-project.sh /path/to/existing-or-new-project' >&2; exit 2; fi
src=$(cd "$(dirname "$0")/.." && pwd -P)
dest=$1
mkdir -p "$dest"
dest=$(cd "$dest" && pwd -P)
if [[ "$dest" == "$src" ]]; then echo 'Choose a different destination.' >&2; exit 1; fi
# Preserve user files; no overwrite. Copy shared policies, project templates, and scripts.
for item in CLAUDE.md AGENTS.md .claude .env.example .gitignore scripts research slurm templates; do
  if [[ "$item" == '.gitignore' && -f "$dest/.gitignore" ]]; then
    echo 'Existing .gitignore retained; merge .gitignore rules manually.'
    continue
  fi
  if [[ -d "$src/$item" ]]; then
    (cd "$src" && find "$item" -type f -print0) | while IFS= read -r -d '' file; do
      mkdir -p "$dest/$(dirname "$file")"
      if [[ ! -e "$dest/$file" ]]; then cp "$src/$file" "$dest/$file"; else echo "Skip existing: $file"; fi
    done
  elif [[ -f "$src/$item" ]]; then
    if [[ ! -e "$dest/$item" ]]; then cp "$src/$item" "$dest/$item"; else echo "Skip existing: $item"; fi
  fi
done
if [[ -d "$dest/.git" || -f "$dest/.git" ]]; then :; else echo 'Destination is not a Git repository; initialize Git yourself if intended.'; fi
echo "Installed harness files into $dest. Next: cp .env.example .env; edit it; review and commit."
