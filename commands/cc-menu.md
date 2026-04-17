---
description: Claude Code MD System Setup — main menu. Manage your project's Claude MD files.
---

Display the following menu exactly, then wait for the user to select a number:

```
╔══════════════════════════════════════════════════════════╗
║           Claude Code MD System Setup                    ║
╠══════════════════════════════════════════════════════════╣
║                                                          ║
║  1. Setup    First-time full setup. Interview, create    ║
║              all MD files, audit, and fix in one run.    ║
║              ⚠ Run this once per new project.            ║
║                                                          ║
║  2. Audit    Analyse existing files. Report all issues   ║
║              by severity: CRITICAL / HIGH / MEDIUM / LOW ║
║                                                          ║
║  3. Fix      Repair bloat, sharpen vague rules, fill     ║
║              gaps found by Audit.                        ║
║                                                          ║
║  4. Refresh  End-of-session update. Updates              ║
║              project-status.md and changelog.md.         ║
║                                                          ║
║  5. Prune    Remove stale, vague or unused rules,        ║
║              commands and agent files.                   ║
║                                                          ║
║  6. Export   Package your entire .claude/ setup into a   ║
║              single portable markdown file.              ║
║                                                          ║
║  7. Import   Load a previously exported setup file       ║
║              into this project.                          ║
║                                                          ║
║  8. Guide    Open the full How To Use guide as an MD     ║
║              file in your project root for reference.    ║
║                                                          ║
║  9. Help     Display quick command reference and         ║
║              cheat sheet in the terminal.                ║
║                                                          ║
║  Also available as slash commands:                       ║
║  /cc-setup  /cc-audit  /cc-fix  /cc-refresh              ║
║  /cc-prune  /cc-export  /cc-import  /cc-guide  /cc-help  ║
║                                                          ║
╚══════════════════════════════════════════════════════════╝

Select an option (1-9):
```

Once the user selects:
- 1 → Execute the full Setup process (see /cc-setup instructions)
- 2 → Execute the Audit process (see /cc-audit instructions)
- 3 → Execute the Fix process (see /cc-fix instructions)
- 4 → Execute the Refresh process (see /cc-refresh instructions)
- 5 → Execute the Prune process (see /cc-prune instructions)
- 6 → Execute the Export process (see /cc-export instructions)
- 7 → Execute the Import process (see /cc-import instructions)
- 8 → Execute the Guide process (see /cc-guide instructions)
- 9 → Execute the Help process (see /cc-help instructions)

If the user types anything other than 1-7, display the menu again.

---

**Skill Author:** John Hutchison - McCarthyAI.com
