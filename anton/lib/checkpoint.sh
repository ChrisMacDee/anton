#!/bin/bash
# ── Checkpoint & State Management ──────────────────────────
# Helpers for tracking build progress and resuming work.

show_status() {
  echo "═══════════════════════════════════════════════"
  echo "  ⚙️  Anton — Build Status"
  echo "═══════════════════════════════════════════════"
  echo ""

  # Check if build is running
  if [ -f .build.pid ]; then
    local pid=$(cat .build.pid)
    if kill -0 "$pid" 2>/dev/null; then
      echo "  🟢 Build RUNNING (PID $pid)"
    else
      echo "  🔴 Build STOPPED (PID $pid exited)"
    fi
  else
    echo "  ⚪ No active build"
  fi
  echo ""

  # Show checkpoint state
  if [ -f .agent-state.json ]; then
    echo "  Phase: $(jq -r '.phase // "unknown"' .agent-state.json)"
    echo ""

    local completed=$(jq -r '.completedTasks[]? // empty' .agent-state.json 2>/dev/null)
    if [ -n "$completed" ]; then
      echo "  ✅ Completed:"
      echo "$completed" | while read -r task; do
        echo "     • $task"
      done
    fi

    local pending=$(jq -r '.pendingTasks[]? // empty' .agent-state.json 2>/dev/null)
    if [ -n "$pending" ]; then
      echo ""
      echo "  ⏳ Pending:"
      echo "$pending" | while read -r task; do
        echo "     • $task"
      done
    fi

    local resume=$(jq -r '.resumePoint // empty' .agent-state.json)
    if [ -n "$resume" ]; then
      echo ""
      echo "  ▶️  Resume point: $resume"
    fi
  else
    echo "  No checkpoint state found."
  fi
  echo ""

  # Show recent checkpoints from log
  if [ -f build.log ]; then
    local checkpoints=$(grep 'CHECKPOINT:' build.log | tail -5)
    if [ -n "$checkpoints" ]; then
      echo "  📋 Recent log checkpoints:"
      echo "$checkpoints" | while read -r line; do
        echo "     $line"
      done
      echo ""
    fi
  fi

  # Show HANDOFF.md summary if it exists
  if [ -f HANDOFF.md ]; then
    echo "  📝 HANDOFF.md exists (build was interrupted or completed)"
    echo "     $(head -3 HANDOFF.md | tail -1)"
    echo ""
  fi

  # Git status
  if [ -d .git ]; then
    local branches=$(git branch --list 'feature/*' 2>/dev/null | wc -l)
    local last_commit=$(git log --oneline -1 2>/dev/null)
    echo "  🌿 Feature branches: $branches"
    echo "  📌 Last commit: $last_commit"
  fi

  echo ""
  echo "═══════════════════════════════════════════════"
}
