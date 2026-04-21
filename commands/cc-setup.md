---
description: Claude Code MD System Setup — Step 1. First-time full setup. Interviews the user, creates all MD files, audits, and fixes in one run.
---

You are running the Claude Code MD System Setup — SETUP process.
This is a first-time, one-run process that creates a complete Claude Code MD configuration for this project.

---

## PHASE 0 — Check for Existing Files

Before starting, check if any of these files already exist in the current working directory:
- `CLAUDE.md`
- `.claude/rules/` (any files)
- `.claude/settings.json`
- `docs/architecture.md`
- `docs/project-status.md`
- `docs/changelog.md`

If ANY exist, display this warning and wait for user input:

```
⚠ WARNING: Existing Claude MD files detected.

Found: [list the files found]

How would you like to proceed?

  M — Merge   (keep existing content, add missing sections)
  R — Replace (overwrite all files with fresh setup)
  C — Cancel  (abort setup)

Your choice (M/R/C):
```

- If M: preserve existing file content, only add missing sections
- If R: proceed with clean overwrite
- If C: stop and return to menu

---

## PHASE 1 — Interview

Tell the user:
```
Let's set up your Claude Code MD configuration.
I'll ask you a series of questions. Answer as briefly or in as much detail as you like.
Press Enter to skip any question and use the default.
─────────────────────────────────────────────────────────
```

Ask each question ONE AT A TIME. Wait for the answer before proceeding.

**Q1 — Project Name**
"What is the name of this project?"

**Q2 — Project Purpose**
"In 1-2 sentences, what does this project do? What problem does it solve?"

**Q3 — Tech Stack**
"What is your tech stack? (e.g. TypeScript, Python, React, Node, Postgres — list everything relevant)"

**Q4 — Solo or Team**
"Are you working solo or with a team?"

**Q5 — Primary Goals**
"What are the main things you are trying to build or achieve with this project right now?"

**Q6 — Verification**
"How should Claude verify its work? What command runs your tests or checks the build?
(e.g. 'npm test', 'python -m pytest', 'cargo test' — or describe how to verify manually)"

**Q7 — Do NOT Rules**
"Is there anything Claude must NEVER do in this project?
(e.g. never push to main, never delete files without asking, never use a specific library)
List as many as you like."

**Q8 — Known Mistakes or Gotchas**
"Have you seen Claude (or any AI) make specific mistakes in projects like this before?
Anything it tends to get wrong that we should warn it about?"

**Q9 — Agent/Automation Focus**
"Does this project involve building agents, automations, or AI workflows? (yes/no)
If yes, briefly describe the type of agents or automations."

