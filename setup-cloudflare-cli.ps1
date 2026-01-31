# Cloudflare CLI Setup Script
# Sets up Wrangler for local development and manual deployments

Write-Host "🌐 Cloudflare Wrangler Setup" -ForegroundColor Cyan
Write-Host ""

# Step 1: Install dependencies
Write-Host "Step 1: Installing dependencies..." -ForegroundColor Yellow
npm install
Write-Host "✅ Dependencies installed" -ForegroundColor Green
Write-Host ""

# Step 2: Install Wrangler
Write-Host "Step 2: Installing Wrangler CLI..." -ForegroundColor Yellow
npm install -D wrangler@latest
Write-Host "✅ Wrangler installed" -ForegroundColor Green
Write-Host ""

# Step 3: Login to Cloudflare
Write-Host "Step 3: Login to Cloudflare" -ForegroundColor Yellow
Write-Host "This will open a browser window for authentication..." -ForegroundColor Gray
npx wrangler login
Write-Host "✅ Authenticated with Cloudflare" -ForegroundColor Green
Write-Host ""

# Step 4: Test build locally
Write-Host "Step 4: Testing local build..." -ForegroundColor Yellow
npm run build
Write-Host "✅ Build successful" -ForegroundColor Green
Write-Host ""

# Step 5: Show deployment command
Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Available commands:" -ForegroundColor Yellow
Write-Host "  npm run dev          - Start local dev server"
Write-Host "  npm run build        - Build for production"
Write-Host "  npm run preview      - Preview production build"
Write-Host "  npx wrangler pages deploy dist --project-name=st33-astro-wordpress"
Write-Host ""
Write-Host "To deploy to Cloudflare Pages:" -ForegroundColor Cyan
Write-Host "  npx wrangler pages deploy dist --project-name=st33-astro-wordpress"
Write-Host ""
Write-Host "Note: Make sure WORDPRESS_API_URL is set in .env for local testing" -ForegroundColor Gray
