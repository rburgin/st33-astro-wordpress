# WordPress on Hostinger Setup Guide

This guide will help you set up WordPress on your Hostinger hosting and configure it to work with your Astro frontend.

## Initial WordPress Installation

### 1. Install WordPress via Hostinger Panel

1. Log into your [Hostinger Control Panel](https://hpanel.hostinger.com)
2. Navigate to **Website** section
3. Click **Auto Installer** or **WordPress**
4. Choose your domain
5. Fill in the installation details:
   - Admin username
   - Admin password
   - Admin email
   - Site title
6. Click **Install**
7. Wait for installation to complete (usually 1-2 minutes)

### 2. Access Your WordPress Dashboard

1. Navigate to `https://your-domain.com/wp-admin`
2. Log in with your admin credentials
3. You should see the WordPress dashboard

## Configure WordPress for Headless CMS

### 3. Enable REST API

The WordPress REST API is enabled by default, but verify it's working:

1. Visit: `https://your-domain.com/wp-json/wp/v2/posts`
2. You should see JSON data (even if empty)
3. If you get an error, check your permalink settings:
   - Go to **Settings** → **Permalinks**
   - Select **Post name** structure
   - Click **Save Changes**

### 4. Install Recommended Plugins

Install these plugins for better headless WordPress experience:

#### A. ACF (Advanced Custom Fields) - Optional
For custom content fields:
1. Go to **Plugins** → **Add New**
2. Search for "Advanced Custom Fields"
3. Click **Install Now** → **Activate**

#### B. WPGraphQL - Optional
If you want to use GraphQL instead of REST API:
1. Go to **Plugins** → **Add New**
2. Search for "WPGraphQL"
3. Click **Install Now** → **Activate**

#### C. Application Passwords
For API authentication:
1. Already built into WordPress 5.6+
2. Go to **Users** → **Your Profile**
3. Scroll to **Application Passwords**
4. Enter a name (e.g., "Astro Frontend")
5. Click **Add New Application Password**
6. **Save this password** - you won't see it again!

### 5. Configure CORS (If Needed)

If you encounter CORS errors, add this to your WordPress theme's `functions.php`:

```php
// Enable CORS for Headless WordPress
function add_cors_http_header(){
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Authorization");
}
add_action('init','add_cors_http_header');

// Or restrict to your Cloudflare Pages domain
function add_cors_http_header_production(){
    header("Access-Control-Allow-Origin: https://your-site.pages.dev");
    header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type, Authorization");
}
add_action('init','add_cors_http_header_production');
```

**Better approach**: Use a plugin like "WP CORS" for easier CORS management.

### 6. Security Hardening

#### Hide WordPress Login Page
1. Install "WPS Hide Login" plugin
2. Configure a custom login URL
3. This prevents brute force attacks

#### Limit Login Attempts
1. Install "Limit Login Attempts Reloaded"
2. Configure maximum login attempts
3. Set lockout duration

#### SSL Certificate
1. In Hostinger panel, go to **SSL**
2. Enable **Force HTTPS**
3. Verify SSL certificate is active

### 7. Performance Optimization

#### Caching
1. Install "LiteSpeed Cache" (if available on Hostinger)
2. Or use "W3 Total Cache"
3. Enable page caching and browser caching

#### Image Optimization
1. Install "Smush" or "ShortPixel"
2. Optimize existing images
3. Enable automatic optimization

#### Database Optimization
1. Install "WP-Optimize"
2. Clean up revisions, spam, and transients
3. Schedule weekly cleanups

## WordPress REST API Endpoints

Your WordPress site exposes these endpoints:

- **Posts**: `https://your-domain.com/wp-json/wp/v2/posts`
- **Pages**: `https://your-domain.com/wp-json/wp/v2/pages`
- **Categories**: `https://your-domain.com/wp-json/wp/v2/categories`
- **Tags**: `https://your-domain.com/wp-json/wp/v2/tags`
- **Media**: `https://your-domain.com/wp-json/wp/v2/media`
- **Users**: `https://your-domain.com/wp-json/wp/v2/users`

### Common Query Parameters

- `?per_page=10` - Limit results
- `?page=2` - Pagination
- `?_embed` - Include embedded media and author data
- `?search=keyword` - Search posts
- `?categories=1,2` - Filter by category
- `?orderby=date` - Sort by date, title, etc.

## Hostinger-Specific Tips

### File Manager Access
1. Use **File Manager** in Hostinger panel
2. WordPress files are in `public_html/`
3. Edit `wp-config.php` for advanced settings

### Database Access
1. Use **phpMyAdmin** from Hostinger panel
2. Database credentials are in `wp-config.php`
3. Backup database regularly

### Email Configuration
1. Use Hostinger's SMTP settings
2. Install "WP Mail SMTP" plugin
3. Configure with Hostinger email credentials

### Backups
1. Hostinger provides daily backups
2. Access via **Backups** section
3. Consider additional plugin backup (UpdraftPlus)

## Testing Your WordPress API

### Using cURL
```bash
curl https://your-domain.com/wp-json/wp/v2/posts
```

### Using Browser
Simply visit: `https://your-domain.com/wp-json/wp/v2/posts`

### With Authentication
```bash
curl -u username:application-password https://your-domain.com/wp-json/wp/v2/posts
```

## Environment Variables

Update your `.env` file with your WordPress URL:

```
WORDPRESS_API_URL=https://your-hostinger-domain.com/wp-json/wp/v2
```

Or if using authentication:
```
WORDPRESS_API_URL=https://your-hostinger-domain.com/wp-json/wp/v2
WORDPRESS_USERNAME=your-username
WORDPRESS_APP_PASSWORD=your-app-password
```

## Troubleshooting

### REST API Returns 404
- Check permalink settings
- Verify `.htaccess` file exists
- Check if mod_rewrite is enabled (contact Hostinger support)

### CORS Errors
- Add CORS headers (see section 5)
- Check if domain is whitelisted
- Try using a CORS plugin

### Slow Performance
- Enable caching plugins
- Optimize database
- Use Cloudflare CDN (can add in Hostinger panel)
- Optimize images

### Can't Access Admin
- Check if URL is correct: `/wp-admin`
- Clear browser cache
- Check if WordPress URL settings are correct in database

## Next Steps

1. Create some test posts in WordPress
2. Verify they appear in the REST API
3. Test your Astro frontend locally
4. Deploy to Cloudflare Pages
5. Verify production integration works

## Support

- [Hostinger Help Center](https://support.hostinger.com)
- [WordPress Support](https://wordpress.org/support/)
- [WordPress REST API Handbook](https://developer.wordpress.org/rest-api/)