**Q10 — Architecture Overview (optional)**
"Can you give a brief overview of the system architecture, or key components?
(skip if you'd like Claude to document this as the project develops)"

---

## PHASE 2 — Create Files

Using the answers from the interview, create the following files.
Tell the user what you are creating before each file.

### 2.1 — `CLAUDE.md` (project root)

Create a CLAUDE.md in the current working directory following this structure.
Keep it under 60 lines. It is the air traffic controller — route to files, don't repeat content.

```markdown
# CLAUDE.md — [Project Name]

## Project
[1-2 sentence description from Q2]

## Tech Stack
[From Q3 — explicit list]

## Project Structure
[Generate a sensible default based on the tech stack. Claude will update this as the project develops.]

## Verification
Before marking any task complete, run: [Q6 answer]
If no test command: manually verify by [Q6 description].
Always state how you will verify before starting work.

## Do NOT
[Numbered list from Q7 and Q8 answers. Add defaults:]
- Never push directly to the main/master branch
- Never hardcode API keys, tokens or passwords (use .env)
- Never add features not explicitly requested
- Never modify files outside the scope of the current task
- Never use dangerously-skip-permissions mode

## Conventions
See .claude/rules/conventions.md

## Workflow
See .claude/rules/workflow.md

[If Q9 = yes:]
## Agents & Automation
See .claude/rules/agents.md

## Architecture
See docs/architecture.md

## Project Status
See docs/project-status.md

## Session Recovery
On every session start, silently check for `docs/session-checkpoint.md`.
If it exists and Status is IN_PROGRESS, say immediately:
"⚡ Last session was interrupted — run `/cc-recover` to restore context."
```

### 2.2 — `.claude/rules/conventions.md`

```markdown
# Conventions

## Naming
- Files: kebab-case
- Functions/methods: camelCase (JS/TS) or snake_case (Python)
- Classes/Components: PascalCase
- Constants: UPPER_SNAKE_CASE

## File Size
- Target: 200-400 lines per file
- Maximum: 800 lines — extract modules beyond this

## Function Size
- Maximum: 50 lines — split if longer

## Git
- Commit format: <type>: <description>
- Types: feat, fix, refactor, docs, test, chore, perf, ci
- Branch naming: feature/<name>, fix/<name>, chore/<name>
- Never commit directly to main

## Code Style
- Immutable patterns preferred — create new objects, don't mutate
- No deep nesting (max 4 levels) — use early returns
- Explicit error handling at every level
- No hardcoded values — use constants or .env
```

### 2.3 — `.claude/rules/workflow.md`

```markdown
# Development Workflow

## Every Task — Before Starting
1. State your assumptions explicitly
2. If unclear, ask — don't guess
3. State how you will verify the work

## Feature Development
1. Plan — describe approach, identify risks, ask clarifying questions
2. Write tests first (if applicable)
3. Implement — minimal code to pass the goal
4. Verify — run: [Q6 answer]
5. Update docs/changelog.md with what changed
6. Update docs/project-status.md with current state

## When Claude Makes a Mistake
Add it to the "Do NOT" section of CLAUDE.md immediately.

## Verification Commands
- Tests: [Q6 answer]
- [Add additional commands as project grows]
```

### 2.4 — `.claude/rules/agents.md` (only if Q9 = yes)

```markdown
# Agent & Automation Rules

## Agent Design Principles
- Each agent has a single, well-defined responsibility
- Agents communicate via clear interfaces, not shared state
- Always include error handling for agent failures
- Log agent actions for debugging

## Agent File Location
- Sub-agents: .claude/agents/
- Skills: .claude/skills/

## Context Window
- Sub-agents run in forked context — they don't share state with main session
- Use sub-agents for specialist tasks to protect main context window
- Parallel agents must work on isolated files (use git worktrees if needed)

## Verification
Every agent must have a defined success condition.
Never consider an agent task complete without verifying its output.
```

### 2.5 — `.claude/settings.json`

```json
{
  "permissions": {
    "allow": [
      "Bash(git status)",
      "Bash(git diff *)",
      "Bash(git log *)",
      "Bash(git add *)",
      "Bash(git commit *)",
      "Bash(git checkout *)",
      "Bash(git branch *)"
    ],
    "ask": [
      "Bash(rm *)",
      "Bash(git push *)",
      "Bash(git reset *)"
    ],
    "deny": [
      "Bash(git push --force *)",
      "Bash(git push -f *)"
    ]
  },
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "[Q6 test command — or remove this hook if no test command]"
          }
        ]
      }
    ]
  }
}
```

### 2.6 — `docs/architecture.md`

```markdown
# Architecture

## Overview
[From Q10 if answered — otherwise: "To be documented as the project develops."]

## Components
[Generate sensible defaults based on tech stack from Q3]

## Data Flow
[To be documented as the project develops]

## Key Decisions
[To be documented as the project develops]

---
*Last updated: [today's date]*
```

### 2.7 — `docs/project-status.md`

```markdown
# Project Status

## Current Milestone
Initial setup — project configuration complete.

## Goals
[From Q5]

## Completed
- [Today's date] — Claude Code MD System Setup complete

## Up Next
[First thing to build — ask user if not clear from Q5]

## Blockers / Open Decisions
None

## Where We Left Off
Project just configured. Ready to begin development.

---
*Last updated: [today's date]*
```

### 2.8 — `docs/changelog.md`

```markdown
# Changelog

## [Today's date]
- Initial Claude Code MD System Setup complete
- Created: CLAUDE.md, .claude/rules/, .claude/settings.json, docs/

---
```

### 2.9 — `docs/session-checkpoint.md`

Create the initial checkpoint file:

```markdown
# Session Checkpoint
> **Status:** COMPLETE
> **Last saved:** [today's date]

## Current Goal
_No session in progress._

## Recent Messages
_none_

## Files Modified
_none_

## Recent Activity
_none_
```

### 2.10 — `CLAUDE.local.md` reminder

Tell the user:
```
💡 Tip: If you have personal preferences that shouldn't be shared with the team,
create a CLAUDE.local.md file in the project root and add it to .gitignore.
This file is loaded automatically but never committed.
```

---

## PHASE 3 — Auto Audit

After creating all files, automatically run the Audit process (cc-audit logic) and display the report.

---

## PHASE 4 — Auto Fix

If the Audit found any CRITICAL or HIGH issues, automatically fix them.
Report what was fixed.

---

## PHASE 5 — Completion Summary

Display:
```
✅ Claude Code MD System Setup Complete
────────────────────────────────────────
Files created:
  CLAUDE.md
  .claude/rules/conventions.md
  .claude/rules/workflow.md
  [.claude/rules/agents.md — if applicable]
  .claude/settings.json
  docs/architecture.md
  docs/project-status.md
  docs/changelog.md
  docs/session-checkpoint.md

Next steps:
  • Review CLAUDE.md and adjust the "Do NOT" section as you work
  • Run /cc-refresh at the end of each session
  • Run /cc-audit periodically to catch issues
  • Add CLAUDE.local.md for personal preferences (gitignore it)

Available commands:
  /cc-menu    /cc-audit   /cc-fix
  /cc-refresh /cc-prune   /cc-export  /cc-import
```

---

**Skill Author:** John Hutchison - McCarthyAI.com
