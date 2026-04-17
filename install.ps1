# ============================================================
# Claude Code MD System — Windows PowerShell Installer
# https://github.com/hutchisonjohn/claude-code-md-system
#
# Run from PowerShell:
#   irm https://raw.githubusercontent.com/hutchisonjohn/claude-code-md-system/main/install.ps1 | iex
#
# Or after cloning:
#   .\install.ps1
#
# Author: John Hutchison — McCarthyAI.com
# ============================================================

$CommandsDir = "$env:USERPROFILE\.claude\commands"
$ScriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceDir   = Join-Path $ScriptDir "commands"

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════╗"
Write-Host "║        Claude Code MD System — Installer                 ║"
Write-Host "║        https://github.com/hutchisonjohn/                 ║"
Write-Host "║        claude-code-md-system                             ║"
Write-Host "╚══════════════════════════════════════════════════════════╝"
Write-Host ""

# Check source files exist
if (-not (Test-Path $SourceDir)) {
    Write-Host "❌ Error: commands\ directory not found at $SourceDir"
    Write-Host "   Please run this script from the repo root directory."
    exit 1
}

$sourceFiles = Get-ChildItem -Path $SourceDir -Filter "cc-*.md"
if ($sourceFiles.Count -eq 0) {
    Write-Host "❌ Error: No cc-*.md files found in $SourceDir"
    exit 1
}

# Create ~/.claude/commands/ if needed
if (-not (Test-Path $CommandsDir)) {
    Write-Host "Creating $CommandsDir ..."
    New-Item -ItemType Directory -Path $CommandsDir -Force | Out-Null
    Write-Host "  ✓ Directory created"
    Write-Host ""
}

# Check for existing installations
$existing = Get-ChildItem -Path $CommandsDir -Filter "cc-*.md" -ErrorAction SilentlyContinue
if ($existing.Count -gt 0) {
    Write-Host "⚠  Found $($existing.Count) existing cc-*.md file(s) in $CommandsDir"
    Write-Host ""
    $confirm = Read-Host "   Overwrite existing files? (y/N)"
    Write-Host ""
    if ($confirm -notmatch "^[Yy]$") {
        Write-Host "Installation cancelled. No files were changed."
        Write-Host ""
        exit 0
    }
}

# Install commands
Write-Host "Installing commands to $CommandsDir ..."
Write-Host ""
$count = 0
foreach ($file in $sourceFiles) {
    Copy-Item -Path $file.FullName -Destination "$CommandsDir\$($file.Name)" -Force
    Write-Host "  ✓ $($file.Name)"
    $count++
}

# Success
Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════╗"
Write-Host "║  ✅ Installation complete — $count commands installed"
Write-Host "╚══════════════════════════════════════════════════════════╝"
Write-Host ""
Write-Host "Commands now available in every Claude Code project:"
Write-Host ""
Write-Host "  /cc-menu     Open the numbered menu"
Write-Host "  /cc-setup    First-time project setup (run once per project)"
Write-Host "  /cc-audit    Health check — report issues by severity"
Write-Host "  /cc-fix      Auto-repair CRITICAL and HIGH issues"
Write-Host "  /cc-refresh  End-of-session update (run every session)"
Write-Host "  /cc-prune    Remove stale or unused content"
Write-Host "  /cc-export   Export setup to a portable file"
Write-Host "  /cc-import   Import from a claude-code-export.md file"
Write-Host "  /cc-guide    Open the full How To Use guide"
Write-Host "  /cc-help     Quick reference cheat sheet"
Write-Host ""
Write-Host "── Getting started ─────────────────────────────────────"
Write-Host ""
Write-Host "  1. Open a project folder in Claude Code"
Write-Host "  2. Run: /cc-setup"
Write-Host "  3. Answer the 10 questions"
Write-Host "  4. Claude creates all your MD files automatically"
Write-Host ""
Write-Host "  Run /cc-refresh at the end of every session."
Write-Host ""
Write-Host "  Full guide: https://github.com/hutchisonjohn/claude-code-md-system"
Write-Host ""
