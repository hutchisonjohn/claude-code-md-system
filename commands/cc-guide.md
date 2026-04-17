---
description: Claude Code MD System Setup — Guide. Opens the full How To Use guide as a markdown file in your project folder for easy reference.
---

You are running the Claude Code MD System Setup — GUIDE.
Write the full How To Use guide as a markdown file in the current project root.

Create the file `claude-code-md-system-guide.md` in the project root with the following content exactly:

---

```markdown
# Claude Code MD System Setup — How To Use Guide

> Your complete reference for setting up, managing, and optimising Claude Code
> across any project or machine.

---

## What Is This System?

The Claude Code MD System is a set of slash commands that help you configure
Claude Code properly for every project. It creates and manages the markdown
files that tell Claude who you are, what you're building, how to behave,
and what to avoid.

Without these files, Claude starts every session with no memory of your project.
With them, Claude picks up exactly where you left off — every time.

---

## The File Structure It Creates

```
your-project/
├── CLAUDE.md                        ← Air traffic control (~50 lines)
├── CLAUDE.local.md                  ← Your personal overrides (gitignored)
│
├── .claude/
│   ├── settings.json                ← Permissions + hooks (shared)
│   ├── settings.local.json          ← Personal settings (gitignored)
│   │
│   ├── rules/
│   │   ├── conventions.md           ← Naming, style, file size rules
│   │   ├── workflow.md              ← How features get built
│   │   └── agents.md               ← Agent/automation rules (if applicable)
│   │
│   ├── agents/                      ← Specialist sub-agents (optional)
│   ├── commands/                    ← Custom slash commands (optional)
│   └── skills/                      ← Auto-triggering skills (optional)
│
└── docs/
    ├── architecture.md              ← System design, kept up to date
    ├── project-status.md            ← Current state, session continuity
    └── changelog.md                 ← What changed and when
