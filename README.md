# ⚙️ Anton — *Silicon Valley Edition*

> *Named after Gilfoyle's server. "It's not just a server. It's a statement."*

A reusable multi-agent framework for building web apps with [Claude Code](https://docs.anthropic.com/en/docs/claude-code). Define requirements interactively, then kick off an autonomous team of AI agents — themed as characters from HBO's *Silicon Valley* — that builds, reviews, and deploys your app.

## The Team

| Character | Role | What They Do |
|-----------|------|-------------|
| 🎯 **Jared Dunn** | Orchestrator | Keeps the team functioning. Tracks every task. Relentlessly positive. |
| 📋 **Monica Hall** | Product Manager | Gathers requirements. Voice of the user. Cuts through BS. |
| 🏗️ **Richard Hendricks** | Architect | Designs the system. Agonizes over decisions. Usually right. |
| 💻 **Dinesh Chugtai** | Frontend Dev | Solid coder. Competitive. Double-checks everything because Gilfoyle. |
| 💻 **Carla Walton** | Senior Frontend Dev | Best developer on the team. Give her the spec and stay out of her way. |
| 🔒 **Bertram Gilfoyle** | QA & DevOps | Finds every bug. Judges you for writing them. Deploys it once, correctly. |
| 🎤 **Erlich Bachman** | Scope Guardian | Makes the uncomfortable cuts. Thinks in pitches. Surprisingly right sometimes. |
| 🌶️ **Jian-Yang** | Chaos Agent | Breaks everything. Unicode, edge cases, 320px viewports. "Your app does not work." |

## How It Works

```
You ←→ Claude Code (Sonnet)        Claude Code (Opus) → Built App
       │                            │
       ├─ Monica gathers reqs       ├─ Jared orchestrates the build
       ├─ Richard designs system    ├─ Dinesh & Carla code in parallel
       ├─ Erlich scopes MVP         ├─ Gilfoyle reviews & deploys
       └─ Save docs to disk         ├─ Jian-Yang breaks everything
                                     └─ Ship it 🚀
```

**Phase 1 (Interactive):** You chat with a PM agent to define what you want. It produces a PRD, architecture doc, and task graph.

**Phase 2 (Autonomous):** An orchestrator agent reads those docs and builds the app using a team of specialized subagents — frontend devs working in parallel, a QA reviewer, and a DevOps agent for deployment.

**Phase 3 (Review):** You come back, review what was built, and request any changes.

## Quick Start

### 1. Install

```bash
git clone https://github.com/YOUR_USERNAME/anton.git ~/anton
echo 'export PATH="$HOME/anton/anton/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**Requirements:** [Claude Code](https://docs.anthropic.com/en/docs/claude-code), `jq`, `git`

### 2. Create a Project

```bash
anton init ~/projects/my-app react-ghpages
cd ~/projects/my-app
```

### 3. Gather Requirements

```bash
anton interactive
# Chat with the PM agent to define your app
# It saves PRD, architecture, and task docs to ./docs/
# Exit when satisfied
```

### 4. Build (Autonomous)

```bash
# Run in foreground
anton build

# Or detach and get a phone notification when done
anton build --detach
```

### 5. Check Progress

```bash
anton status
anton logs
```

### 6. Resume (After Usage Limits Reset)

```bash
anton resume --detach
```

### 7. Review

```bash
anton review
```

## Running on a Raspberry Pi

This framework is designed to run autonomously on a headless server like a Raspberry Pi 5. SSH in, kick off the build, and disconnect:

```bash
ssh pi@raspberrypi
tmux new -s build
cd ~/projects/my-app
anton build --detach
# Ctrl+B, D to detach tmux
# Disconnect SSH — build continues
```

Get notified on your phone when it's done (see [Notifications](#notifications)).

## Project Types

| Type | Stack | Deployment |
|------|-------|------------|
| `react-ghpages` | Vite + React | GitHub Pages |
| `react-vercel` | Vite + React | Vercel |
| `nextjs` | Next.js (App Router) | Vercel |
| `static-site` | HTML/CSS/JS | GitHub Pages |
| `custom` | User-defined | User-defined |

```bash
# See all available types
anton list-types

# Use a specific type
anton init ~/projects/blog nextjs
```

### Adding Custom Project Types

Drop a markdown file in `templates/project-types/`:

```bash
vim ~/anton/templates/project-types/astro.md
# Now available: anton init mysite astro
```

Include: Stack, Constraints, Scaffold Command, Deployment steps, and Common Gotchas.

## Configuration

Each project gets an `.agent-config.json`:

```jsonc
{
  "phases": {
    "interactive": {
      "model": "claude-sonnet-4-20250514"    // Requirements gathering
    },
    "build": {
      "model": "claude-opus-4-20250514"      // Autonomous build
    }
  },
  "build": {
    "maxRetries": 3,
    "checkpoints": true,
    "parallelSubagents": true
  },
  "notifications": {
    "method": "ntfy",                         // ntfy | pushover | discord
    "ntfyTopic": "my-builds"
  }
}
```

### Model Selection

| Agent | Default Model | Why |
|-------|--------------|-----|
| PM, Devs, DevOps | Sonnet | Great at code generation, cost-effective |
| Architect, QA | Opus | Complex reasoning, catches subtle issues |

The interactive phase uses Sonnet (fast, conversational). The build phase uses Opus (thorough, high-quality code). Adjust in `.agent-config.json` per project.

## Notifications

Get notified on your phone when builds complete or fail.

### ntfy.sh (Recommended — Free, No Account)

```jsonc
"notifications": {
  "method": "ntfy",
  "ntfyTopic": "my-agent-builds"    // Pick any unique topic name
}
```

Install the [ntfy app](https://ntfy.sh/) and subscribe to your topic.

### Pushover ($5 One-Time)

```jsonc
"notifications": {
  "method": "pushover",
  "pushover": {
    "appToken": "your-app-token",
    "userKey": "your-user-key"
  }
}
```

### Discord Webhook

```jsonc
"notifications": {
  "method": "discord",
  "discord": {
    "webhookUrl": "https://discord.com/api/webhooks/..."
  }
}
```

## Checkpointing & Resume

The framework saves progress after every completed task. If Claude Code hits usage limits or the process is interrupted:

1. State is saved to `.agent-state.json`
2. Work-in-progress is committed to git
3. A `HANDOFF.md` explains where things stopped

When your usage resets, just run `anton resume --detach` and it picks up where it left off.

## Agent Prompts (The Cast)

The agent prompts in `prompts/` define each character's personality, process, and quality standards:

```
prompts/
├── orchestrator.md    # Jared Dunn — coordination, state management
├── pm.md              # Monica Hall — requirements, user advocacy
├── architect.md       # Richard Hendricks — system design, tech vision
├── dinesh.md          # Dinesh Chugtai — frontend components, UI
├── carla.md           # Carla Walton — complex/senior frontend work
├── qa-reviewer.md     # Bertram Gilfoyle — code review, DevOps, deployment
├── erlich.md          # Erlich Bachman — scope control, product narrative
└── jian-yang.md       # Jian-Yang — chaos testing, edge cases, i18n
```

Each prompt has a **Lessons Learned** section at the bottom — add patterns you discover across projects to make the team smarter with every build. The characters' personalities influence how they approach problems: Gilfoyle's reviews are thorough and blunt, Dinesh double-checks everything out of anxiety, Carla writes production-quality code on the first pass, and Jian-Yang will absolutely paste 10,000 emoji into your form fields.

## CLI Reference

```
anton help             Show usage
anton init <dir> <type>  Scaffold a new project
anton list-types       Show available project types
anton interactive      Start requirements session
anton build [--detach] Run autonomous build
anton resume [--detach] Resume interrupted build
anton review           Review completed build
anton status           Check build progress
anton logs             Tail the build log
```

## License

MIT
