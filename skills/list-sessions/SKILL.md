---
name: list-sessions
description: >
  Lists recent Copilot CLI sessions from this machine showing repo, branch,
  summary, and timestamps. Use when asked to list sessions, check session
  history, or find past work.
---

# List Copilot Sessions

Query the session store database to show recent Copilot CLI sessions on this machine.

## Steps

1. **Query the session store:**

   Use the `sql` tool with `database: "session_store"` to list sessions:

   ```sql
   SELECT
     id,
     repository,
     branch,
     substr(summary, 1, 80) as summary,
     created_at,
     updated_at
   FROM sessions
   ORDER BY updated_at DESC
   LIMIT 20
   ```

2. **Format as a table** with columns: When | Repo | Branch | Summary

3. **If the user asks for details on a specific session**, query its turns:

   ```sql
   SELECT turn_index, substr(user_message, 1, 200) as message
   FROM turns
   WHERE session_id = '<session_id>'
   ORDER BY turn_index
   ```

4. **If the user wants to search across sessions**, use the FTS5 index:

   ```sql
   SELECT content, session_id, source_type
   FROM search_index
   WHERE search_index MATCH '<keywords>'
   ORDER BY rank
   LIMIT 10
   ```
