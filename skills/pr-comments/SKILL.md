---
name: pr-comments
description: >
  Fetches PR review comments, summarizes them, and helps address them
  interactively. Tracks which comments have been fixed across multiple runs.
  Use this when asked to check PR comments, review feedback, or fix PR issues.
---

# PR Comments

Fetch, summarize, and interactively address PR review comments using `gh cli`.
Tracks already-fixed comments across multiple invocations using the session database.

## Steps

1. **Get the current PR number:**

   Extract the repository owner and name from the git remote, and the current branch name.
   Then use the `github-mcp-server-list_pull_requests` tool with `head: "<owner>:<branch>"`
   and `state: "open"` to find the PR for the current branch.

   If no open PR is found, inform the user and stop.

2. **Set up tracking table (if not already created):**

   Use the `sql` tool with `database: "session"`:

   ```sql
   CREATE TABLE IF NOT EXISTS pr_comments (
     id TEXT PRIMARY KEY,
     file_path TEXT,
     line INTEGER,
     body TEXT,
     author TEXT,
     status TEXT DEFAULT 'pending',
     created_at TEXT DEFAULT (datetime('now'))
   );
   ```

   Status values: `pending`, `fixed`, `skipped`, `wontfix`

3. **Fetch review comments from the PR:**

   Use the `github-mcp-server-pull_request_read` tool with `method: "get_review_comments"`
   to get all review comment threads. For each thread, capture:
   - Thread ID
   - File path and line number
   - Comment body
   - Author
   - Whether the thread is resolved or outdated

4. **Insert new comments into tracking table:**

   Only insert comments that don't already exist in `pr_comments`:

   ```sql
   INSERT OR IGNORE INTO pr_comments (id, file_path, line, body, author)
   VALUES ('<id>', '<file_path>', <line>, '<body>', '<author>');
   ```

   Skip comments that are already resolved or outdated on GitHub.

5. **Summarize the comments:**

   Query pending comments:

   ```sql
   SELECT id, file_path, line, body, author FROM pr_comments WHERE status = 'pending';
   ```

   Present a summary grouped by file, showing:
   - File path and line number
   - A brief description of what the reviewer is asking for
   - The comment author

   Also show a count of previously addressed comments:

   ```sql
   SELECT status, COUNT(*) as count FROM pr_comments GROUP BY status;
   ```

6. **Ask the user what to fix:**

   Use `ask_user` to let the user choose:
   - **Fix all pending** — address every pending comment
   - **Pick specific ones** — let the user select which comments to fix
   - **Skip for now** — mark selected comments as `skipped`

   If the user picks specific ones, present the list and let them choose.

7. **Fix the selected comments:**

   For each comment to fix:
   - Read the file at the referenced path and line
   - Understand what the reviewer is asking
   - Apply the fix with minimal changes
   - Update the tracking table:

     ```sql
     UPDATE pr_comments SET status = 'fixed' WHERE id = '<id>';
     ```

8. **Report results:**

   After fixing, show a summary of what was changed and the current status:

   ```sql
   SELECT status, COUNT(*) as count FROM pr_comments GROUP BY status;
   ```

## Guidelines

- Group comments by file when presenting summaries
- Be concise in summaries — one line per comment
- When fixing, make the smallest change that addresses the feedback
- If a comment is ambiguous, ask the user for clarification before fixing
- Do not fix comments marked as `resolved` or `outdated` on GitHub
- Always update the tracking table after each fix
- On subsequent runs, only show new/pending comments — don't re-show fixed ones
