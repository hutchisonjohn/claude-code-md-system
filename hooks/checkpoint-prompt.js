#!/usr/bin/env node
// UserPromptSubmit hook — captures user goal and updates session checkpoint
// Silently skips if docs/ doesn't exist (project not set up with cc-setup)

const fs = require('fs');
const path = require('path');

let raw = '';
process.stdin.setEncoding('utf8');
process.stdin.on('data', c => raw += c);
process.stdin.on('end', () => {
  let data;
  try { data = JSON.parse(raw); } catch { return; }

  const prompt = (data.prompt || data.message || '').trim();
  if (!prompt) return;

  const docsDir = path.join(process.cwd(), 'docs');
  if (!fs.existsSync(docsDir)) return;

  const file = path.join(docsDir, 'session-checkpoint.md');
  const now = new Date();
  const ts = now.toISOString().replace('T', ' ').slice(0, 19);
  const t = now.toTimeString().slice(0, 5);

  let cp = {};
  try { cp = parse(fs.readFileSync(file, 'utf8')); } catch {}

  cp.status = 'IN_PROGRESS';
  cp.lastSaved = ts;
  cp.goal = prompt.length > 300 ? prompt.slice(0, 297) + '...' : prompt;

  const msgs = cp.messages || [];
  const short = prompt.length > 120 ? prompt.slice(0, 117) + '...' : prompt;
  msgs.push(`- \`${t}\` — ${short}`);
  cp.messages = msgs.slice(-5);

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
