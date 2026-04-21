---
description: Claude Code MD System — Recover. Reads the session checkpoint and restores context after a crash, power failure, or unexpected exit.
---

You are running the Claude Code MD System — RECOVER process.

---

## Step 1 — Check for Checkpoint

Look for `docs/session-checkpoint.md` in the current project.

**If the file does not exist:**
```
No checkpoint found. Either:
  • This project hasn't been set up yet — run /cc-setup
  • The last session ended before any work was done

Run /cc-setup to initialise this project.
```
Stop here.

---

## Step 2 — Read Status

Read `docs/session-checkpoint.md`.

**If Status is COMPLETE** — last session ended cleanly:
```
✅ Last session ended cleanly — no recovery needed.

Goal was: [goal from checkpoint]

Run /cc-refresh to update status, or just start working.
```
Stop here.

**If Status is IN_PROGRESS** — session was interrupted. Continue to Step 3.

---

## Step 3 — Load Full Context

Read all three of these:
1. `docs/session-checkpoint.md` — what was happening at interruption
2. `docs/project-status.md` — current project state and milestones
3. `CLAUDE.md` — project rules, tech stack, verification commands

---

## Step 4 — Deliver Recovery Brief

Display exactly:

```
⚡ Session Recovery
─────────────────────────────────────────────────────
Last saved: [timestamp from checkpoint]
Status:     INTERRUPTED (power failure or unexpected exit)

GOAL
[goal field from checkpoint — what we were working on]

WHAT WAS HAPPENING
[last 8-10 items from Recent Activity in checkpoint]

FILES BEING WORKED ON
[Files Modified from checkpoint — list each one]

PROJECT STATE
[2-3 sentences from project-status.md: current milestone + up next]
─────────────────────────────────────────────────────
Ready to pick up where we left off.

Shall I resume? (yes / no / show me more context first)
```

---

## Step 5 — Resume or Clarify

**If user says yes** (or "continue", "go ahead", etc.):
- Continue the work directly from the goal and file context above
- Do not re-explain what you're about to do — just do it

**If user wants more context:** read whatever files they ask about, then resume.

**If user says no:** ask what they'd like to do instead.

---

## Step 6 — Mark Checkpoint Clean

Once you have completed at least one meaningful unit of work in this recovery session, update `docs/session-checkpoint.md`:

Change:
```
**Status:** IN_PROGRESS
```
To:
```
**Status:** COMPLETE
```

And remove the "To resume" line if present.

This prevents the recovery prompt from triggering again next session.

---

**Skill Author:** John Hutchison - McCarthyAI.com
