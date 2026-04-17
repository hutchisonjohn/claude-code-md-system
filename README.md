# Claude Code MD System

> A complete setup, audit, and maintenance system for your Claude Code project configuration — built as globally-installed slash commands.

**By John Hutchison — [McCarthyAI.com](https://mccarthyai.com)**

---

## What Is This?

Claude Code is powerful — but without proper configuration, every session starts cold. No memory of your project. No coding standards. No safety guardrails. No continuity.

The **Claude Code MD System** solves this by giving you a structured set of markdown files that Claude reads automatically, plus a menu-driven command system to create, audit, fix, and maintain them — across any project, on any machine.

Ten slash commands. Install once. Use everywhere.

```
/cc-menu     /cc-setup    /cc-audit    /cc-fix
/cc-refresh  /cc-prune    /cc-export   /cc-import
/cc-guide    /cc-help
```

---

## Inspiration

This system was built on the shoulders of two people who have thought deeply about how to work effectively with Claude Code.

### Andrej Karpathy — Coding Principles

Karpathy's four principles are baked into the global `CLAUDE.md` that this system installs:

| Principle | What it means |
|-----------|--------------|
| **Think Before Coding** | State assumptions explicitly. Surface tradeoffs. Ask before guessing. |
| **Simplicity First** | Minimum code that solves the problem. Nothing speculative. |
| **Surgical Changes** | Touch only what you must. Match existing style. Don't refactor things that aren't broken. |
| **Goal-Driven Execution** | Define success criteria. Loop until verified. |

> Reference: [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills)

### Boris (Claude Code Creator, Anthropic)

Boris's workflow insights shaped the architecture of this entire system:

- **CLAUDE.md = air traffic control tower**, not an encyclopedia — keep it short (~50 lines), route to everything else
- **`project-status.md` is essential** — sessions have no memory; this file is how continuity works
- **Layered context** — global rules → project rules → on-demand rules → docs
- **Stop hooks** — automatic test verification when Claude finishes a task
- **Sub-agents in forked contexts** — isolated, parallel, don't pollute your main session

---

## The Architecture

### Layer System

Every Claude Code session loads context in this order — from most general to most specific:

```
LAYER 1 — Global (every session, every project)
  ~/.claude/CLAUDE.md          ← Karpathy principles + your universal rules
  ~/.claude/settings.json      ← Global permissions and hooks

LAYER 2 — Project Air Traffic Control
  /project/CLAUDE.md           ← ~50 lines. Routes Claude to everything else.
  /project/.claude/settings.json

LAYER 3 — Rules (loaded on-demand, saves context window)
  /project/.claude/rules/conventions.md
  /project/.claude/rules/workflow.md
  /project/.claude/rules/agents.md

LAYER 4 — Specialists (invoked when needed)
  /project/.claude/agents/     ← Sub-agents, run in isolated context windows
  /project/.claude/commands/   ← /slash-commands, wait to be invoked
  /project/.claude/skills/     ← Auto-triggering behaviours

LAYER 5 — Living Docs (referenced, kept current)
  /project/docs/architecture.md
  /project/docs/project-status.md   ← Session continuity ⭐
  /project/docs/changelog.md
```

### How It All Connects

```
┌─────────────────────────────────────────────────────────┐
│                   EVERY SESSION LOADS                    │
│  ~/.claude/CLAUDE.md  ←  Global rules (Karpathy etc.)   │
│  ~/.claude/settings.json  ←  Global permissions/hooks   │
└───────────────────────┬─────────────────────────────────┘
                        │ stacks with ↓
┌───────────────────────▼─────────────────────────────────┐
│              PROJECT: CLAUDE.md  (~50 lines)             │
│         "Air traffic control — not encyclopedia"         │
│  • What this project is                                  │
│  • Tech stack                                            │
│  • How to verify work                                    │
│  • What NOT to do                                        │
│  • Links → rules/, docs/                                 │
└──────┬──────────────┬───────────────┬────────────────────┘
       │              │               │
       ▼              ▼               ▼
┌──────────┐  ┌──────────────┐  ┌──────────────────┐
│  rules/  │  │  agents/     │  │  commands/       │
│          │  │              │  │  skills/         │
│ Loaded   │  │ Invoked by   │  │ /slash-command   │
│ on-demand│  │ name or auto │  │ Skills = always  │
│ per task │  │              │  │ watching         │
└──────┬───┘  └──────┬───────┘  └────────┬─────────┘
       │              │                    │
       └──────────────┴────────────────────┘
                        │ all reference ↓
              ┌─────────▼──────────┐
              │      docs/         │
              │  architecture.md   │
              │  project-status.md │◄── Session continuity
              │  changelog.md      │
              └────────────────────┘
```

### Files Created by `/cc-setup`

```
your-project/
├── CLAUDE.md                        ← Air traffic control (~50 lines)
├── CLAUDE.local.md                  ← Your personal overrides (gitignored)
│
├── .claude/
│   ├── settings.json                ← Permissions + hooks
│   ├── settings.local.json          ← Personal settings (gitignored)
│   │
│   └── rules/
│       ├── conventions.md           ← Naming, style, file size rules
│       ├── workflow.md              ← How features get built
│       └── agents.md               ← Agent/automation rules (if applicable)
│
└── docs/
    ├── architecture.md              ← System design, kept up to date
    ├── project-status.md            ← Current state, session continuity ⭐
    └── changelog.md                 ← What changed and when
```

---

## Installation

### Windows (PowerShell)

**One command — paste into PowerShell and press Enter:**

```powershell
git clone https://github.com/hutchisonjohn/claude-code-md-system.git "$env:TEMP\cc-system"; Set-Location "$env:TEMP\cc-system"; .\install.ps1
```

Or step by step:
```powershell
git clone https://github.com/hutchisonjohn/claude-code-md-system.git "$env:TEMP\cc-system"
Set-Location "$env:TEMP\cc-system"
.\install.ps1
```

### macOS / Linux

**One command — paste into Terminal and press Enter:**

```bash
git clone https://github.com/hutchisonjohn/claude-code-md-system.git /tmp/cc-system && chmod +x /tmp/cc-system/install.sh && /tmp/cc-system/install.sh
```

### Manual Install (any platform)

```bash
# Create the global commands directory if it doesn't exist
mkdir -p ~/.claude/commands

# Copy all command files
cp /path/to/claude-code-md-system/commands/cc-*.md ~/.claude/commands/
```

### What Gets Installed

The installer copies 10 markdown files into `~/.claude/commands/`:

```
~/.claude/commands/
├── cc-menu.md
├── cc-setup.md
├── cc-audit.md
├── cc-fix.md
├── cc-refresh.md
├── cc-prune.md
├── cc-export.md
├── cc-import.md
├── cc-guide.md
└── cc-help.md
```

These become globally available as `/cc-*` slash commands in **every** Claude Code project on your machine.

### Requirements

- [Claude Code](https://claude.ai/code) installed
- A `~/.claude/` directory (created automatically by Claude Code)
- macOS, Linux, or Windows with Git Bash / WSL

---

## Usage

### First Time on a New Project

Open Claude Code in your project folder and run:

```
/cc-setup
```

That's it. It will:
1. Check for existing files (and offer Merge / Replace if found)
2. Ask you 10 questions about your project
3. Create all MD files automatically
4. Run an audit immediately after
5. Fix any issues it found

### Every Session

```
Start:  Claude automatically loads CLAUDE.md and project-status.md
Work:   Build your features normally
End:    /cc-refresh   ← Update status and changelog
```

### The Full Command System

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
╚══════════════════════════════════════════════════════════╝
```

---

## Command Reference

| Command | What it does | When to use |
|---------|-------------|-------------|
| `/cc-menu` | Open the numbered menu | Any time |
| `/cc-setup` | First-time full setup — interview, create all files, audit & fix | **Once per new project** |
| `/cc-audit` | Health check — report issues as CRITICAL/HIGH/MEDIUM/LOW | Periodically |
| `/cc-fix` | Auto-repair CRITICAL and HIGH issues | After audit |
| `/cc-refresh` | End-of-session update — status + changelog | **Every session ⭐** |
| `/cc-prune` | Review and remove stale, vague or unused content | Every few weeks |
| `/cc-export` | Package entire `.claude/` setup into portable `claude-code-export.md` | Moving machines / sharing |
| `/cc-import` | Load a `claude-code-export.md` into this project (merge or replace) | New machine / similar project |
| `/cc-guide` | Write the full How To Use guide as an MD file in your project root | Reference |
| `/cc-help` | Display quick command reference cheat sheet in terminal | Quick lookup |

---

## Audit Severity Levels

`/cc-audit` reports issues at four severity levels:

| Level | Meaning | Example | Action |
|-------|---------|---------|--------|
| **CRITICAL** | Dangerous now | Force push not blocked in settings.json | Fix immediately |
| **HIGH** | Will cause problems | No verification command, missing project-status.md | Fix soon |
| **MEDIUM** | Will cause inefficiency | Vague rules, missing links between files | Fix when possible |
| **LOW** | Minor | Stale content, empty placeholder sections | Optional |

**Health scores:**

| Score | Criteria |
|-------|----------|
| `EXCELLENT` | No issues found |
| `GOOD` | Only MEDIUM or LOW issues |
| `FAIR` | 1–2 HIGH issues, no CRITICAL |
| `POOR` | Any CRITICAL, or 3+ HIGH issues |

---

## Export / Import — Moving Between Machines

`/cc-export` creates a single `claude-code-export.md` file containing your entire configuration with built-in import instructions.

```
Old machine:  /cc-export  →  creates claude-code-export.md
Copy:         claude-code-export.md to new project root
New machine:  /cc-import  →  choose Merge or Replace
Verify:       /cc-audit
```

**Never exported** (personal — stays local):
- `CLAUDE.local.md`
- `.claude/settings.local.json`

---

## Recommended Maintenance Cadence

```
New project:   /cc-setup                    (once)
Every session: /cc-refresh                  (end of session, every time ⭐)
Weekly:        /cc-audit → /cc-fix          (if issues found)
Monthly:       /cc-prune → /cc-audit        (to verify health held)
New machine:   /cc-export → copy → /cc-import
```

---

## The Golden Rules

1. **CLAUDE.md = router, not rulebook.** Keep it under 60 lines. Link to everything else.
2. **Update "Do NOT" immediately** when Claude makes a mistake — this is how the system learns.
3. **Run `/cc-refresh` every session** — no exceptions. This is how continuity works.
4. **Use Merge, not Replace, when in doubt** — preserves your existing work.
5. **Export before major changes** — always keep a rollback option.

---

## Files in This Repo

```
claude-code-md-system/
├── README.md           ← You are here
├── install.sh          ← Installer script
└── commands/
    ├── cc-menu.md      ← Main numbered menu
    ├── cc-setup.md     ← First-time project setup (10-question interview)
    ├── cc-audit.md     ← Health check, severity reporting
    ├── cc-fix.md       ← Auto-repair issues
    ├── cc-refresh.md   ← End-of-session update
    ├── cc-prune.md     ← Remove stale/unused content
    ├── cc-export.md    ← Export setup to portable file
    ├── cc-import.md    ← Import from export file (merge or replace)
    ├── cc-guide.md     ← Generate full How To Use guide
    └── cc-help.md      ← Quick reference cheat sheet in terminal
```

---

## Contributing

Issues and PRs welcome. If you have improvements to the command logic, audit checks,
or want to add new commands to the system, open an issue first to discuss.

---

## License

MIT — use freely, adapt freely, attribution appreciated.

---

## Author

**John Hutchison**
Founder — [McCarthyAI.com](https://mccarthyai.com)

Built on the insights of Andrej Karpathy (coding principles) and Boris at Anthropic (Claude Code architecture).
Designed to give every Claude Code user a structured, maintainable, portable project configuration system — out of the box.

---

*Claude Code MD System — making every session pick up exactly where the last one left off.*
