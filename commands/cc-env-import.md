---
description: Claude Code MD System — Environment Import. Restores a full Claude Code environment from a claude-env-export.md file onto a new machine.
---

You are running the Claude Code MD System — ENV IMPORT process.

---

## Step 1 — Find Export File

Look for `claude-env-export.md` in the current directory.

If not found:
```
No claude-env-export.md found in the current directory.

To create one: go to your old machine and run /cc-env-export
Then copy claude-env-export.md here and run /cc-env-import again.
```
Stop here.

---

## Step 2 — Read and Parse Export

Read `claude-env-export.md`. Extract each section:
- Global CLAUDE.md content
- Global settings.json content
- Project registry content
- Each command file (name + content)
- Each hook file (name + content)
- MCP server list

---

## Step 3 — Confirm Scope

Display:
```
Claude Code Environment Import
──────────────────────────────────────────────────────
Found in export:
  [✓/✗] Global CLAUDE.md
  [✓/✗] Global settings.json
  [✓/✗] Project registry ([n] projects)
  [✓/✗] [n] commands
  [✓/✗] [n] hooks
  [✓/✗] [n] MCP servers (keys REDACTED — you will re-enter these)

How would you like to import?

  M — Merge   (keep existing content where present, add missing)
  R — Replace (overwrite everything)
  C — Cancel

Your choice (M/R/C):
```

Wait for input before proceeding.

---

## Step 4 — Restore Global CLAUDE.md

- **Merge:** If `~/.claude/CLAUDE.md` exists, show both versions and combine — keep existing project-specific rules, add any missing sections from export
- **Replace:** Write export content directly to `~/.claude/CLAUDE.md`

Create `~/.claude/` directory if it does not exist.

---

## Step 5 — Restore settings.json

- **Merge:** Read existing `~/.claude/settings.json`, merge permissions (union of allow lists, intersection of deny lists), merge hooks (add any missing hook entries)
- **Replace:** Write export content to `~/.claude/settings.json`

Note: MCP server entries with REDACTED keys are imported as-is. User must update keys manually.

---

## Step 6 — Restore Commands

Create `~/.claude/commands/` if needed.

For each command in the export:
- **Merge:** Only write if file does not already exist
- **Replace:** Write all, overwriting existing

---

## Step 7 — Restore Hooks

Create `~/.claude/hooks/` if needed.

For each hook in the export:
- **Merge:** Only write if file does not already exist
- **Replace:** Write all, overwriting existing

---

## Step 8 — Restore Project Registry

- **Merge:** Append any projects from export not already in local registry (match by project name)
- **Replace:** Overwrite `~/.claude/projects.md` entirely

After restoring, display:
```
⚠ Project paths in the registry were from the original machine.
  Review ~/.claude/projects.md and update any paths that differ on this machine.
```

---

## Step 9 — MCP Servers

For each MCP server found in the export:
```
MCP Server: [name]
Command:    [command]
API Key:    [env var name] = REDACTED

Enter the API key for [name] (or press Enter to skip):
```

For each key entered: add to the mcpServers entry in `~/.claude/settings.json`.

---

## Step 10 — Completion

```
✅ Environment Import Complete
──────────────────────────────────────────
Restored:
  ✓ Global CLAUDE.md
  ✓ Global settings.json
  ✓ Project registry
  ✓ [n] commands → ~/.claude/commands/
  ✓ [n] hooks → ~/.claude/hooks/

Next steps:
  1. Open each project and run /cc-audit to verify setup
  2. Update any project paths in ~/.claude/projects.md
  3. Enter any missing MCP API keys in ~/.claude/settings.json
  4. Run /cc-projects to see all your registered projects
```

---

**Skill Author:** John Hutchison - McCarthyAI.com
