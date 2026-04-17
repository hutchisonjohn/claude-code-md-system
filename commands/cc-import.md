---
description: Claude Code MD System Setup — Import. Load a previously exported Claude Code MD configuration into this project from a claude-code-export.md file.
---

You are running the Claude Code MD System Setup — IMPORT process.
Load a Claude Code MD configuration from an export file into this project.

---

## Step 1 — Locate the Export File

Tell the user:
```
To import a Claude Code MD configuration, you need a claude-code-export.md file.

⚠ This file must be in your project root folder (the same folder you opened Claude Code in).

Is your export file ready? Enter the filename if different from the default,
or press Enter to use the default: claude-code-export.md
```

Check for the file at the project root. If not found:
```
❌ File not found: [filename] in the project root.

Please ensure:
  1. The file is named correctly (default: claude-code-export.md)
  2. The file is in the ROOT of this project folder — not a subfolder
  3. You are running Claude Code from the correct project directory

To verify your current directory, run: !pwd

Try again with the correct filename, or type 'cancel' to exit.
```

Retry until the file is found or the user cancels.

---

## Step 2 — Validate the Export File

Read the file and verify it:
- Has the `# Claude Code MD System — Export` header
- Contains at least one `### FILE:` section
- Is not empty or corrupted

If invalid:
```
❌ This file does not appear to be a valid Claude Code MD export file.

Expected format: a file starting with "# Claude Code MD System — Export"
containing ### FILE: sections.

Please check the file and try again.
```

---

## Step 3 — Show Export Summary

Display what was found in the export file:
```
📦 Export File Summary
────────────────────────
Project:   [project name from export]
Exported:  [export date]

Files included in this export:
  ✓ CLAUDE.md
  ✓ .claude/settings.json
  ✓ .claude/rules/conventions.md
  [etc — list all files found in the export]

Files NOT included:
  — CLAUDE.local.md (personal — not exported by design)
  — settings.local.json (personal — not exported by design)
```

---

## Step 4 — Check for Existing Files

Check which of the files to be imported already exist in this project.

If any existing files are found:
```
⚠ Existing files detected.

The following files already exist in this project and would be affected:
  [list existing files]

How would you like to proceed?

  M — Merge   (keep existing content, add only missing sections from import)
  R — Replace (overwrite existing files with imported versions)
  C — Cancel  (abort import)

Your choice (M/R/C):
```

If no existing files — proceed directly to import.

---

## Step 5A — Merge Mode

For each file in the export:
1. Read the existing file (if it exists)
2. Read the imported version
3. Compare sections
4. Add sections that are missing from the existing file
5. Keep existing content where it conflicts (existing takes priority in merge)
6. Add a comment where content was preserved: `# [Kept from existing — review and update if needed]`

---

## Step 5R — Replace Mode

For each file in the export:
1. Parse the `### FILE: [path]` section
2. Extract the file content
3. Write it to the specified path (create directories as needed)
4. Report each file written

---

## Step 6 — Post-Import Setup

After writing all files:

1. Check if `.gitignore` exists. If yes, check if `CLAUDE.local.md` and `settings.local.json` are listed. If not, add them.
   If no `.gitignore` exists, create one with at minimum:
   ```
   CLAUDE.local.md
   .claude/settings.local.json
   ```

2. Check if the cc-*.md system commands exist globally in `~/.claude/commands/`.
   If any are missing, warn the user:
   ```
   ⚠ Some Claude Code MD System commands appear to be missing from your global setup.
   Missing: [list]
   These commands should be installed globally. If this is a new machine,
   you may need to copy the cc-*.md files from your previous machine to ~/.claude/commands/
   ```

---

## Step 7 — Run Auto-Audit

Run the Audit (cc-audit logic) on the newly imported configuration and display the health report.

---

## Step 8 — Completion Message

```
✅ Import Complete
──────────────────
Files written: [n]
Mode: [Merge / Replace]

Audit result: [EXCELLENT / GOOD / FAIR / POOR]
[Show any CRITICAL or HIGH issues from audit]

Recommended next steps:
  1. Review CLAUDE.md — update the "Do NOT" section for this specific project
  2. Update docs/project-status.md with your current project state
  3. Run /cc-refresh at the end of your first session
  4. Add CLAUDE.local.md for any personal preferences (it's already gitignored)

Available commands:
  /cc-menu  /cc-audit  /cc-fix  /cc-refresh  /cc-prune  /cc-export
```

---

**Skill Author:** John Hutchison - McCarthyAI.com
