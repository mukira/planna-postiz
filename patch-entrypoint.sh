#!/bin/sh
echo "Applying Planna branding on the fly..."
find /app/apps/frontend/.next -type f -name '*.js' -exec sed -i 's/Postiz/Planna/g' {} +
find /app/apps/frontend/.next -type f -name '*.js' -exec sed -i 's/postiz/planna/g' {} +
find /app/apps/frontend/.next -type f -name '*.js' -exec sed -i 's/#612bd3/#2563EB/g' {} +
find /app/apps/frontend/.next -type f -name '*.js' -exec sed -i 's/612BD3/2563EB/g' {} +
find /app/apps -type f -name 'instagram.standalone.provider.js' -exec sed -i 's/user_id/id/g' {} +
find /app/apps -type f -name 'instagram.standalone.provider.js' -exec sed -i 's/this.checkScopes(this.scopes, getAccessToken.permissions);//g' {} +
find /app/apps -type f -name 'instagram.standalone.provider.js' -exec sed -i 's/params.code/params.code.replace("#_","")/g' {} +
if ! grep -q "sub_filter_once" /etc/nginx/nginx.conf; then
  sed -i '/location \/ {/a \            sub_filter "</body>" "<script>if(window.location.pathname===\\"/\\" || window.location.pathname===\\"/auth\\"){document.write(\\"<div style=\\\\\\"position:fixed;bottom:0;width:100%;background:#2563EB;color:white;text-align:center;padding:15px;z-index:9999;font-weight:bold;font-size:14px;\\\\\\">Planna is a powerful social media scheduling application. By connecting your accounts, you authorize Planna to publish posts and view analytics on your behalf.</div>\\");}</script></body>";\n            sub_filter_once on;' /etc/nginx/nginx.conf
fi

echo "Done patching! Starting Next.js..."
exec docker-entrypoint.sh sh -c "nginx && pnpm run pm2"
