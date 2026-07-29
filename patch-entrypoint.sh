#!/bin/sh
echo "Applying Planna branding on the fly..."
find /app/apps/frontend/.next -type f -name '*.js' -exec sed -i 's/Postiz/Planna/g' {} +
find /app/apps/frontend/.next -type f -name '*.js' -exec sed -i 's/postiz/planna/g' {} +
echo "Done patching! Starting Next.js..."
exec docker-entrypoint.sh sh -c "nginx && pnpm run pm2"
