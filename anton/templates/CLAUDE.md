# Anton Project

This project is built and maintained by a multi-agent development team powered by Claude Code.

## Key Files

| File | Purpose |
|------|---------|
| `.agent-config.json` | Model assignments, notification config, build settings |
| `.agent-state.json` | Checkpoint state (created during build, used for resume) |
| `./docs/prd.md` | Product requirements document |
| `./docs/architecture.md` | System design, component tree, tech decisions |
| `./docs/tasks.md` | Task dependency graph with parallelization info |
| `HANDOFF.md` | Context for resuming interrupted builds |

## The Team (Silicon Valley Edition)

The agent prompts live in the shared team directory (see `teamDir` in `.agent-config.json`). Each agent is a character from Silicon Valley, matched to their role:

| Character | Role | Prompt File |
|-----------|------|-------------|
| 🎯 **Jared Dunn** | Orchestrator | `orchestrator.md` |
| 📋 **Monica Hall** | Product Manager | `pm.md` |
| 🏗️ **Richard Hendricks** | Architect | `architect.md` |
| 💻 **Dinesh Chugtai** | Frontend Developer | `dinesh.md` |
| 💻 **Carla Walton** | Senior Frontend Developer | `carla.md` |
| 🔒 **Bertram Gilfoyle** | QA Reviewer & DevOps | `qa-reviewer.md` |
| 🎤 **Erlich Bachman** | Stakeholder & Scope Guardian | `erlich.md` |
| 🌶️ **Jian-Yang** | Edge Case & Chaos Agent | `jian-yang.md` |

## Conventions

- Print `CHECKPOINT: <task-name>` after completing each task
- Update `.agent-state.json` after every checkpoint
- Work on feature branches: `feature/<task-name>`
- Commit frequently with descriptive messages
- If interrupted, write `HANDOFF.md` before exiting
- Follow the architecture doc as the single source of truth
