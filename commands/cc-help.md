---
description: Claude Code MD System Setup — Help. Displays a quick command reference and cheat sheet in the terminal.
---

Display the following quick reference exactly, then return to normal:

```
╔══════════════════════════════════════════════════════════════╗
║          Claude Code MD System — Quick Reference             ║
╠══════════════════════════════════════════════════════════════╣
║                                                              ║
║  COMMANDS                                                    ║
║  ─────────────────────────────────────────────────────────  ║
║  /cc-menu     Open the numbered menu                         ║
║  /cc-setup    First-time full setup (run once per project)   ║
║  /cc-audit    Health check — report issues by severity       ║
║  /cc-fix      Auto-repair CRITICAL and HIGH issues           ║
║  /cc-refresh  End-of-session update (run every session)      ║
║  /cc-prune    Remove stale, vague or unused content          ║
║  /cc-export   Package setup into portable export file        ║
║  /cc-import   Load setup from a claude-code-export.md file   ║
║  /cc-guide      Open the full How To Use guide as an MD file ║
║  /cc-help       Show this quick reference                    ║
║  /cc-recover    Restore context after crash / power failure  ║
║  /cc-register   Add this project to global registry         ║
║  /cc-projects   List all registered projects                 ║
║  /cc-env-export  Export full environment to portable file    ║
║  /cc-env-import  Restore environment on a new machine        ║
║                                                              ║
║  RECOMMENDED WORKFLOW                                        ║
║  ─────────────────────────────────────────────────────────  ║
║  New project:   /cc-setup  (once)                            ║
║  Every session: /cc-refresh  (at the end)                    ║
║  Weekly:        /cc-audit  → /cc-fix if issues found         ║
║  Monthly:       /cc-prune  → /cc-audit to verify             ║
║  New machine:   /cc-export → copy file → /cc-import          ║
║                                                              ║
║  FILES CREATED BY THIS SYSTEM                                ║
║  ─────────────────────────────────────────────────────────  ║
║  CLAUDE.md                    Air traffic control (~50 lines) ║
║  CLAUDE.local.md              Personal overrides (gitignored) ║
║  .claude/settings.json        Permissions + hooks             ║
║  .claude/rules/conventions.md Naming, style, size rules       ║
║  .claude/rules/workflow.md    How features get built          ║
║  docs/architecture.md         System design (kept current)    ║
║  docs/project-status.md       Session continuity ⭐ key file  ║
║  docs/changelog.md            What changed and when           ║
║                                                              ║
║  SEVERITY LEVELS (Audit)                                     ║
║  ─────────────────────────────────────────────────────────  ║
║  CRITICAL  Fix immediately (e.g. force push not blocked)     ║
║  HIGH      Fix soon (e.g. no verification command)           ║
║  MEDIUM    Fix when possible (e.g. vague rules)              ║
║  LOW       Optional (e.g. stale content)                     ║
║                                                              ║
║  GOLDEN RULES                                                ║
║  ─────────────────────────────────────────────────────────  ║
║  • CLAUDE.md = router, not rulebook. Keep it under 60 lines  ║
║  • Add to "Do NOT" immediately when Claude makes a mistake   ║
║  • Run /cc-refresh at the end of EVERY session               ║
║  • Use Merge (not Replace) when in doubt                     ║
║  • Export before major changes so you can roll back          ║
║                                                              ║
║  Full guide:  /cc-guide   Full menu:  /cc-menu               ║
╚══════════════════════════════════════════════════════════════╝
```

---

**Skill Author:** John Hutchison - McCarthyAI.com
