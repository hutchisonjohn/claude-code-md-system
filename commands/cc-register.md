---
description: Claude Code MD System — Register. Adds the current project to your global project registry at ~/.claude/projects.md so you can track all projects across your machine.
---

You are running the Claude Code MD System — REGISTER process.
This adds the current project to your global project registry.

---

## Step 1 — Gather Project Details

**Project path:** Use the current working directory as the path.

**Project name:**
- Read `CLAUDE.md` — extract the project name from the heading (`# CLAUDE.md — [Name]`)
- If not found, use the folder name of the current directory

**Description:**
- Read `CLAUDE.md` — extract the content under `## Project`
- Truncate to 1-2 sentences if longer

**Tech stack:**
- Read `CLAUDE.md` — extract content under `## Tech Stack`
- Summarise as a comma-separated list

**Repo URL:**
- Run: `git remote get-url origin`
- If git command fails or no remote, use `_none_`

**Key files:**
- Check which of these exist and list them: `CLAUDE.md`, `README.md`, `docs/project-status.md`, `docs/architecture.md`, `package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`

**Last session:** Today's date in YYYY-MM-DD format.

---

## Step 2 — Check Global Registry

Determine the home directory:
- On macOS/Linux: `~/.claude/projects.md`
- On Windows: `C:\Users\[username]\.claude\projects.md` — detect username from the current path or environment

Read `~/.claude/projects.md` if it exists.

**If already registered** (match by path):

```
This project is already in your registry.

Current entry:
[show existing entry]

Update it with current details? (y/N):
```

If yes: replace that entry with fresh details.
If no: stop here.

**If not registered:** proceed to Step 3.

---

## Step 3 — Write to Registry

If `~/.claude/projects.md` does not exist, create it with this header:

```markdown
# Claude Code Project Registry
> Managed by /cc-register. Run /cc-projects to view all projects.

---

```

Append (or update) the project entry in this format:

```markdown
## [project-name]
- **Path:** [full absolute path]
- **Repo:** [repo URL or _none_]
- **Description:** [1-2 sentence description]
- **Stack:** [comma-separated stack]
- **Key files:** [list of existing key files]
- **Last session:** [today's date]
- **Status:** active

---

```

---

## Step 4 — Confirm

```
✅ Project registered
─────────────────────────────
Name:         [name]
Path:         [path]
Repo:         [repo]
Last session: [date]

Registry: ~/.claude/projects.md
Total projects registered: [n]

Run /cc-projects to view all projects.
```

---

**Skill Author:** John Hutchison - McCarthyAI.com
