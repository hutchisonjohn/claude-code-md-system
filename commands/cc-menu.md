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
║  ── Recovery & Environment ───────────────────────────  ║
║  10. Recover   Restore context after crash or power      ║
║                failure. Reads session checkpoint.        ║
║                                                          ║
║  11. Register  Add this project to your global           ║
║                project registry.                         ║
║                                                          ║
║  12. Projects  List all registered projects and          ║
║                their status across your machine.         ║
║                                                          ║
║  13. Env Export   Export full environment to a           ║
║                   portable file (new machine setup).     ║
║                                                          ║
║  14. Env Import   Restore environment from export        ║
║                   file on a new machine.                 ║
║                                                          ║
║  Also: /cc-recover /cc-register /cc-projects             ║
║        /cc-env-export /cc-env-import                     ║
╚══════════════════════════════════════════════════════════╝

Select an option (1-14):
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

- 10 → Execute the Recover process (see /cc-recover instructions)
- 11 → Execute the Register process (see /cc-register instructions)
- 12 → Execute the Projects process (see /cc-projects instructions)
- 13 → Execute the Env Export process (see /cc-env-export instructions)
- 14 → Execute the Env Import process (see /cc-env-import instructions)

If the user types anything other than 1-14, display the menu again.

---

**Skill Author:** John Hutchison - McCarthyAI.com
