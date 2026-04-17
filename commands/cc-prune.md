---
description: Claude Code MD System Setup — Prune. Review and remove stale, vague or unused rules, commands, agents and skills.
---

You are running the Claude Code MD System Setup — PRUNE process.
Identify and remove content that is no longer useful, accurate or active.

---

## Step 1 — Inventory Everything

List all files found in:
- `.claude/rules/`
- `.claude/agents/`
- `.claude/commands/`
- `.claude/skills/`
- CLAUDE.md (each rule in the "Do NOT" section)
- Each rules file (each individual rule)

---

## Step 2 — Analyse Each Item

For each file and each rule, assess:

**Stale check:** Does this reference a tool, library, framework or pattern no longer in the project?
**Vague check:** Is this rule too vague to be actionable? (e.g. "write clean code")
**Duplicate check:** Is this rule already covered elsewhere?
**Unused check (commands/agents/skills):** Has this command or agent been used recently?
  (Check if it's referenced in CLAUDE.md, rules, or conversation history)
**Conflict check:** Does this rule conflict with another rule?

---

## Step 3 — Present Findings

Display a table of everything flagged, before making any changes:

```
╔══════════════════════════════════════════════════════════╗
║         Claude Code MD System — Prune Report             ║
╚══════════════════════════════════════════════════════════╝

The following items have been flagged for review:

  #  Type      File / Rule                    Reason
  ─  ────────  ─────────────────────────────  ──────────────
  1  Rule      CLAUDE.md: "write good code"   Too vague
  2  Rule      conventions.md: "use jQuery"   Stale (not in stack)
  3  Agent     .claude/agents/legacy-api.md   Possibly unused
  4  Rule      workflow.md: [duplicate of conventions.md rule]  Duplicate

Nothing will be deleted until you confirm.
```

Then ask:
```
How would you like to proceed?

  A — Review each item one by one (recommended)
  D — Delete all flagged items
  S — Skip prune (cancel)

Your choice (A/D/S):
```

---

## Step 4A — Review One by One (if A selected)

For each flagged item, display:
```
Item [n] of [total]:
  [Item description and reason flagged]

  K — Keep as-is
  E — Edit / fix it now
  D — Delete it
  Skip — Leave for later
```

Apply each decision immediately.

---

## Step 4D — Delete All (if D selected)

Confirm once more:
```
⚠ This will permanently delete [n] items. Are you sure? (yes/no):
```

If yes — delete all flagged items and report what was removed.

---

## Step 5 — Completion Report

```
✅ Prune Complete
──────────────────
Deleted:  [n items — list them]
Edited:   [n items — list them]
Kept:     [n items]
Skipped:  [n items]

Run /cc-audit to verify overall health after pruning.
```

---

**Skill Author:** John Hutchison - McCarthyAI.com
