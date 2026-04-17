#!/usr/bin/env bash
# ============================================================
# Claude Code MD System — Installer
# https://github.com/hutchisonjohn/claude-code-md-system
#
# Installs 10 global slash commands into ~/.claude/commands/
# so they are available in every Claude Code project.
#
# Author: John Hutchison — McCarthyAI.com
# ============================================================

set -e

COMMANDS_DIR="$HOME/.claude/commands"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/commands"

# ── Header ──────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║        Claude Code MD System — Installer                 ║"
echo "║        https://github.com/hutchisonjohn/                 ║"
echo "║        claude-code-md-system                             ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# ── Check source files exist ─────────────────────────────────
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: commands/ directory not found at $SOURCE_DIR"
    echo "   Please run this script from the repo root directory."
    exit 1
fi

source_count=$(ls "$SOURCE_DIR"/cc-*.md 2>/dev/null | wc -l)
if [ "$source_count" -eq 0 ]; then
    echo "❌ Error: No cc-*.md files found in $SOURCE_DIR"
    exit 1
fi

# ── Create ~/.claude/commands/ if needed ─────────────────────
if [ ! -d "$COMMANDS_DIR" ]; then
    echo "Creating $COMMANDS_DIR ..."
    mkdir -p "$COMMANDS_DIR"
    echo "  ✓ Directory created"
    echo ""
fi

# ── Check for existing installations ─────────────────────────
existing=$(ls "$COMMANDS_DIR"/cc-*.md 2>/dev/null | wc -l)
if [ "$existing" -gt 0 ]; then
    echo "⚠  Found $existing existing cc-*.md file(s) in $COMMANDS_DIR"
    echo ""
    read -r -p "   Overwrite existing files? (y/N): " confirm
    echo ""
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Installation cancelled. No files were changed."
        echo ""
        exit 0
    fi
fi

# ── Install commands ─────────────────────────────────────────
echo "Installing commands to $COMMANDS_DIR ..."
echo ""
count=0
for file in "$SOURCE_DIR"/cc-*.md; do
    filename=$(basename "$file")
    cp "$file" "$COMMANDS_DIR/$filename"
    echo "  ✓ $filename"
    count=$((count + 1))
done

# ── Success ──────────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║  ✅ Installation complete — $count commands installed"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "Commands now available in every Claude Code project:"
echo ""
echo "  /cc-menu     Open the numbered menu"
echo "  /cc-setup    First-time project setup (run once per project)"
echo "  /cc-audit    Health check — report issues by severity"
echo "  /cc-fix      Auto-repair CRITICAL and HIGH issues"
echo "  /cc-refresh  End-of-session update (run every session)"
echo "  /cc-prune    Remove stale or unused content"
echo "  /cc-export   Export setup to a portable file"
echo "  /cc-import   Import from a claude-code-export.md file"
echo "  /cc-guide    Open the full How To Use guide"
echo "  /cc-help     Quick reference cheat sheet"
echo ""
echo "── Getting started ─────────────────────────────────────"
echo ""
echo "  1. Open a project folder in Claude Code"
echo "  2. Run: /cc-setup"
echo "  3. Answer the 10 questions"
echo "  4. Claude creates all your MD files automatically"
echo ""
echo "  Run /cc-refresh at the end of every session."
echo ""
echo "  Full guide: https://github.com/hutchisonjohn/claude-code-md-system"
echo ""
