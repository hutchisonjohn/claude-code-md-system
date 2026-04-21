---
description: Claude Code MD System Setup — Refresh. End-of-session update. Updates project-status.md and changelog.md to maintain session continuity.
---

You are running the Claude Code MD System Setup — REFRESH process.
Run this at the end of every working session to maintain continuity.

---

## Step 1 — Review Session Work

Read the following to understand what happened this session:
- Current `docs/project-status.md`
- Current `docs/changelog.md`
- Recent conversation context (what tasks were completed, what decisions were made)

---

## Step 2 — Update `docs/project-status.md`

Rewrite the following sections (preserve the rest):

**Completed** — prepend today's date and what was finished this session.

**Up Next** — update with the next logical tasks based on what was just done.

**Where We Left Off** — write 2-3 sentences describing exactly where things stand
so the next session can pick up immediately without context loss. Be specific:
what file was being edited, what feature is half-done, what decision is pending.

**Blockers / Open Decisions** — update with anything unresolved that needs attention.

---

## Step 3 — Append to `docs/changelog.md`

Add a new entry at the top of the file:

```markdown
## [Today's date]
- [Bullet list of what changed or was completed this session]
- [Keep entries short and factual — what changed, not how]
```

---

## Step 4 — Check CLAUDE.md for Updates

Ask: "Did anything happen this session that should be added to the 'Do NOT' section of CLAUDE.md?"

If yes — add the new rule. If no — skip.

---

## Step 5 — Update Project Registry

Check if `~/.claude/projects.md` exists and contains an entry for the current project path.

- **If found:** update the `Last session` date to today.
- **If not found:** mention it once — "This project isn't in your registry yet — run /cc-register to add it."

---

## Step 6 — Mark Checkpoint Complete

If `docs/session-checkpoint.md` exists, mark it as a clean session end:

Find `**Status:** IN_PROGRESS` and change to `**Status:** COMPLETE`.
Update the last saved timestamp to now.
Remove the "To resume" line if present.

This prevents the recovery prompt from triggering unnecessarily next session.

---

## Step 6 — Completion Message

```
✅ Session Refresh Complete
────────────────────────────
Updated: docs/project-status.md
Updated: docs/changelog.md
Updated: docs/session-checkpoint.md (marked COMPLETE)
[CLAUDE.md — updated / no changes needed]

Next session: start with /cc-menu or just open the project.
Claude will load docs/project-status.md automatically via CLAUDE.md.
If anything was interrupted, run /cc-recover to restore context.
```

---

**Skill Author:** John Hutchison - McCarthyAI.com
