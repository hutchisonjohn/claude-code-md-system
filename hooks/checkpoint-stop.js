#!/usr/bin/env node
// Stop hook — marks checkpoint as clean exit (COMPLETE)
// Runs when Claude finishes responding or session ends gracefully

const fs = require('fs');
const path = require('path');

// Consume stdin (required for hooks even if unused)
let raw = '';
process.stdin.setEncoding('utf8');
process.stdin.on('data', c => raw += c);
process.stdin.on('end', () => {
  const file = path.join(process.cwd(), 'docs', 'session-checkpoint.md');

  try {
    let text = fs.readFileSync(file, 'utf8');
    const ts = new Date().toISOString().replace('T', ' ').slice(0, 19);

    text = text
      .replace(/\*\*Status:\*\* \w+/, '**Status:** COMPLETE')
      .replace(/\*\*Last saved:\*\* [^\n]+/, `**Last saved:** ${ts}`)
      .replace(/\n> \*\*To resume:\*\*[^\n]+/, '');

    fs.writeFileSync(file, text, 'utf8');
  } catch {
    // No checkpoint file — nothing to mark
  }
});
