---
description: Claude Code MD System — Projects. Lists all registered projects from your global registry with status and last session info.
---

You are running the Claude Code MD System — PROJECTS process.

---

## Step 1 — Read Registry

Read `~/.claude/projects.md` (Windows: `C:\Users\[username]\.claude\projects.md`).

If the file does not exist:
```
No projects registered yet.
Run /cc-register in any project to add it to your registry.
```
Stop here.

---

## Step 2 — Check Each Project

For each registered project:
1. Check if the path still exists on disk
2. Check if `[path]/docs/session-checkpoint.md` exists and has `Status: IN_PROGRESS`

---

## Step 3 — Display

```
╔══════════════════════════════════════════════════════════════╗
║            Claude Code Project Registry                      ║
╚══════════════════════════════════════════════════════════════╝

[For each project:]

  [project-name]  [⚡ INTERRUPTED] if checkpoint IN_PROGRESS
  Path:   [path]  [⚠ PATH MISSING] if folder not found
  Repo:   [repo URL]
  Stack:  [stack]
  Last:   [last session date]

──────────────────────────────────────────────────────────────

Total: [n] projects  |  [n] interrupted  |  [n] missing paths

──────────────────────────────────────────────────────────────
⚡ = interrupted session — run /cc-recover in that project
⚠  = path not found on this machine (may be on another drive)

Run /cc-register to add the current project.
```

---

**Skill Author:** John Hutchison - McCarthyAI.com
