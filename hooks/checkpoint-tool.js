#!/usr/bin/env node
// PostToolUse hook — tracks tool activity and file modifications in session checkpoint
// Silently skips if docs/ doesn't exist or no checkpoint started yet

const fs = require('fs');
const path = require('path');

let raw = '';
process.stdin.setEncoding('utf8');
process.stdin.on('data', c => raw += c);
process.stdin.on('end', () => {
  let data;
  try { data = JSON.parse(raw); } catch { return; }

  const toolName = data.tool_name || '';
  const toolInput = data.tool_input || {};

  const docsDir = path.join(process.cwd(), 'docs');
  if (!fs.existsSync(docsDir)) return;

  const file = path.join(docsDir, 'session-checkpoint.md');
  if (!fs.existsSync(file)) return; // No checkpoint yet — wait for first user message

  let cp = {};
  try { cp = parse(fs.readFileSync(file, 'utf8')); } catch { return; }
  if (!cp.status) return;

  const now = new Date();
  const ts = now.toISOString().replace('T', ' ').slice(0, 19);
  const t = now.toTimeString().slice(0, 5);

  const filePath = toolInput.file_path || toolInput.path || '';
  const label = filePath ? `${toolName} → ${filePath}` : toolName;

  // Activity log (rolling 15)
  const activity = cp.activity || [];
  activity.push(`- \`${t}\` — ${label}`);
  cp.activity = activity.slice(-15);

  // Files modified (deduplicated)
  if (['Write', 'Edit', 'MultiEdit', 'NotebookEdit'].includes(toolName) && filePath) {
    const files = cp.files || [];
    const entry = `- ${filePath}`;
    if (!files.includes(entry)) files.push(entry);
    cp.files = files;
  }

  cp.lastSaved = ts;

  try { fs.writeFileSync(file, render(cp), 'utf8'); } catch {}
});

function parse(text) {
  const get = (section) => {
    const m = text.match(new RegExp(`## ${section}\n([\\s\\S]*?)(?=\n## |\n$|$)`));
    return m ? m[1].trim() : '';
  };
  const statusM = text.match(/\*\*Status:\*\* (\w+)/);
  return {
    status: statusM ? statusM[1] : 'IN_PROGRESS',
    goal: get('Current Goal'),
    messages: get('Recent Messages').split('\n').filter(l => l.startsWith('- `')),
    files: get('Files Modified').split('\n').filter(l => l.startsWith('- ')),
    activity: get('Recent Activity').split('\n').filter(l => l.startsWith('- `')),
  };
}

function render(cp) {
  const status = cp.status || 'IN_PROGRESS';
  const resumeLine = status === 'IN_PROGRESS'
    ? '\n> **To resume:** Run `/cc-recover` in Claude Code'
    : '';
  return `# Session Checkpoint
> **Status:** ${status}
> **Last saved:** ${cp.lastSaved || ''}${resumeLine}

## Current Goal
${cp.goal || '_not set_'}

## Recent Messages
${(cp.messages || []).join('\n') || '_none_'}

## Files Modified
${(cp.files || []).join('\n') || '_none_'}

## Recent Activity
${(cp.activity || []).join('\n') || '_none_'}
`;
}
