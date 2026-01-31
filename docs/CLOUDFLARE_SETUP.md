# Cloudflare Pages Setup Guide

This guide will help you set up Cloudflare Pages for hosting your Astro frontend.

## Prerequisites

- GitHub repository set up with your code
- Cloudflare account (free tier works fine)
- Domain (optional, Cloudflare provides a free subdomain)

## 1. Create Cloudflare Account

If you don't have one:

1. Go to [Cloudflare](https://www.cloudflare.com)
2. Click **Sign Up**
3. Enter email and create password
4. Verify your email address

## 2. Create a New Pages Project

### Method 1: Git Integration (Recommended)

1. Log into [Cloudflare Dashboard](https://dash.cloudflare.com)
2. Click **Workers & Pages** in the left sidebar
3. Click **Create application**
4. Select **Pages** tab
5. Click **Connect to Git**

### Connect GitHub

1. Click **Connect GitHub**
2. Authorize Cloudflare to access your GitHub account
3. Select **Only select repositories**
4. Choose your `st33-astro-wordpress` repository
5. Click **Install & Authorize**

### Configure Build Settings

1. Select your repository from the list
2. Click **Begin setup**
3. Configure build settings:

   **Production branch**: `main`
   
   **Build settings**:
   - Framework preset: **Astro**
   - Build command: `npm run build`
   - Build output directory: `dist`
   - Root directory: `/` (leave empty)

4. Click **Advanced** to add environment variables (optional for now)

5. Click **Save and Deploy**

### First Deployment

1. Cloudflare will start building your site
2. This takes 2-5 minutes
3. Watch the build logs for any errors
4. Once complete, you'll get a URL like: `https://st33-astro-wordpress.pages.dev`

## 3. Configure Environment Variables

Add your WordPress API URL so the site can fetch content:

1. In your Cloudflare Pages project dashboard
2. Click **Settings**
3. Scroll to **Environment variables**
4. Click **Add variable**
5. Add:
   - **Variable name**: `WORDPRESS_API_URL`
   - **Value**: `https://your-wordpress-site.com/wp-json/wp/v2`
   - **Environment**: Select both Production and Preview
6. Click **Save**

### Rebuild After Adding Variables

1. Go to **Deployments** tab
2. Click the **···** menu on latest deployment
3. Click **Retry deployment**
4. Or just push a new commit to trigger rebuild

## 4. Custom Domain Setup (Optional)

### Add Your Domain

1. In Pages project, click **Custom domains**
2. Click **Set up a custom domain**
3. Enter your domain: `www.yourdomain.com`
4. Click **Continue**

### DNS Configuration

Cloudflare will provide DNS records:

1. If domain is already on Cloudflare:
   - DNS records are added automatically ✨
   
2. If domain is elsewhere:
   - Add CNAME record to your DNS provider:
     ```
     Type: CNAME
     Name: www
     Target: st33-astro-wordpress.pages.dev
     ```

### SSL/TLS Setup

1. Go to **SSL/TLS** in Cloudflare dashboard
2. Set encryption mode to **Full (strict)**
3. Wait 5-15 minutes for SSL certificate to activate
4. Your site will be available via HTTPS

## 5. Get API Credentials for GitHub Actions

### Create API Token

1. Click on your profile icon (top right)
2. Select **My Profile**
3. Click **API Tokens** in left sidebar
4. Click **Create Token**

### Configure Token Permissions

1. Choose template: **Edit Cloudflare Workers**
   
   Or create custom token with these permissions:
   - **Account** - **Cloudflare Pages** - **Edit**
   
2. Set Account Resources:
   - **Include** - **Your account name**

3. (Optional) Set Client IP Address Filtering for security

4. Click **Continue to summary**

5. Click **Create Token**

### Save Token

1. **IMPORTANT**: Copy the token NOW - you won't see it again!
2. Save it temporarily somewhere secure
3. You'll add this to GitHub Secrets

### Find Your Account ID

Your Account ID is needed for GitHub Actions:

1. Stay in Cloudflare Dashboard
2. Go to **Workers & Pages**
3. Look at the right sidebar - you'll see **Account ID**
4. Or check the URL: `dash.cloudflare.com/[ACCOUNT_ID]/...`
5. Copy the 32-character hex string

## 6. Configure Automatic Deployments

This is handled by GitHub Actions (already set up in `.github/workflows/deploy.yml`).

The workflow will:
- Trigger on every push to `main`
- Build your Astro site
- Deploy to Cloudflare Pages
- Show status in GitHub Actions tab

Make sure you've added these secrets to GitHub (see GITHUB_SETUP.md):
- `CLOUDFLARE_API_TOKEN`
- `CLOUDFLARE_ACCOUNT_ID`
- `WORDPRESS_API_URL`

## 7. Configure Deployment Settings

### Build Cache

1. In Pages project → **Settings** → **Builds & deployments**
2. Enable **Build cache** for faster builds
3. Cloudflare caches `node_modules` between builds

### Build Configuration

Review and update if needed:
```yaml
Build command: npm run build
Build output directory: /dist
Root directory: /
Node version: 20
```

### Preview Deployments

Cloudflare automatically creates preview deployments for:
- Pull requests
- Non-production branches

Each gets a unique URL like:
`https://abc123.st33-astro-wordpress.pages.dev`

## 8. Monitoring and Analytics

### View Build Logs

1. Go to **Deployments** tab
2. Click on any deployment
3. View detailed build logs
4. Check for errors or warnings

### Analytics

1. Click **Analytics** in your project
2. View:
   - Page views
   - Requests
   - Data transfer
   - Cache hit rate

### Functions Analytics (if using Workers)

1. Monitor function invocations
2. View error rates
3. Check performance metrics

## 9. Optimization Tips

### Enable Production Mode

Astro automatically optimizes for production, but verify:
- Minification is enabled
- Assets are compressed
- Images are optimized

### Configure Caching

In your Astro config, add headers:

```javascript
// astro.config.mjs
export default defineConfig({
  adapter: cloudflare(),
  vite: {
    build: {
      assetsInlineLimit: 0, // Don't inline assets
    }
  }
});
```

### Use Cloudflare CDN

Your site automatically uses Cloudflare's global CDN:
- Static assets are cached globally
- Served from nearest data center
- Improved performance worldwide

## 10. Rollback and Version Control

### Rollback to Previous Deployment

1. Go to **Deployments** tab
2. Find the deployment you want to restore
3. Click **···** menu
4. Click **Rollback to this deployment**
5. Confirm the rollback

### View Deployment History

- All deployments are saved
- Can rollback to any previous version
- Git commit hash is linked

## Troubleshooting

### Build Failures

**Check build logs**:
1. Go to failed deployment
2. Review error messages
3. Common issues:
   - Missing dependencies
   - Environment variable not set
   - Build command incorrect

**Fix**:
```bash
# Test build locally first
npm run build

# If it works locally, push to trigger rebuild
git push origin main
```

### Site Not Loading Content

**WordPress API not reachable**:
1. Verify `WORDPRESS_API_URL` is set correctly
2. Test API manually: `curl https://your-site.com/wp-json/wp/v2/posts`
3. Check CORS settings in WordPress

### 404 Errors

**Missing routes**:
1. Check Astro routing in `src/pages/`
2. Verify build output directory is `dist`
3. Check `_redirects` file (if you created one)

### SSL Certificate Issues

1. Wait 15 minutes for initial SSL provisioning
2. Check SSL mode is set to "Full (strict)"
3. Try purging Cloudflare cache

### Slow Build Times

1. Enable build cache in settings
2. Optimize dependencies
3. Consider reducing build steps

## Performance Optimization

### Enable Cloudflare Features

1. **Auto Minify**:
   - Go to **Speed** → **Optimization**
   - Enable Auto Minify for HTML, CSS, JS

2. **Rocket Loader** (optional):
   - Speeds up page load by deferring JS

3. **Brotli Compression**:
   - Automatically enabled

### Monitor Performance

1. Use Cloudflare Analytics
2. Check Core Web Vitals
3. Monitor Time to First Byte (TTFB)

### Caching Strategy

Add `_headers` file in your `public/` directory:

```
/*
  X-Frame-Options: DENY
  X-Content-Type-Options: nosniff
  Referrer-Policy: strict-origin-when-cross-origin

/assets/*
  Cache-Control: public, max-age=31536000, immutable
```

## Security Recommendations

1. **Enable Security Headers**:
   - Add via `_headers` file
   - Or use Cloudflare Transform Rules

2. **Rate Limiting**:
   - Available in Cloudflare dashboard
   - Protect against DDoS

3. **WAF (Web Application Firewall)**:
   - Available on paid plans
   - Automatic threat protection

## Cost Optimization

### Free Tier Includes

- Unlimited requests
- Unlimited bandwidth
- 500 builds per month
- 1 concurrent build

### Paid Features

If you need more:
- **Pages Pro** ($20/month):
  - 5,000 builds/month
  - 5 concurrent builds
  - Advanced preview aliases

## Next Steps

1. ✅ Cloudflare Pages project created
2. ✅ Environment variables configured
3. ✅ API token created for GitHub Actions
4. → Test automatic deployment
5. → Set up custom domain (optional)
6. → Configure monitoring and alerts

## Useful Commands

```bash
# Test build locally before deploying
npm run build

# Preview production build
npm run preview

# Manual deployment with Wrangler CLI
npm run deploy

# Install Wrangler globally (optional)
npm install -g wrangler
```

## Additional Resources

- [Cloudflare Pages Docs](https://developers.cloudflare.com/pages)
- [Astro on Cloudflare](https://docs.astro.build/en/guides/deploy/cloudflare/)
- [Wrangler CLI](https://developers.cloudflare.com/workers/wrangler/)
- [Cloudflare Community](https://community.cloudflare.com/)

## Support

- [Cloudflare Support](https://support.cloudflare.com)
- [Cloudflare Discord](https://discord.cloudflare.com)
- [Cloudflare Status](https://www.cloudflarestatus.com)
