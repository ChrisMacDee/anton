# ⚙️ Anton — Silicon Valley Edition

> Named after Gilfoyle's server. Like the original Anton, this system runs autonomously, doesn't need supervision, and judges your code.

This is a reusable multi-agent framework for building web apps with Claude Code, themed as characters from HBO's Silicon Valley.

## Structure

- `bin/anton` — CLI entrypoint (bash)
- `prompts/` — Character-specific agent prompts (markdown). Each agent is a Silicon Valley character matched to their role.
- `templates/` — Config templates, build/resume prompts, and project type definitions
- `lib/` — Shared bash helpers (checkpointing, notifications, git operations)

## The Cast

| File | Character | Role |
|------|-----------|------|
| `orchestrator.md` | Jared Dunn | Orchestrator — keeps the team functioning |
| `pm.md` | Monica Hall | Product Manager — voice of the user |
| `architect.md` | Richard Hendricks | Architect — technical vision |
| `dinesh.md` | Dinesh Chugtai | Frontend Dev — solid, competitive |
| `carla.md` | Carla Walton | Senior Frontend Dev — best coder on the team |
| `qa-reviewer.md` | Bertram Gilfoyle | QA & DevOps — brutally thorough |
| `erlich.md` | Erlich Bachman | Scope Guardian — makes the tough cuts |
| `jian-yang.md` | Jian-Yang | Chaos Agent — breaks everything |

## Key Design Decisions

- The framework is pure bash + jq — no additional runtime dependencies beyond Claude Code and Node.js
- Agent prompts are plain markdown files, easy to edit and version
- Project types are pluggable — drop a new `.md` in `templates/project-types/`
- State is file-based (`.agent-state.json`) for simplicity and resumability
- Notifications are pluggable (ntfy, Pushover, Discord)

## Adding a New Project Type

1. Create `templates/project-types/<name>.md`
2. Include: Stack, Constraints, Scaffold Command, Deployment, Common Gotchas
3. It's immediately available via `anton init <dir> <name>`

## Editing Agent Prompts

Agent prompts in `prompts/` are the core IP. When editing:
- Keep the "Lessons Learned" sections at the bottom — they accumulate wisdom across projects
- Be specific and opinionated — vague prompts produce vague code
- Include code examples for the patterns you want agents to follow
