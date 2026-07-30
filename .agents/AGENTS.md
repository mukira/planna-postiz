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
