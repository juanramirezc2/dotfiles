---
description: Start or stop the Rails dev environment (bootstrap + background services, or shut them down)
allowed-tools: Bash(git remote get-url:*), Bash(git pull:*), Bash(bundle install:*), Bash(rails tailwindcss:build:*), Bash(rails db*:*), Bash(RAILS_ENV=test rails db*:*), Bash(PGGSSENCMODE=disable bundle exec rails s*:*), Bash(./bin/sidekiq:*), Bash(kill:*), Bash(pkill:*), Bash(lsof:*)
---

Start or stop the Rails development environment, based on the argument passed (`start` or `stop`). If no argument is given, ask the user which one they mean.

## `start`

Bootstrap the Rails development environment. Run these steps in order, stopping if any step fails.

### Sequential setup steps

Run these one at a time, in order. If any step fails, stop and report the error.

1. **Pull latest code** over HTTPS, to avoid SSH agent sandbox issues. Read the origin URL, rewrite an SSH form (`git@github.com:<owner>/<repo>.git`) to `https://github.com/<owner>/<repo>.git`, and pull `main` from it:
   ```bash
   git remote get-url origin
   git pull https://github.com/<owner>/<repo>.git main
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Build Tailwind CSS** (required for worktrees — compiled assets aren't in git)
   ```bash
   rails tailwindcss:build
   ```

4. **Run development migrations**
   ```bash
   rails db:migrate
   ```

5. **Reset test database**
   ```bash
   RAILS_ENV=test rails db:reset
   ```

### Background services

After all setup steps succeed, start services in the background using `run_in_background: true`. **Rails must start first** - wait a few seconds for it to boot before starting Sidekiq, as they compete for the Yabeda metrics port.

6. **Rails server** (start first)
   ```bash
   PGGSSENCMODE=disable bundle exec rails s -p 3000
   ```
   After launching, wait 5 seconds for Rails to claim the metrics port.

7. **Sidekiq** (start after Rails is up)
   ```bash
   ./bin/sidekiq
   ```

### After launch

- Report which services started successfully
- Remind the user they can check on background processes with `/tasks`
- Let them know the environment is ready for coding

## `stop`

Shut down all background Rails development services started by `start` above.

### Steps

1. First check `/tasks` for any running background tasks from the startup command and stop them using TaskStop.

2. As a fallback, find and kill any remaining processes:
   - **Rails server**: `pkill -f "rails s -p 3000"` or check `lsof -i :3000`
   - **Sidekiq**: `pkill -f "sidekiq"`

3. Confirm both services have been stopped.
