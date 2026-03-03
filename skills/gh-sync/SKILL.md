---
name: gh-sync
description: >
  Creates or updates GitHub Pull Requests: commits staged/unstaged changes,
  pushes the branch, creates a draft PR with a conventional-commit title and
  AI-generated description, or updates an existing PR description. Use this when
  asked to create a PR, open a pull request, push and PR, update a PR
  description, or generate a PR body.
---

# Create Or Update Pull Request

Handle both PR flows with `gh cli`:
- Create flow: commit changes, push branch, and create a draft PR with title + description.
- Update flow: generate a fresh description and update the current branch PR.

## Steps

1. **Get the base branch:**

   ```bash
   git symbolic-ref --short refs/remotes/origin/HEAD | xargs basename
   ```

2. **Check whether a PR already exists for the current branch:**

   ```bash
   gh pr view --json number --jq .number
   ```

   - If this succeeds, an open PR exists for this branch.
   - If this fails, no PR is open yet.

3. **Determine the flow from user intent:**
   - If asked to update/refresh/generate PR description, use **Update flow**.
   - If asked to create/open/push and PR, use **Create flow**.
   - If intent is ambiguous: when PR exists, prefer **Update flow**; otherwise prefer **Create flow**.

4. **For Create flow, stage all changes:**

   ```bash
   git add .
   ```

5. **For Create flow, get the staged diff:**

   ```bash
   git diff --staged
   ```

   If the diff is empty (nothing to commit), skip the commit step and proceed
   with any existing unpushed commits.

6. **For Create flow, generate a commit message** from the staged diff using conventional commits:
   - First line: a short (≤72 chars) lowercase conventional commit title (e.g. `feat: add user auth`)
   - Optionally followed by a brief body with 1–3 bullet points for non-trivial changes
   - Do not include Jira-like ticket numbers

7. **For Create flow, commit the changes:**

   ```bash
   git commit -m "<generated commit message>"
   ```

8. **For Create flow, push the branch:**

   ```bash
   git push origin $(git branch --show-current)
   ```

9. **Get the full diff against base for PR description content:**

   ```bash
   git diff origin/<base>...HEAD
   ```

10. **Get the last 10 commits on this branch:**

   ```bash
   git log --oneline --no-merges -10 origin/<base>..HEAD
   ```

11. **Query session history for context (if available):**

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

12. **For Create flow, generate the PR title** using conventional commits format:
    - Extract a ticket number from the branch name using the pattern `[A-Z]+-[0-9]+`
      (e.g. branch `ABC-123-add-feature` → ticket `ABC-123`)
    - If a ticket is found, prefix the title: `[ABC-123] feat: add feature`
    - If the branch is `main` or `master`, or has no ticket, omit the prefix
    - Lowercase after the prefix, concise, ≤72 characters
    - Derive from the overall set of changes, not just the last commit

13. **Generate the PR description** using all gathered context with this format:

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

14. **Run the flow action:**

   For **Create flow** (when no PR exists):

   ```bash
   gh pr create --base <base> --head $(git branch --show-current) --title "<title>" --body "<description>" --draft
   ```

   If a PR already exists unexpectedly, run:

   ```bash
   gh pr edit --body "<generated description>"
   ```

   For **Update flow**:

   ```bash
   gh pr edit --body "<generated description>"
   ```

   If no PR exists, inform the user and suggest running create flow.

15. **For Create flow, request Copilot as a reviewer:**

    ```bash
    gh pr edit --add-reviewer "copilot"
    ```

## Guidelines

- Keep the PR title/description concise but informative
- Use conventional commits for commit message and PR title (Create flow)
- Focus on *what* changed and *why*, not *how* (the diff shows how)
- Use session prompts to understand intent — they reveal what the developer was trying to accomplish
- Do not include raw commit hashes or session IDs in the output
- Do not include Jira-like ticket numbers unless they appear in the branch name
- Always create PRs as drafts (Create flow)
