# Session Feedback

Analyze the work done in this session and provide feedback across the 5 areas below.

## Analysis Areas

### 1. Documentation Updates
- Identify additions or changes needed in CLAUDE.md
- Look for project conventions, preferred patterns, or caveats discovered in this session
- Verify proposed changes do not duplicate existing CLAUDE.md content

### 2. Learning Record
- What was learned (new techniques, patterns, approaches)
- What went wrong and why (incorrect assumptions, missed edge cases, etc.)
- What was unexpected (behavior that differed from expectations, useful tools/options found)

### 3. Automation Opportunities
- Check for repetitive patterns performed in this session
- If .claude/feedback-log.md exists, cross-reference past entries to identify recurring patterns
- If a pattern is confirmed as recurring, propose a skill, command, or script
- If evidence is insufficient, record as "observing" — do not force a suggestion

### 4. Incomplete Work & Next Priorities
- Tasks not finished in this session
- Items to prioritize in the next session
- Relevant context (file paths, issue numbers, where work was interrupted)

### 5. Deduplication Check
- Verify that suggestions from areas 1–4 do not already exist in CLAUDE.md or existing skills/commands
- If overlap is found, either remove the suggestion or mark it as "reinforce existing"

## Output

After completing the analysis, ask the user to decide on:

1. **CLAUDE.md update** — which items to apply
2. **Save feedback log** — append this session's feedback to .claude/feedback-log.md
3. **Create automation** — whether to create any proposed skill/command

Execute only what the user approves.

## Feedback Log Format

When appending to .claude/feedback-log.md, use this format:

```markdown
---
## YYYY-MM-DD HH:MM Session

**Summary**: (one-line description of the session)

**Doc updates**: (applied or skipped, with brief description)

**Learnings**:
- Learned: ...
- Mistakes: ...
- Discoveries: ...

**Automation observations**:
- (pattern notes or "none")

**Incomplete / Next**:
- (items or "none")
```

## Rules

- This command runs within the current session context. Base the analysis on what was done in this session.
- If the feedback log file does not exist, create it.
- Prefer precise suggestions over excessive ones. If uncertain, do not suggest.
- Do not modify any files without user approval.
- The feedback log is append-only. Never edit or delete existing log entries.
