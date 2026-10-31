#!/bin/sh
set -eu
if [ $# -lt 5 ]; then
  echo "usage: $0 <repo-dir> <judge-template> <inputs> <output> <report>..." >&2
  exit 2
fi
dir=$1 template=$2 inputs=$3 out=$4
shift 4
cat "$template" "$inputs" "$@" >/dev/null
{ cat "$template" "$inputs"; for f in "$@"; do printf '\n--- %s ---\n' "$f"; cat "$f"; done; } |
  codex exec -s read-only --skip-git-repo-check -C "$dir" -o "$out" -
