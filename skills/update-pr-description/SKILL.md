---
name: update-pr-description
description: >
  Generates and updates a GitHub Pull Request description based on the branch's
  recent commits and Copilot session context. Use this when asked to update a PR
  description, generate a PR body, or describe PR changes.
---

# Update PR Description

Generate a comprehensive PR description and update the current branch's open PR using `gh cli`.

## Steps

1. **Get the base branch:**

   ```bash
   git symbolic-ref --short refs/remotes/origin/HEAD | xargs basename
   ```

2. **Get the last 10 commits on this branch (compared to base):**

   ```bash
   git log --oneline --no-merges -10 origin/<base>..HEAD
   ```

3. **Get the full diff against base:**

   ```bash
   git diff origin/<base>...HEAD
   ```

4. **Query session history for context (if available):**

   Use the `sql` tool with `database: "session_store"` to find recent session prompts
   related to this repository and branch:

   ```sql
   SELECT t.user_message
   FROM turns t
   JOIN sessions s ON t.session_id = s.id
   WHERE s.repository LIKE '%<repo_name>%'
     AND t.user_message IS NOT NULL
   ORDER BY t.timestamp DESC
   LIMIT 20
   ```

   Use these prompts to understand the intent behind the changes.

5. **Get the current PR title:**

   ```bash
   gh pr view --json title --jq .title
   ```

6. **Generate the PR description** using all gathered context with this format:

   ```markdown
   ## Summary
   A brief paragraph explaining what this PR does and why.

   ## Changes
   - Bullet list of key changes, grouped logically
   - Reference specific files or modules when helpful

   ## Notes
   - Any caveats, follow-ups, or things reviewers should know
   ```

   Omit the **Notes** section if there's nothing noteworthy.

7. **Evaluate the current PR title:**

   Compare the current title against the commits, diff, and session context.
   If the title no longer accurately represents the PR's changes, generate a new
   title using conventional commits format:
   - Extract a ticket number from the branch name using the pattern `[A-Z]+-[0-9]+`
     (e.g. branch `ABC-123-add-feature` → ticket `ABC-123`)
   - If a ticket is found, prefix the title: `[ABC-123] feat: add feature`
   - If the branch is `main` or `master`, or has no ticket, omit the prefix
   - Lowercase after the prefix, concise, ≤72 characters
   - Derive from the overall set of changes, not just the last commit

8. **Update the PR:**

   If the title needs updating:

   ```bash
   gh pr edit --title "<new title>" --body "<generated description>"
   ```

   Otherwise:

   ```bash
   gh pr edit --body "<generated description>"
   ```

   If no PR exists for the current branch, inform the user instead of failing.

## Guidelines

- Keep the description concise but informative
- Focus on *what* changed and *why*, not *how* (the diff shows how)
- Use the session prompts to understand intent — they reveal what the developer was trying to accomplish
- Do not include raw commit hashes or session IDs in the output
- Do not include Jira-like ticket numbers unless they appear in the branch name