```

### How the layers connect

```
Every session loads:
  ~/.claude/CLAUDE.md  (your global rules — always on)
        ↓
  CLAUDE.md  (routes Claude to everything else)
        ↓
  .claude/rules/*  (loaded only when relevant — saves context)
        ↓
  docs/*  (referenced for project context)
```

---

## The Commands

### `/cc-menu` — Main Menu
Opens the numbered menu. Best starting point if you're not sure which command to run.

```
/cc-menu
```

---

### `/cc-setup` — First-Time Setup ⭐ Start here
**Run this once per new project.** Walks you through 10 questions, then creates
all your files automatically. After creating files, it runs an audit and fixes
any issues — all in one go.

```
/cc-setup
```

**What it asks you:**
1. Project name
2. What the project does (1-2 sentences)
3. Tech stack (language, frameworks, tools)
4. Solo or team?
5. Primary goals right now
6. How to verify work (test command)
7. Things Claude must NEVER do
8. Known mistakes or gotchas to avoid
9. Does this involve agents or automations?
10. Architecture overview (optional)

**What it creates:**
- `CLAUDE.md`
- `.claude/rules/conventions.md`
- `.claude/rules/workflow.md`
- `.claude/rules/agents.md` (if you build agents)
- `.claude/settings.json`
- `docs/architecture.md`
- `docs/project-status.md`
- `docs/changelog.md`

**Merge or Replace:** If files already exist, it warns you and lets you choose
to merge (keep existing + add missing) or replace (start fresh).

---

### `/cc-audit` — Health Check
Scans all your Claude MD files and reports issues by severity.
Run this periodically to catch problems before they affect your work.

```
/cc-audit
```

**Severity levels:**
| Level | Meaning | Action |
|-------|---------|--------|
| CRITICAL | Dangerous — e.g. force push not blocked | Fix immediately |
| HIGH | Will cause problems — e.g. no verification command | Fix soon |
| MEDIUM | Will cause inefficiency — e.g. vague rules | Fix when possible |
| LOW | Minor — e.g. stale content | Optional |

**Health scores:**
- EXCELLENT — No issues
- GOOD — Only MEDIUM/LOW
- FAIR — 1-2 HIGH issues
- POOR — Any CRITICAL or 3+ HIGH

---

### `/cc-fix` — Auto Repair
Reads your files, finds issues, and fixes them automatically.
Moves bloated content from CLAUDE.md into rules files.
Sharpens vague rules. Creates missing files.

```
/cc-fix
```

**Best used:** Right after `/cc-audit` reports issues.
**Tip:** Run `/cc-audit` again after fixing to confirm health improved.

---

### `/cc-refresh` — End-of-Session Update ⭐ Run every session
**Run this at the end of every working session.**
Updates `docs/project-status.md` and `docs/changelog.md` so the next session
picks up exactly where this one left off — without losing context.

```
/cc-refresh
```

**What it updates:**
- What was completed this session
- What's coming up next
- Where things stand right now
- Any new "Do NOT" rules if mistakes were made

**Why it matters:** Claude Code sessions have no memory between them.
This file is how Claude knows what's happened and what's next.

---

### `/cc-prune` — Remove Stale Content
Reviews all your rules, commands, agents and skills for content that is
outdated, vague, duplicate or unused. Shows you what it found before
deleting anything.

```
/cc-prune
```

**When to use:** Every few weeks, or when your project changes significantly
(new stack, removed a service, changed approach).

**Modes:**
- Review one-by-one (recommended) — see each flagged item, decide K/E/D
- Delete all flagged items at once
- Cancel

---

### `/cc-export` — Export Your Setup
Packages your entire `.claude/` configuration into a single portable file:
`claude-code-export.md` in your project root.

```
/cc-export
```

**Use this when:**
- Moving to a new machine
- Starting a similar project and want to reuse the setup
- Sharing your setup with a teammate
- Backing up your configuration

**What's included:** CLAUDE.md, all rules, agents, commands, skills, settings, docs
**What's excluded:** CLAUDE.local.md, settings.local.json (personal — never exported)

**The export file includes full import instructions** inside it, so anyone
receiving the file knows exactly what to do.

---

### `/cc-import` — Import a Setup
Loads a previously exported configuration into this project.
The export file must be in the **project root folder**.

```
/cc-import
```

**Steps:**
1. Copy your `claude-code-export.md` file into the new project root
2. Open Claude Code in that project
3. Run `/cc-import`
4. Choose Merge or Replace
5. Run `/cc-audit` to verify

**Merge vs Replace:**
- **Merge** — Keeps existing content, adds only missing sections from the import
- **Replace** — Overwrites existing files with the imported versions

---

### `/cc-guide` — Open This Guide
Writes this guide as `claude-code-md-system-guide.md` in your project root
so you can reference it any time without needing Claude.

```
/cc-guide
```

---

### `/cc-help` — Quick Reference
Displays a quick command reference and cheat sheet directly in the terminal.
No file created — just instant on-screen reference.

```
/cc-help
```

---

## Quick Command Reference

| Command | What it does | When to use |
|---------|-------------|-------------|
| `/cc-menu` | Open the numbered menu | Any time |
| `/cc-setup` | First-time full setup | Once per new project |
| `/cc-audit` | Health check, report issues | Periodically |
| `/cc-fix` | Auto-repair issues | After audit |
| `/cc-refresh` | End-of-session update | Every session |
| `/cc-prune` | Remove stale content | Every few weeks |
| `/cc-export` | Export setup to file | Moving machines / sharing |
| `/cc-import` | Import from export file | New machine / similar project |
| `/cc-guide` | Open this guide | Reference |
| `/cc-help` | Quick reference in terminal | Quick lookup |

---

## Recommended Workflow

### Starting a new project
```
1. Open Claude Code in your project folder
2. Run /cc-setup
3. Answer the 10 questions
4. Review the created CLAUDE.md
5. Start building
```

### During development (every session)
```
Start: Claude automatically loads CLAUDE.md and project-status.md
Work:  Build your features normally
End:   Run /cc-refresh to update status and changelog
```

### Periodic maintenance
```
Weekly:   /cc-audit  → check health
Monthly:  /cc-prune  → remove stale rules
As needed: /cc-fix   → repair any issues found
```

### Moving to a new machine
```
Old machine: /cc-export  → creates claude-code-export.md
Copy: claude-code-export.md to new machine's project folder
New machine: /cc-import  → loads everything
Then: /cc-audit to verify
```

---

## Tips & Best Practices

**Keep CLAUDE.md short (under 60 lines)**
It loads every session. Put detail in `.claude/rules/` and link to it.

**Update "Do NOT" immediately when Claude makes a mistake**
Don't wait. Add it the moment it happens. This is how the system gets smarter.

**Run `/cc-refresh` every session without fail**
This is the single most impactful habit. Continuity between sessions is everything.

**Use Merge, not Replace, when in doubt**
Merge preserves your existing work. Replace is for when you want a clean start.

**CLAUDE.local.md for personal preferences**
If you're on a team, keep your personal preferences out of the shared CLAUDE.md.
Put them in CLAUDE.local.md (it's gitignored by default).

**Export before major changes**
Before restructuring your setup, export first so you can roll back.

**Audit after pruning**
Always run `/cc-audit` after `/cc-prune` to confirm the health score held.

---

## Troubleshooting

**"Claude keeps ignoring my rules"**
→ Run `/cc-audit` — the rules may be too vague to be actionable.
→ Run `/cc-fix` to sharpen them.

**"CLAUDE.md is getting too long"**
→ Run `/cc-fix` — it moves bloated content to rules/ automatically.

**"Import file not found"**
→ The file must be in the project ROOT folder (same level as CLAUDE.md).
→ Check the filename is exactly `claude-code-export.md` (or whatever you named it).

**"Claude starts fresh every session with no context"**
→ Check that `docs/project-status.md` exists and is linked from CLAUDE.md.
→ Run `/cc-refresh` at the end of each session.

**"Settings.json permissions keep changing"**
→ Check you're not using `settings.local.json` overrides unintentionally.
→ Run `/cc-audit` to check for conflicts.

---

*Claude Code MD System Setup*
*Guide generated: [today's date]*
```

---

After writing the file, display:

```
✅ Guide created: claude-code-md-system-guide.md (project root)

Open this file any time for a full reference on using the Claude Code MD System.

Quick access in terminal: /cc-help
Full menu: /cc-menu
```

---

**Skill Author:** John Hutchison - McCarthyAI.com
