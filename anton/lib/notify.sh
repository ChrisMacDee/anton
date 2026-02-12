#!/bin/bash
# ── Notification Helpers ───────────────────────────────────
# Send notifications when builds complete or fail.
# Supports ntfy.sh (default), Pushover, and Discord webhooks.

watch_and_notify() {
  local pid="$1"
  local topic="$2"
  local logfile="${3:-build.log}"

  # Wait for the process to finish
  tail --pid="$pid" -f /dev/null 2>/dev/null
  local exit_code=$?

  # Parse last checkpoint from log
  local stage="unknown"
  if [ -f "$logfile" ]; then
    stage=$(grep -oP 'CHECKPOINT: \K.*' "$logfile" | tail -1)
    [ -z "$stage" ] && stage="unknown"
  fi

  # Determine notification method from config
  local method="ntfy"
  if [ -f .agent-config.json ]; then
    method=$(jq -r '.notifications.method // "ntfy"' .agent-config.json)
  fi

  if [ $exit_code -eq 0 ]; then
    send_notification "$method" "✅ Build complete" "Final stage: $stage" "$topic"
  else
    send_notification "$method" "⚠️ Build stopped" "Paused at: $stage — check build.log" "$topic"
  fi
}

send_notification() {
  local method="$1"
  local title="$2"
  local message="$3"
  local topic="$4"

  case "$method" in
    ntfy)
      send_ntfy "$title" "$message" "$topic"
      ;;
    pushover)
      send_pushover "$title" "$message"
      ;;
    discord)
      send_discord "$title" "$message"
      ;;
    *)
      echo "[notify] Unknown method: $method"
      ;;
  esac
}

# ── ntfy.sh (free, no account needed) ─────────────────────

send_ntfy() {
  local title="$1"
  local message="$2"
  local topic="$3"

  curl -s \
    -H "Title: $title" \
    -d "$message" \
    "https://ntfy.sh/$topic" > /dev/null 2>&1
}

# ── Pushover ($5 one-time) ────────────────────────────────

send_pushover() {
  local title="$1"
  local message="$2"

  local app_token=$(jq -r '.notifications.pushover.appToken // empty' .agent-config.json)
  local user_key=$(jq -r '.notifications.pushover.userKey // empty' .agent-config.json)

  if [ -z "$app_token" ] || [ -z "$user_key" ]; then
    echo "[notify] Pushover not configured — set notifications.pushover in .agent-config.json"
    return 1
  fi

  curl -s \
    -F "token=$app_token" \
    -F "user=$user_key" \
    -F "title=$title" \
    -F "message=$message" \
    https://api.pushover.net/1/messages.json > /dev/null 2>&1
}

# ── Discord Webhook ────────────────────────────────────────

send_discord() {
  local title="$1"
  local message="$2"

  local webhook_url=$(jq -r '.notifications.discord.webhookUrl // empty' .agent-config.json)

  if [ -z "$webhook_url" ]; then
    echo "[notify] Discord not configured — set notifications.discord.webhookUrl in .agent-config.json"
    return 1
  fi

  curl -s -H "Content-Type: application/json" \
    -d "{\"content\": \"**$title**\n$message\"}" \
    "$webhook_url" > /dev/null 2>&1
}
