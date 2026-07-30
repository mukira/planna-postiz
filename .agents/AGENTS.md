# Project-Scoped Rules

## Surgical Development
- **Be Surgical in Development**: Always apply precise, targeted changes without making unintended or unnecessary modifications to other parts of the codebase.
- **Isolate Side Effects**: Ensure fixes, configuration changes, and patches are idempotent and do not break existing functionality or container entrypoints.

## Upstream-Safe Branding & Asset Overrides
- **No Direct Patching of Compiled Build Chunks**: Never use `sed` or direct edits on compiled JavaScript chunks (`_next/static/chunks/*.js`). Patching compiled chunks breaks on upstream Postiz image updates and causes Next.js hydration mismatches.
- **Nginx Injection & MutationObserver Pattern**: Perform UI branding, logo replacements, and custom styling using Nginx HTML injection (`sub_filter` inserting external CSS/JS tags into `<head>`) and client-side JavaScript (`MutationObserver`) for DOM/text replacements.
- **External Asset Storage & Docker Volume Mounting**: Store all custom branding assets (logos, favicons, custom CSS, JS overrides) in `./planna-branding`. Mount them into Nginx/Docker as read-only volumes so upstream Postiz updates (`ghcr.io/gitroomhq/postiz-app:latest`) can be pulled cleanly without losing or breaking custom branding.

## Mandatory Git Workflow & Witty Commit Messages
- **Commit Before & After**: Always make a git commit to save working state before starting significant new changes, and commit immediately after making and verifying changes.
- **Funny & Witty Commit Messages**: Write humorous, entertaining commit messages that maintain a lighthearted tone while still describing what was changed (e.g., `git commit -m "🎨 Refactor entrypoint script so Nginx stops throwing duplicate tantrums"`).
- **Push to Remote**: Push commits to GitHub to ensure changes are safely backed up.

## Strict Container & Process Isolation (Zero Cross-Interference)
- **Explicit Container Scope Only**: All Docker operations must explicitly target the individual project container or service (e.g., `docker compose restart postiz` or `docker compose up -d postiz`).
- **Forbidden Global Commands**: Never execute global Docker commands that impact other running containers or system resources (e.g., `docker stop $(docker ps -q)`, `docker kill`, or `docker system prune -a`).
- **Strict Host Boundary**: All edits, configuration changes, and volume mounts must strictly stay inside `/home/mukira/planna-postiz`. Never alter shared host system services, global Nginx configurations, or other project directories.

## Zero Regressions & Mandatory Pre-Edit Code Audit
- **Mandatory Pre-Edit Code Audit**: Before making any code, script, or configuration edit, perform a full audit of all related files, schemas, dependent modules, and call sites. Never guess implementation details or file paths.
- **Zero Regressions ("Don't Break Stuff Fixing Stuff")**: Fixes must address underlying root causes without causing collateral damage or breaking existing working features.
- **Empirical Runtime Verification**: Never claim a bug is fixed or a task is complete until concrete, empirical runtime verification has been gathered (e.g., inspecting container logs, verifying HTTP response status, checking service health).
