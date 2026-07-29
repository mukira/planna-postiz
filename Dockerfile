FROM ghcr.io/gitroomhq/postiz-app:latest

# Base image already sets WORKDIR to /app

# Copy the custom logo over the original Postiz logo component
COPY logo-text.component.tsx /app/apps/frontend/src/components/ui/logo-text.component.tsx

# Find all instances of "postiz" and replace with "planna" in the frontend source code before building
RUN find /app/apps/frontend/src -type f -exec sed -i 's/postiz/planna/gI' {} + || true

# Recompile the Next.js frontend with the new branding
RUN pnpm --filter ./apps/frontend run build

# The default entrypoint and command from the base image will handle the rest!
