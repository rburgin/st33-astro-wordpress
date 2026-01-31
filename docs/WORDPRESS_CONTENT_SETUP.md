# WordPress Content Setup Guide

This guide shows you how to set up your WordPress content to automatically populate your Astro frontend.

## Required WordPress Plugins

1. **Advanced Custom Fields (ACF)** - Free or Pro
   - Install from WordPress plugin directory
   - Used for custom fields on pages and posts

2. **ACF to REST API** (Optional but recommended)
   - Exposes ACF fields in the WordPress REST API
   - Install from plugin directory or add this to `functions.php`:

```php
// Expose ACF fields in REST API
add_filter('acf/settings/rest_api_format', function () {
    return 'standard';
});
```

## Step 1: Create the Home Page

1. In WordPress admin, go to **Pages** → **Add New**
2. Title: `Home`
3. Slug: `home` (important!)
4. You can leave the content empty or add fallback content
5. Publish the page

## Step 2: Set Up ACF Fields for Homepage

Create a new Field Group in ACF:

### Field Group: "Homepage Settings"
**Location Rule**: Page is equal to Home

### Fields to Add:

#### 1. Hero Title
- **Field Label**: Hero Title
- **Field Name**: `hero_title`
- **Field Type**: Text
- **Default Value**: Your Name
- **Instructions**: The main heading in the hero section

#### 2. Hero Subtitle
- **Field Label**: Hero Subtitle
- **Field Name**: `hero_subtitle`
- **Field Type**: Text
- **Default Value**: Digital Creator • Developer • Designer
- **Instructions**: Tagline below your name

#### 3. Avatar Image
- **Field Label**: Avatar Image
- **Field Name**: `avatar_image`
- **Field Type**: Image
- **Return Format**: Image Array
- **Instructions**: Your profile photo (200x200px recommended)

#### 4. About Text
- **Field Label**: About Text
- **Field Name**: `about_text`
- **Field Type**: WYSIWYG Editor
- **Instructions**: Your bio/about section text

#### 5. Social Links
- **Field Label**: Social Links
- **Field Name**: `social_links`
- **Field Type**: Repeater
- **Button Label**: Add Link

  **Sub-fields for Repeater:**
  - **Title** (Text): e.g., "GitHub", "Twitter"
  - **Icon** (Text): Emoji, e.g., 💻, 🐦, 💼
  - **URL** (URL): Full URL to your profile
  - **Description** (Text): Short description

#### 6. Meta Description
- **Field Label**: Meta Description
- **Field Name**: `meta_description`
- **Field Type**: Text Area
- **Instructions**: SEO meta description for homepage

## Step 3: Fill in Your Content

1. Edit the "Home" page
2. Scroll down to "Homepage Settings" field group
3. Fill in all fields:
   - **Hero Title**: Your Name
   - **Hero Subtitle**: Your tagline
   - **Avatar Image**: Upload your photo
   - **About Text**: Write your bio
   - **Social Links**: Add rows for each social media link
   - **Meta Description**: Add SEO description
4. Click **Update**

## Step 4: Create Posts for "Recent Updates"

1. Go to **Posts** → **Add New**
2. Create a few blog posts
3. These will automatically appear in the "Recent Updates" section
4. You can also add ACF fields to posts if needed

## Example Social Links Setup

In the Social Links repeater, add rows like this:

| Title    | Icon | URL                              | Description                    |
|----------|------|----------------------------------|--------------------------------|
| GitHub   | 💻   | https://github.com/yourusername  | Check out my code and projects |
| Twitter  | 🐦   | https://twitter.com/yourusername | Follow me for updates          |
| LinkedIn | 💼   | https://linkedin.com/in/you      | Professional network           |
| Email    | ✉️   | mailto:your@email.com            | Get in touch directly          |

## Step 5: Test Your Setup

1. Make sure your WordPress is accessible at `https://api.st33.com`
2. Test the REST API endpoints:
   - Pages: `https://api.st33.com/wp-json/wp/v2/pages?slug=home`
   - Posts: `https://api.st33.com/wp-json/wp/v2/posts`
3. Check that ACF fields appear in the response (look for `acf` object)

## Advanced: Custom Post Types

### Create a Custom Post Type (e.g., "Projects")

Add this to your theme's `functions.php`:

```php
function create_projects_post_type() {
    register_post_type('projects',
        array(
            'labels' => array(
                'name' => __('Projects'),
                'singular_name' => __('Project')
            ),
            'public' => true,
            'has_archive' => true,
            'show_in_rest' => true, // Important for REST API
            'rewrite' => array('slug' => 'projects'),
            'supports' => array('title', 'editor', 'thumbnail', 'custom-fields')
        )
    );
}
add_action('init', 'create_projects_post_type');
```

### Create ACF Fields for Projects

Create a new Field Group:
- **Location Rule**: Post Type is equal to Projects

Add custom fields like:
- Project URL (URL)
- Technologies Used (Text)
- Featured (True/False)
- Screenshots (Gallery)

### Fetch Custom Post Types in Astro

In your Astro pages:

```astro
---
import { getCustomPostType } from '../lib/wordpress';

const projects = await getCustomPostType('projects');
---

{projects.map(project => (
  <div>
    <h3>{project.title.rendered}</h3>
    <p>{project.acf.project_url}</p>
    <p>{project.acf.technologies_used}</p>
  </div>
))}
```

## Troubleshooting

### ACF Fields Not Appearing in API

1. Make sure ACF to REST API plugin is installed, OR
2. Add this to `functions.php`:
```php
add_filter('acf/settings/rest_api_format', function () {
    return 'standard';
});
```

### CORS Errors

Make sure you have CORS configured in WordPress (see WORDPRESS_SETUP.md)

### 404 on API Endpoints

1. Go to **Settings** → **Permalinks**
2. Click **Save Changes** (even without changing anything)
3. This flushes rewrite rules

## Next Steps

- Create additional pages for different sections
- Add custom post types for portfolios, testimonials, etc.
- Use ACF Options pages for site-wide settings
- Create dynamic Astro pages for your custom content

## Content Structure Reference

Your WordPress content structure will mirror to:

```
WordPress                  →  Astro Frontend
─────────────────────────────────────────────
Pages/Home                 →  index.astro
  ↳ ACF Fields            →  Dynamic content
Posts                      →  Recent Updates section
Custom Post Types          →  Dynamic pages
  ↳ Projects              →  /projects
  ↳ Testimonials          →  /testimonials
```
