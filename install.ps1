# Claude Code MD System - Windows PowerShell Installer
# https://github.com/hutchisonjohn/claude-code-md-system
# Author: John Hutchison - McCarthyAI.com

$CommandsDir = "$env:USERPROFILE\.claude\commands"
$ScriptDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceDir   = Join-Path $ScriptDir "commands"

Write-Host ""
Write-Host "=================================================="
Write-Host "  Claude Code MD System - Installer"
Write-Host "  github.com/hutchisonjohn/claude-code-md-system"
Write-Host "=================================================="
Write-Host ""

# Check source files exist
if (-not (Test-Path $SourceDir)) {
    Write-Host "ERROR: commands\ directory not found at $SourceDir"
    Write-Host "Please run this script from the repo root directory."
    exit 1
}

$sourceFiles = Get-ChildItem -Path $SourceDir -Filter "cc-*.md"
if ($sourceFiles.Count -eq 0) {
    Write-Host "ERROR: No cc-*.md files found in $SourceDir"
    exit 1
}

# Create ~/.claude/commands/ if needed
if (-not (Test-Path $CommandsDir)) {
    Write-Host "Creating $CommandsDir ..."
    New-Item -ItemType Directory -Path $CommandsDir -Force | Out-Null
    Write-Host "  Created."
    Write-Host ""
}

# Check for existing installations
$existing = Get-ChildItem -Path $CommandsDir -Filter "cc-*.md" -ErrorAction SilentlyContinue
if ($existing.Count -gt 0) {
    Write-Host "WARNING: Found $($existing.Count) existing cc-*.md file(s) in $CommandsDir"
    Write-Host ""
    $confirm = Read-Host "Overwrite existing files? (y/N)"
    Write-Host ""
    if ($confirm -notmatch "^[Yy]$") {
        Write-Host "Installation cancelled. No files were changed."
        exit 0
    }
}

# Install commands
Write-Host "Installing commands to $CommandsDir ..."
Write-Host ""
$count = 0
foreach ($file in $sourceFiles) {
    Copy-Item -Path $file.FullName -Destination (Join-Path $CommandsDir $file.Name) -Force
    Write-Host "  OK: $($file.Name)"
    $count = $count + 1
}

# Success
Write-Host ""
Write-Host "=================================================="
Write-Host "  DONE - $count commands installed successfully"
Write-Host "=================================================="
Write-Host ""
Write-Host "Commands available in every Claude Code project:"
Write-Host ""
Write-Host "  /cc-menu     Open the numbered menu"
Write-Host "  /cc-setup    First-time project setup"
Write-Host "  /cc-audit    Health check"
Write-Host "  /cc-fix      Auto-repair issues"
Write-Host "  /cc-refresh  End-of-session update"
Write-Host "  /cc-prune    Remove stale content"
Write-Host "  /cc-export   Export setup to portable file"
Write-Host "  /cc-import   Import from export file"
Write-Host "  /cc-guide    Open the full How To Use guide"
Write-Host "  /cc-help     Quick reference cheat sheet"
Write-Host ""
Write-Host "Getting started:"
Write-Host "  1. Open a project folder in Claude Code"
Write-Host "  2. Run: /cc-setup"
Write-Host "  3. Answer the 10 questions"
Write-Host ""
Write-Host "  Full guide: github.com/hutchisonjohn/claude-code-md-system"
Write-Host ""
