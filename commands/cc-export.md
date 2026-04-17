---
description: Claude Code MD System Setup — Export. Package your entire .claude/ configuration into a single portable markdown file for use on another machine or project.
---

You are running the Claude Code MD System Setup — EXPORT process.
Bundle the entire Claude MD configuration for this project into one portable file.

---

## Step 1 — Collect All Files

Read and collect the full content of each file that exists:

**Core:**
- `CLAUDE.md`
- `.claude/settings.json`

**Rules:**
- All files in `.claude/rules/`

**Agents:**
- All files in `.claude/agents/`

**Commands:**
- All files in `.claude/commands/`

**Skills:**
- All files in `.claude/skills/`

**Docs:**
- `docs/architecture.md`
- `docs/project-status.md`
- `docs/changelog.md`

---

## Step 2 — Generate Export File

Create a file named `claude-code-export.md` in the project root with this structure:

```markdown
# Claude Code MD System — Export
## Project: [Project Name from CLAUDE.md]
## Exported: [Today's date and time]
## Source Machine: [hostname if available, otherwise omit]

---

## HOW TO IMPORT THIS FILE

This file contains your complete Claude Code MD System configuration.
To import it into a new project or machine:

1. Copy this file (`claude-code-export.md`) into the ROOT of your new project folder.
   ⚠ The file must be in the project root — not a subfolder.

2. Open Claude Code in that project folder.

3. Run: /cc-import
   Claude Code will detect the export file and guide you through the import.

4. When prompted, choose:
   - Merge  — to blend with any existing configuration
   - Replace — to start fresh with this configuration

5. After import, run /cc-audit to verify everything is healthy.

6. Run /cc-refresh at the end of your first session to update project-status.md.

---

## CONFIGURATION FILES

The following files will be recreated during import.
Each section begins with the target file path.

---

### FILE: CLAUDE.md
[Full content of CLAUDE.md]

---

### FILE: .claude/settings.json
[Full content of settings.json]

---

### FILE: .claude/rules/conventions.md
[Full content — or "NOT PRESENT" if file doesn't exist]

---

### FILE: .claude/rules/workflow.md
[Full content — or "NOT PRESENT"]

---

### FILE: .claude/rules/[any other rule files]
[Full content of each]

---

### FILE: .claude/agents/[agent files]
[Full content of each — or "NONE" if no agents]

---

### FILE: .claude/commands/[command files — EXCLUDE the cc-*.md system commands]
[Full content of each custom command only]

---

### FILE: .claude/skills/[skill files]
[Full content of each — or "NONE" if no skills]

---

### FILE: docs/architecture.md
[Full content — or "NOT PRESENT"]

---

### FILE: docs/project-status.md
[Full content — or "NOT PRESENT"]

---

### FILE: docs/changelog.md
[Full content — or "NOT PRESENT"]

---

## END OF EXPORT
```

**Important — exclude from export:**
- `CLAUDE.local.md` (personal preferences — never exported)
- `settings.local.json` (personal settings — never exported)
- The cc-*.md system commands themselves (cc-menu, cc-setup, cc-audit, cc-fix, cc-refresh, cc-prune, cc-export, cc-import) — these are global and should already exist on the target machine

---

## Step 3 — Confirm Creation

```
✅ Export Complete
──────────────────
File created: claude-code-export.md (project root)

This file contains your complete Claude Code MD configuration.

To use on another machine or project:
  1. Copy claude-code-export.md to the new project root
  2. Open Claude Code in that project
  3. Run /cc-import

⚠ Note: CLAUDE.local.md and settings.local.json are NOT included
  (these are personal and machine-specific).

⚠ Note: The cc-*.md system commands are NOT included
  (they should already be installed globally on the target machine).
  If not installed, run /cc-menu on the target machine first.
```

---

**Skill Author:** John Hutchison - McCarthyAI.com
