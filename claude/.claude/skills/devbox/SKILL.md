---
description: Deploy current branch to a devbox environment
allowed-tools: Bash(expect:*), Bash(git branch:*), Bash(git push:*)
---

Deploy the current branch to a devbox for testing.

## Default behavior

- Uses staging server and names the deployment after the ticket (e.g., `abc-123`)
- Automatically pushes the branch if not on remote
- The devbox binary is interactive, so we use `expect` to automate the prompts

## Steps

1. Determine the current branch and extract the ticket number (e.g., `jd/ABC-123-fix-scroll-jump` -> `abc-123`)
2. Ensure the branch is pushed to the remote (push with `-u` if needed)
3. Run devbox using `expect` to automate the interactive prompts:
   ```bash
   expect -c '
   spawn ./devbox -s
   expect "*staging*"
   send "y\r"
   expect "*deployment name*"
   send "<ticket>\r"
   expect eof
   ' 2>&1
   ```
4. Show the user the devbox URL. Its pattern is in `~/.config/agent-skills/work.md` under Devbox; fill in the ticket. If that file doesn't have it, take the URL from the devbox output or ask the user.
