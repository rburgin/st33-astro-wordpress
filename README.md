# Astro + WordPress + Cloudflare Pages Project

This project combines an Astro frontend hosted on Cloudflare Pages with a WordPress backend on Hostinger, featuring automated CI/CD deployment through GitHub Actions.

## 🏗️ Architecture

- **Frontend**: Astro (SSR) → Cloudflare Pages
- **Backend**: WordPress → Hostinger
- **Version Control**: GitHub
- **CI/CD**: GitHub Actions

## 🚀 Getting Started

### Prerequisites

- Node.js 18+ installed
- GitHub account
- Cloudflare account
- Hostinger hosting with WordPress installed

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
   cd YOUR_REPO
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Configure environment variables**
   ```bash
   cp .env.example .env
   ```
   
   Edit `.env` and add your WordPress URL:
   ```
   WORDPRESS_API_URL=https://your-site.com/wp-json/wp/v2
   ```

4. **Run development server**
   ```bash
   npm run dev
   ```
   
   Visit `http://localhost:4321`

## 📦 Deployment Setup

### 1. WordPress Setup on Hostinger

1. Log into your Hostinger account
2. Install WordPress through the Hostinger control panel
3. Configure your WordPress site
4. **Enable REST API** (enabled by default)
5. For better security, consider installing a plugin like "Application Passwords" for API authentication
6. Note your WordPress site URL (e.g., `https://yoursite.com`)

### 2. GitHub Repository Setup

1. Create a new repository on GitHub
2. Initialize and push your code:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git push -u origin main
   ```

### 3. Cloudflare Pages Setup

1. Log into [Cloudflare Dashboard](https://dash.cloudflare.com)
2. Go to **Workers & Pages** → **Create application** → **Pages**
3. Connect your GitHub account
4. Select your repository
5. Configure build settings:
   - **Build command**: `npm run build`
   - **Build output directory**: `dist`
   - **Framework preset**: Astro
6. Add environment variable:
   - `WORDPRESS_API_URL`: Your WordPress REST API URL
7. Click **Save and Deploy**

### 4. GitHub Secrets Configuration

For automated deployments, add these secrets to your GitHub repository:

1. Go to your repository → **Settings** → **Secrets and variables** → **Actions**
2. Click **New repository secret** and add:

   - **CLOUDFLARE_API_TOKEN**
     - Go to Cloudflare Dashboard → My Profile → API Tokens
     - Create token with "Cloudflare Pages - Edit" permission
     - Copy and save as secret

   - **CLOUDFLARE_ACCOUNT_ID**
     - Found in Cloudflare Dashboard URL or Workers & Pages overview
     - Format: 32 character hex string
     - Copy and save as secret

   - **WORDPRESS_API_URL**
     - Your WordPress REST API endpoint
     - Example: `https://your-hostinger-site.com/wp-json/wp/v2`
     - Copy and save as secret

## 🔄 CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/deploy.yml`) automatically:

1. Triggers on push to `main` branch or pull requests
2. Installs dependencies
3. Builds the Astro site with WordPress data
4. Deploys to Cloudflare Pages

### Manual Deployment

You can also deploy manually using:

```bash
npm run build
npm run deploy
```

## 📁 Project Structure

```
st33/
├── .github/
│   └── workflows/
│       └── deploy.yml          # CI/CD pipeline
├── src/
│   ├── lib/
│   │   └── wordpress.ts        # WordPress API utilities
│   ├── pages/
│   │   ├── index.astro         # Homepage (lists posts)
│   │   └── post/
│   │       └── [slug].astro    # Individual post page
│   └── env.d.ts                # TypeScript environment types
├── .env.example                # Environment variables template
├── .gitignore                  # Git ignore rules
├── astro.config.mjs            # Astro configuration
├── package.json                # Dependencies and scripts
├── tsconfig.json               # TypeScript configuration
└── wrangler.toml               # Cloudflare configuration
```

## 🔗 WordPress Integration

The project uses the WordPress REST API to fetch content:

- **Posts List**: `GET /wp-json/wp/v2/posts`
- **Single Post**: `GET /wp-json/wp/v2/posts?slug={slug}`

### Adding Authentication (Optional)

If your WordPress site requires authentication:

1. Install "Application Passwords" plugin in WordPress
2. Generate an application password
3. Add to your environment:
   ```
   WORDPRESS_USERNAME=your-username
   WORDPRESS_APP_PASSWORD=your-app-password
   ```
4. Update fetch calls in `src/lib/wordpress.ts` to include Basic Auth headers

## 🛠️ Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build
- `npm run deploy` - Manual deployment to Cloudflare

## 🔐 Security Best Practices

1. Never commit `.env` file to version control
2. Use GitHub Secrets for sensitive data
3. Enable CORS properly in WordPress if needed
4. Consider using WordPress authentication for sensitive endpoints
5. Keep dependencies updated: `npm update`

## 🐛 Troubleshooting

### WordPress API not responding
- Verify your WordPress URL is correct
- Check WordPress REST API is enabled
- Test the API: `https://your-site.com/wp-json/wp/v2/posts`
- Check CORS settings in WordPress

### Deployment failing
- Verify all GitHub Secrets are set correctly
- Check build logs in GitHub Actions
- Ensure Cloudflare API token has correct permissions

### Local development issues
- Ensure `.env` file exists and has correct values
- Clear cache: `rm -rf .astro node_modules && npm install`
- Check Node.js version: `node --version` (requires 18+)

## 📚 Additional Resources

- [Astro Documentation](https://docs.astro.build)
- [Cloudflare Pages Docs](https://developers.cloudflare.com/pages)
- [WordPress REST API](https://developer.wordpress.org/rest-api/)
- [GitHub Actions Docs](https://docs.github.com/en/actions)

## 📝 License

MIT

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
