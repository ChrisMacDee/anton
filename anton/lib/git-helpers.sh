#!/bin/bash
# ── Git Helpers ────────────────────────────────────────────
# Branch management and git operations for the agent team.

ensure_git_repo() {
  if [ ! -d .git ]; then
    git init
    git add .
    git commit -m "chore: initial project scaffold (anton)"
  fi
}

create_feature_branch() {
  local task_name="$1"
  local branch="feature/$task_name"

  git checkout -b "$branch" main 2>/dev/null || git checkout -b "$branch"
  echo "$branch"
}

merge_feature_branch() {
  local branch="$1"
  local current=$(git branch --show-current)

  git checkout main
  git merge "$branch" --no-ff -m "Merge $branch"
  git branch -d "$branch" 2>/dev/null || true
  
  echo "Merged $branch → main"
}

list_feature_branches() {
  git branch --list 'feature/*' 2>/dev/null | sed 's/^[* ]*//'
}

commit_checkpoint() {
  local task_name="$1"
  local message="${2:-checkpoint: $task_name}"

  git add -A
  git commit -m "$message" 2>/dev/null || echo "Nothing to commit for $task_name"
}
