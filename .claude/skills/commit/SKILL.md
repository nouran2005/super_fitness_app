---
name: commit
description: >
  Track all changed files in the git working tree and generate conventional commit messages ready to push to GitHub.
  Trigger this skill when the user says "commit", "generate commit message", "what changed", "push to github",
  or asks for a commit summary of recent changes.
  Always group changes by type and produce one commit message per logical group.
---

# Commit — Track Changes & Generate Conventional Commit Messages

Inspect the git working tree, group changed files by intent, and produce well-formed conventional commit messages.

---

## Step 1 — Inspect the Working Tree

Run the following in parallel:

```bash
git status --short
git diff --stat HEAD
```

Collect:
- **Staged files** (index changes)
- **Unstaged modified files**
- **Untracked files**

Do NOT commit or stage anything yet — only observe.

---

## Step 2 — Read the Changes

For each changed file, run:

```bash
git diff HEAD -- <file>
```

For untracked files, read the file content directly.

Focus on understanding **what changed and why**, not just which files changed.

---

## Step 3 — Group Changes by Commit Type

Use the following conventional commit types:

| Type | When to use |
|---|---|
| `feat` | A new feature for the user |
| `fix` | A bug fix for the user |
| `docs` | Changes to documentation or code comments |
| `style` | Formatting, whitespace, missing semicolons — no logic change |
| `refactor` | Code restructure that neither fixes a bug nor adds a feature |
| `perf` | A change that improves performance |
| `test` | Adding or correcting tests |
| `chore` | Dependency updates, file moves, build scripts, config — no source change |

**Grouping rules:**
- One commit per logical concern — don't mix a feature with a bug fix
- Files that belong to the same feature/screen/fix go in the same commit
- If a single file has both a fix and a refactor, split them conceptually and note it

---

## Step 4 — Write the Commit Messages

For each group, produce a commit message in this format:

```
<type>(<optional scope>): <short imperative summary>

<optional body — what and why, not how; wrap at 72 chars>
```

**Rules:**
- Subject line: imperative mood, lowercase after the colon, no period, ≤72 chars
- Scope: the feature name or module in snake_case (e.g., `profile`, `booking`, `auth`)
- Body: only include if the change needs explanation beyond the subject
- No generic messages like "update files" or "fix stuff"

**Examples:**

```
feat(profile): add avatar upload with image picker

fix(booking): correct date formatting in booking header

refactor(order_details): extract status stepper into its own widget

chore: update flutter_screenutil to 5.9.3

style(loyal_club): reformat recent transactions widget spacing
```

---

## Step 5 — Present the Results

Output a structured summary:

### Changed Files
List every changed file with its status (`modified`, `new`, `deleted`).

### Suggested Commits

For each commit group:

```
──────────────────────────────────────────
[1] feat(profile): add avatar upload with image picker

Files:
  - lib/features/profile/presentation/view/pages/profile_view.dart
  - lib/features/profile/data/models/profile_icon_models.dart
──────────────────────────────────────────
```

If all changes belong to a single logical unit, produce one commit message.
If changes span multiple concerns, produce one message per group, numbered.

---

## Step 6 — Ask Before Staging

After presenting the suggested commits, ask the user:

> "Should I stage and commit these? (yes / adjust / no)"

- **Yes**: run `git add <files>` per group, then `git commit -m "..."` per group
- **Adjust**: wait for user edits, then proceed
- **No**: stop — output only, no git actions taken

Do NOT push to GitHub unless the user explicitly says "push" or "push to GitHub".
If asked to push, run `git push` and confirm the branch name first.

---

## Edge Cases

- **No changes**: report "Nothing to commit — working tree is clean."
- **Already staged files**: treat them as the primary commit candidate; mention any unstaged files separately
- **Merge conflicts**: do not generate a commit message — report the conflict files and ask the user to resolve them first
- **Binary files / assets**: group with `chore` or `feat` depending on context; don't diff them
- **Translation files only**: use `chore(i18n): update translations` unless new keys were added, in which case tie them to the relevant `feat` commit
