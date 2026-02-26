---
name: create-pr
description: >
  Commits staged/unstaged changes, pushes the branch, and creates a GitHub Pull
  Request with a conventional-commit title and AI-generated description. Use this
  when asked to create a PR, open a pull request, or push and PR.
---

# Create Pull Request

Commit all changes, push the branch, and create a draft PR with a proper title and description using `gh cli`.

## Steps

1. **Get the base branch:**

   ```bash
   git symbolic-ref --short refs/remotes/origin/HEAD | xargs basename
   ```

2. **Stage all changes:**

   ```bash
   git add .
   ```

3. **Get the staged diff:**

   ```bash
   git diff --staged
   ```

   If the diff is empty (nothing to commit), skip the commit step and proceed
   with any existing unpushed commits.

4. **Generate a commit message** from the staged diff using conventional commits:
   - First line: a short (≤72 chars) lowercase conventional commit title (e.g. `feat: add user auth`)
   - Optionally followed by a brief body with 1–3 bullet points for non-trivial changes
   - Do not include Jira-like ticket numbers

5. **Commit the changes:**

   ```bash
   git commit -m "<generated commit message>"
   ```

6. **Push the branch:**

   ```bash
   git push origin $(git branch --show-current)
   ```

7. **Get the full diff against base for the PR description:**

   ```bash
   git diff origin/<base>...HEAD
   ```

8. **Get the last 10 commits on this branch:**

   ```bash
   git log --oneline --no-merges -10 origin/<base>..HEAD
   ```

9. **Query session history for context (if available):**

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

10. **Generate the PR title** using conventional commits format:
    - Lowercase, concise, ≤72 characters
    - e.g. `feat: add copilot skill for pr creation`
    - Derive from the overall set of changes, not just the last commit

11. **Generate the PR description** using all gathered context with this format:

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

12. **Create the PR:**

    ```bash
    gh pr create --base <base> --head $(git branch --show-current) --title "<title>" --body "<description>" --draft
    ```

    If a PR already exists for this branch, inform the user and suggest using
    the `/update-pr-description` skill instead.

## Guidelines

- Keep the PR title and description concise but informative
- Use conventional commits for both the commit message and PR title
- Focus on *what* changed and *why*, not *how* (the diff shows how)
- Use session prompts to understand intent — they reveal what the developer was trying to accomplish
- Do not include raw commit hashes or session IDs in the output
- Do not include Jira-like ticket numbers unless they appear in the branch name
- Always create PRs as drafts
