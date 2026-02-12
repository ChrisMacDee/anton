# Resuming Autonomous Build

You are resuming a previously interrupted build session. The user is NOT present — work autonomously.

## Recovery Steps

1. **Read state**: Check `.agent-state.json` for progress so far
2. **Read handoff**: Check `HANDOFF.md` for context on where things stopped and any notes
3. **Read docs**: Review `./docs/prd.md`, `./docs/architecture.md`, `./docs/tasks.md`
4. **Check git**: Run `git log --oneline -20` and `git branch -a` to see what code exists
5. **Verify builds**: Run `npm run build` to check current state compiles

## Resume Rules

- Do NOT redo completed tasks — trust the checkpoints in `.agent-state.json`
- Pick up from `.resumePoint` in the state file
- If code exists but a task isn't marked complete, verify it works before marking it done
- Continue following the same build process as the original session
- Update `.agent-state.json` as you complete each task
- Print `CHECKPOINT: <task-name>` for each completed task

## Anton Prompts

The agent prompts are at: `{{TEAM_DIR}}/prompts/`
Read these when spawning subagents for implementation work.

## If You Complete Everything

Write a final `HANDOFF.md` summarizing the full build, then print `CHECKPOINT: complete`.
