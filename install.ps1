# Claude Code MD System - Windows PowerShell Installer
# https://github.com/hutchisonjohn/claude-code-md-system
# Author: John Hutchison - McCarthyAI.com

$CommandsDir  = "$env:USERPROFILE\.claude\commands"
$HooksDir     = "$env:USERPROFILE\.claude\hooks"
$ScriptDir    = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceDir    = Join-Path $ScriptDir "commands"
$SourceHooks  = Join-Path $ScriptDir "hooks"

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

# Create ~/.claude/hooks/ if needed
if (-not (Test-Path $HooksDir)) {
    Write-Host "Creating $HooksDir ..."
    New-Item -ItemType Directory -Path $HooksDir -Force | Out-Null
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

# Install checkpoint hooks
Write-Host ""
Write-Host "Installing checkpoint hooks to $HooksDir ..."
Write-Host ""
$hookFiles = Get-ChildItem -Path $SourceHooks -Filter "checkpoint-*.js" -ErrorAction SilentlyContinue
foreach ($hf in $hookFiles) {
    Copy-Item -Path $hf.FullName -Destination (Join-Path $HooksDir $hf.Name) -Force
    Write-Host "  OK: $($hf.Name)"
}

# Register hooks in ~/.claude/settings.json
Write-Host ""
Write-Host "Registering hooks in ~/.claude\settings.json ..."
$settingsPath = "$env:USERPROFILE\.claude\settings.json"
$nodeScript = @"
const fs = require('fs'), os = require('os'), path = require('path');
const sp = '$($settingsPath.Replace('\','\\'))';
let s = {};
try { s = JSON.parse(fs.readFileSync(sp, 'utf8')); } catch {}
if (!s.hooks) s.hooks = {};

const hDir = '$($HooksDir.Replace('\','\\'))';
const cmd = (f) => 'node "' + path.join(hDir, f) + '"';

if (!s.hooks.UserPromptSubmit) s.hooks.UserPromptSubmit = [];
if (!JSON.stringify(s.hooks.UserPromptSubmit).includes('checkpoint-prompt')) {
  s.hooks.UserPromptSubmit.push({ hooks: [{ type: 'command', command: cmd('checkpoint-prompt.js') }] });
}
if (!s.hooks.PostToolUse) s.hooks.PostToolUse = [];
if (!JSON.stringify(s.hooks.PostToolUse).includes('checkpoint-tool')) {
  s.hooks.PostToolUse.push({ hooks: [{ type: 'command', command: cmd('checkpoint-tool.js'), timeout: 10 }] });
}
if (!s.hooks.Stop) s.hooks.Stop = [];
if (!JSON.stringify(s.hooks.Stop).includes('checkpoint-stop')) {
  s.hooks.Stop.push({ hooks: [{ type: 'command', command: cmd('checkpoint-stop.js') }] });
}
fs.writeFileSync(sp, JSON.stringify(s, null, 2));
console.log('  OK: settings.json updated');
"@
try {
    node -e $nodeScript
} catch {
    Write-Host "  WARNING: Could not update settings.json - add hooks manually (see README)"
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
Write-Host "  /cc-recover  Restore context after crash or power failure"
Write-Host "  /cc-prune    Remove stale content"
Write-Host "  /cc-export   Export setup to portable file"
Write-Host "  /cc-import   Import from export file"
Write-Host "  /cc-guide    Open the full How To Use guide"
Write-Host "  /cc-help     Quick reference cheat sheet"
Write-Host ""
Write-Host "Crash recovery:"
Write-Host "  Checkpoint hooks installed globally."
Write-Host "  Claude saves context after every action."
Write-Host "  After a power failure: run /cc-recover to resume."
Write-Host ""
Write-Host "Getting started:"
Write-Host "  1. Open a project folder in Claude Code"
Write-Host "  2. Run: /cc-setup"
Write-Host "  3. Answer the 10 questions"
Write-Host ""
Write-Host "  Full guide: github.com/hutchisonjohn/claude-code-md-system"
Write-Host ""
