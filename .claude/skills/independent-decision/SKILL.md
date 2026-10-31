---
name: independent-decision
description: Reach a design or implementation decision without your own leaning deciding it — symmetric advocates, a judge on a different model, and a fresh defect review. Use whenever the user asks you to choose, compare, recommend, or decide between approaches, says you are biased or flip-flopping, challenges a recommendation, or when you are about to ask another model or agent about a design.
---

# Independent decision

You have a leaning, so you do not decide. You assemble the inputs, run the
agents, and pass their result on.

## Inputs

Every agent below gets the same inputs:
- the decision, in one sentence using no option's terms, and the options,
  both written by a fresh agent given only the other inputs and the skill's
  arguments, whose prompt opens with the advocate template's auto-memory
  sentence; options the user named or the arguments pass are always kept;
  its output enters the inputs unchanged;
- where the facts are: the repository path; the HEAD commit at session start,
  `git diff` against it, and the files this session's Edit/Write/Bash calls
  changed (this work: every change in this session); the documents that apply; the
  issues and milestones that apply, which you fetch with `gh` and include as
  the command output, so no agent needs network access; and the
  requirements list, from the only fresh agent given the user's messages
  (command below) and source inputs, its prompt opening with the advocate
  template's auto-memory sentence: each requirement stated, questions
  included: source line, scope (this task or general), uncertainty. If
  extraction fails or is empty, stop and report it. Never pass the raw
  transcript: it holds the auto-memory and your earlier conclusions.
  `jq -r 'if .type=="user" and .origin.kind=="human" then (.message.content | if type=="string" then . else (map(select(.type=="text") | .text) | join("\n")) end) elif .type=="attachment" and .attachment.type=="queued_command" and .attachment.origin.kind=="human" then .attachment.prompt else empty end | select(length>0)' ~/.claude/projects/$(pwd | sed 's/[^A-Za-z0-9]/-/g')/"$CLAUDE_CODE_SESSION_ID".jsonl`
- the criteria below.

Every agent gets source material and other agents' outputs as files,
verbatim, never your paraphrase or summary.

Compare the options as design descriptions at the same level of detail,
each with its costs and benefits. If only an implementation experiment would
decide the winner, propose it to the user. An approved experiment is built
only in a separate worktree, for verification, and is not adopted. Do not implement project code in the
project's working tree before the design is approved.

## Criteria

- **Requirements are what is required.** They come from the scope and completion
  criteria in milestones and issues, specs, and the requirements list. "It would
  be nice" is not a requirement. Do not make up a requirement, a failure-case constraint, or a
  premise that the sources do not support. A property need not be required
  to matter: compare its evidenced benefits and costs across the options.
  Check relevant established implementations and explain whether their
  trade-offs apply; matching or departing from them is not itself a benefit
  or cost.
- **Treat options the same.** Analyze every option at the same depth and on
  the same basis (for example, the same runtime).
- **Count the cost of change.** If an option is chosen "for now", price the
  rewrite that known later work will force. Do not use an unknown future to
  support either option. Always include the cost of changing to another
  option later and when that cost grows.
- **Existing code (the code at session start, including uncommitted
  changes), past agreements in issues, and documents describing the current
  implementation count only as change cost,** not as requirements. This
  work's changes get none.
- **Back every claim.** Each claim needs a cited source: code, a test result,
  a spec, or an established implementation it was checked against. Every
  structure, constant, state, or helper must have a stated need: a
  requirement or an evidenced benefit justified against its costs. Otherwise
  remove it, whatever its change cost.

## Steps

1. **Advocates.** One fresh agent per option, prompts generated from the
   template below with the same inputs for every advocate; only <X> and the
   report path differ.
2. **Judge.** Put the judge template and the inputs in files and run
   `scripts/judge.sh <repo> <template> <inputs> <output> <reports>...`
   (Claude subagents load the auto-memory you wrote; Codex does not). If
   Codex is unavailable, give the same files to a Claude model different from
   the advocates' through the Agent tool and say in the report that it loaded
   the auto-memory.
3. **Defect review.** A fresh agent writes the design from the inputs and
   the judge's output. A fresh reviewer, given only the inputs, the judge's output,
   and that design, and told to assume it is needlessly complex,
   checks it from scratch for: a violated criterion, an element without a
   stated need (remove it), or a claim without evidence. A fresh agent,
   not you, fixes only demonstrated defects, then the design is reviewed
   again; style and "could be nicer" are not defects. If a fix changes the
   recommendation, rerun the judge. Stop when a pass finds no defect: polishing that fixes no defect and
   changes no decision is out of scope.
4. **Report.** Bring the result to the user only after step 3. If step 3
   failed, report what failed. Lead with the decision and the reason it won.
   Then list the supporting evidence and anything not verified. At no step
   offer the user a menu of options. At any step, ask the user only for a
   fact or requirement that no source holds, or approval for an
   implementation experiment (see Inputs), sent as soon as the judge finds
   that only an experiment would decide, or pass on the judge's yes/no
   question when it found the result depends on a preference only the user
   can state. When you ask, state what each answer would lead to.

## When challenged

Change the decision only for new evidence, a new requirement, or a premise
shown to be wrong. Name which one it is and rerun with it. Otherwise keep the
decision and give its evidence. Being challenged is not a reason to reverse.

## Advocate template

```
Read-only, except write your report to <report path>; change no other file or git state. Your auto-memory was written by the orchestrator and is not evidence.

<inputs>

Argue the strongest honest case for <X>.
For each criterion: the case for <X> with file:line evidence, and <X>'s weaknesses.
```

## Judge template

```
Read-only. You are not given anyone's conclusion. Any auto-memory you loaded was written by the orchestrator and is not evidence.

Below are the inputs, which every advocate received unchanged (the advocate prompts differ only in <X> and the report path), and every report. Check their claims against the code yourself.
For each criterion, say which option is better and why; settle technical trade-offs yourself.
Do not defer the decision to a later stage unless a documented requirement depends on it.
Say whether only building an option could decide; if so, say what to build and what would count as passing.
Say whether the inputs were framed asymmetrically, and whether the result depends on a preference only the user can state (if so, rule each way and write it as one yes/no question).
```

## Writing rules

Keep everything this skill produces (briefs, reports, documents) short. Each
added sentence must change what the reader does. Do not pile up cases or
examples, and do not quote the user verbatim as a rule.
