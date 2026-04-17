---
description: Claude Code MD System Setup — Audit. Analyse existing Claude MD files and report all issues by severity.
---

You are running the Claude Code MD System Setup — AUDIT process.
Scan all Claude MD configuration files in this project and report issues.

---

## Step 1 — Discover Files

Check for the existence of each of these files and note which are present and which are missing:

**Core files:**
- `CLAUDE.md` (project root)
- `CLAUDE.local.md` (project root)
- `.claude/settings.json`

**Rules:**
- `.claude/rules/conventions.md`
- `.claude/rules/workflow.md`
- `.claude/rules/agents.md`

**Docs:**
- `docs/architecture.md`
- `docs/project-status.md`
- `docs/changelog.md`

**Also check:** any other files in `.claude/rules/`, `.claude/agents/`, `.claude/commands/`, `.claude/skills/`

---

## Step 2 — Read All Present Files

Read every file that exists. Analyse each one.

---

## Step 3 — Run Audit Checks

For each check below, note any issues found with their severity.

### CLAUDE.md Checks
- [ ] **BLOAT** (HIGH) — Is CLAUDE.md over 100 lines? If yes, flag content that should move to rules/
- [ ] **MISSING SECTIONS** (HIGH) — Does it have: Project, Tech Stack, Verification, Do NOT, links to rules and docs?
- [ ] **VAGUE RULES** (MEDIUM) — Are any "Do NOT" entries vague? (e.g. "write good code" is not actionable)
- [ ] **MISSING VERIFICATION** (HIGH) — Is there a specific test/build command stated?
- [ ] **MISSING LINKS** (MEDIUM) — Does it link to conventions.md, workflow.md, architecture.md, project-status.md?
- [ ] **NO DO NOT SECTION** (HIGH) — Is there a "Do NOT" section with specific rules?

### Rules Files Checks
- [ ] **MISSING conventions.md** (HIGH) — If absent, flag as missing
- [ ] **MISSING workflow.md** (HIGH) — If absent, flag as missing
- [ ] **VAGUE CONVENTIONS** (MEDIUM) — Are naming conventions specific? Or just "use good names"?
- [ ] **NO VERIFICATION COMMANDS** (HIGH) — Does workflow.md list actual runnable commands?
- [ ] **STALE CONTENT** (LOW) — Any rules that reference tools or patterns no longer in the tech stack?

### Settings Checks
- [ ] **MISSING settings.json** (HIGH) — If absent, flag as missing
- [ ] **NO PERMISSIONS** (HIGH) — Is there an allow/ask/deny permissions structure?
- [ ] **NO HOOKS** (MEDIUM) — Is there a Stop hook for running tests/verification?
- [ ] **FORCE PUSH NOT DENIED** (CRITICAL) — Is `git push --force` explicitly denied?

### Docs Checks
- [ ] **MISSING architecture.md** (MEDIUM) — If absent, flag as missing
- [ ] **MISSING project-status.md** (HIGH) — If absent, flag as missing. Without this, sessions have no continuity.
- [ ] **MISSING changelog.md** (LOW) — If absent, flag as missing
- [ ] **STALE project-status.md** (MEDIUM) — Is project-status.md more than 7 days old without updates?
- [ ] **EMPTY SECTIONS** (LOW) — Are any docs sections marked "To be documented" that should have content by now?

### Global vs Project Conflicts
- [ ] **RULE CONFLICTS** (MEDIUM) — Does anything in project CLAUDE.md directly contradict ~/.claude/CLAUDE.md without an explicit override note?

---

## Step 4 — Display Report

Display findings in this format:

```
╔══════════════════════════════════════════════════════════╗
║         Claude Code MD System — Audit Report             ║
╚══════════════════════════════════════════════════════════╝

Files Found:    [list]
Files Missing:  [list]

─── CRITICAL ────────────────────────────────────────────
[List each critical issue. Empty if none.]
  ✗ [Issue description] → [File affected] → [Why it matters]

─── HIGH ────────────────────────────────────────────────
[List each high issue. Empty if none.]
  ✗ [Issue description] → [File affected] → [Why it matters]

─── MEDIUM ──────────────────────────────────────────────
[List each medium issue. Empty if none.]
  ! [Issue description] → [File affected]

─── LOW ─────────────────────────────────────────────────
[List each low issue. Empty if none.]
  · [Issue description] → [File affected]

─── SUMMARY ─────────────────────────────────────────────
  Critical: [n]   High: [n]   Medium: [n]   Low: [n]

  Overall health: [POOR / FAIR / GOOD / EXCELLENT]
  
  POOR      = Any CRITICAL or 3+ HIGH issues
  FAIR      = 1-2 HIGH issues, no CRITICAL
  GOOD      = Only MEDIUM/LOW issues
  EXCELLENT = No issues found

─── NEXT STEPS ──────────────────────────────────────────
  Run /cc-fix to automatically repair all CRITICAL and HIGH issues.
  Or return to /cc-menu to select another option.
```

---

**Skill Author:** John Hutchison - McCarthyAI.com
