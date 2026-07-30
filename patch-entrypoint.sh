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
  sed -i '/location \/ {/a \            sub_filter "</body>" "<script>if((window.location.pathname==='\''/'\'' || window.location.pathname==='\''/auth'\'') && !localStorage.getItem('\''planna_banner_dismissed'\'')){document.write(\"<style>#planna-banner-btn{position:absolute;right:10px;top:50%;transform:translateY(-50%);width:32px;height:32px;display:flex;align-items:center;justify-content:center;cursor:pointer;font-size:24px;border-radius:50%;transition:all 0.2s ease;user-select:none;}#planna-banner-btn:hover{background-color:rgba(255,255,255,0.2);transform:translateY(-50%) scale(1.15);}</style><div id=\"planna-banner\" style=\"position:fixed;top:20px;right:20px;width:calc(50% - 40px);max-width:500px;background:#2563EB;color:white;text-align:left;padding:15px 50px 15px 20px;z-index:9999;font-weight:bold;font-size:14px;border-radius:12px;box-shadow:0 10px 25px rgba(0,0,0,0.2);line-height:1.5;\">Planna is a powerful social media scheduling application. By connecting your accounts, you authorize Planna to publish posts and view analytics on your behalf.<div id=\"planna-banner-btn\" onclick=\"document.getElementById('\''planna-banner'\'').style.display='\''none'\'';localStorage.setItem('\''planna_banner_dismissed'\'','\''true'\'');\">&times;</div></div>\");}</script></body>";\n            sub_filter_once on;' /etc/nginx/nginx.conf
fi

echo "Done patching! Starting Next.js..."
exec docker-entrypoint.sh sh -c "nginx && pnpm run pm2"
