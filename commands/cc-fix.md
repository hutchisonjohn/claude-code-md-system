---
description: Claude Code MD System Setup — Fix. Repair bloat, sharpen vague rules, create missing files, and optimise the Claude MD configuration.
---

You are running the Claude Code MD System Setup — FIX process.
Read all existing Claude MD files, identify issues, and repair them.

---

## Step 1 — Run Audit First

Run the full Audit check (cc-audit logic) internally to identify all issues.
Do not display the full audit report — just collect the issues list.

---

## Step 2 — Fix CRITICAL Issues First

For each CRITICAL issue found, fix it immediately before moving on.

**Force push not denied:**
Add to `.claude/settings.json` permissions deny section:
```json
"Bash(git push --force *)",
"Bash(git push -f *)"
```

---

## Step 3 — Fix HIGH Issues

Work through each HIGH issue:

**CLAUDE.md is bloated (over 100 lines):**
1. Identify content in CLAUDE.md that belongs in a rules file
2. Move that content to the appropriate `.claude/rules/*.md` file
3. Replace the moved content in CLAUDE.md with a single link line: `See .claude/rules/[filename].md`
4. Verify CLAUDE.md is now under 80 lines

**Missing sections in CLAUDE.md:**
Add any missing sections: Project, Tech Stack, Verification, Do NOT, links to rules and docs.
For sections requiring specific info (test command, tech stack), insert a placeholder:
`[TODO: fill in — e.g. "npm test"]`

**Missing verification command:**
Add to CLAUDE.md Verification section:
```
Before marking any task complete, state how you will verify the work.
Test command: [TODO: add your test command here]
```

**Missing Do NOT section:**
Add a Do NOT section with safe defaults:
```markdown
## Do NOT
- Never push directly to the main/master branch
- Never hardcode API keys, tokens or passwords (use .env)
- Never add features not explicitly requested
- Never modify files outside the scope of the current task
```

**Missing conventions.md:**
Create `.claude/rules/conventions.md` with standard defaults based on the tech stack detected from CLAUDE.md.

**Missing workflow.md:**
Create `.claude/rules/workflow.md` with standard development workflow.

**Missing settings.json:**
Create `.claude/settings.json` with standard allow/ask/deny permissions and a Stop hook placeholder.

**Missing project-status.md:**
Create `docs/project-status.md` with current date and placeholder content.

---

## Step 4 — Fix MEDIUM Issues

**Vague rules in CLAUDE.md or rules files:**
For each vague rule, rewrite it to be specific and actionable.
Examples:
- "write good code" → "Functions must be under 50 lines. Files must be under 800 lines."
- "be careful with secrets" → "Never hardcode API keys. Always use .env. Never commit .env files."
- "test your work" → "Run [test command] before marking any task complete."

**Missing links in CLAUDE.md:**
Add missing link lines pointing to rules and docs files that exist.

**Missing Stop hook in settings.json:**
If a test command exists in CLAUDE.md, add a Stop hook to settings.json:
```json
"hooks": {
  "Stop": [{
    "matcher": "",
    "hooks": [{"type": "command", "command": "[test command]"}]
  }]
}
```

**Missing architecture.md:**
Create `docs/architecture.md` with placeholder structure.

**Missing changelog.md:**
Create `docs/changelog.md` with today's date entry noting the fix was applied.

---

## Step 5 — Fix LOW Issues

**Stale content:**
Flag (but do not auto-delete) any rules referencing tools or patterns not in the tech stack.
Add a comment: `# NOTE: verify this is still relevant to the current stack`

**Empty doc sections:**
Add placeholder text to empty sections: `[To be documented — add content here]`

---

## Step 6 — Display Fix Report

```
╔══════════════════════════════════════════════════════════╗
║         Claude Code MD System — Fix Report               ║
╚══════════════════════════════════════════════════════════╝

Fixed:
  ✓ [List each fix applied]

Placeholders added (action required):
  ⚠ [List any TODOs added that need human input]

Could not auto-fix (manual action needed):
  ! [List any issues that require human judgement]

─────────────────────────────────────────────────────────
Run /cc-audit to verify the health score has improved.
```

---

**Skill Author:** John Hutchison - McCarthyAI.com
