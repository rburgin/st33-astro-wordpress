# ST33 Git Setup Script
# This script initializes your Git repository and prepares it for pushing to GitHub

Write-Host "🚀 ST33 Git Setup" -ForegroundColor Cyan
Write-Host ""

# Step 1: Configure Git credentials
Write-Host "Step 1: Configure Git credentials" -ForegroundColor Yellow
Write-Host "Enter your GitHub username:" -ForegroundColor White
$githubUsername = Read-Host

Write-Host "Enter your GitHub email:" -ForegroundColor White
$githubEmail = Read-Host

# Configure git globally
git config --global user.name "$githubUsername"
git config --global user.email "$githubEmail"

Write-Host "✅ Git configured with name: $githubUsername, email: $githubEmail" -ForegroundColor Green
Write-Host ""

# Step 2: Initialize repository
Write-Host "Step 2: Initialize Git repository" -ForegroundColor Yellow
git init
Write-Host "✅ Git repository initialized" -ForegroundColor Green
Write-Host ""

# Step 3: Add files
Write-Host "Step 3: Adding files to staging area" -ForegroundColor Yellow
git add .
Write-Host "✅ Files staged" -ForegroundColor Green
Write-Host ""

# Step 4: Create initial commit
Write-Host "Step 4: Creating initial commit" -ForegroundColor Yellow
git commit -m "Initial commit: Astro + WordPress + Cloudflare CI/CD setup"
Write-Host "✅ Initial commit created" -ForegroundColor Green
Write-Host ""

# Step 5: Rename branch to main
Write-Host "Step 5: Setting up main branch" -ForegroundColor Yellow
git branch -M main
Write-Host "✅ Branch renamed to 'main'" -ForegroundColor Green
Write-Host ""

# Step 6: Get repository URL
Write-Host "Step 6: Add GitHub remote" -ForegroundColor Yellow
Write-Host "Enter your GitHub repository URL:" -ForegroundColor White
Write-Host "Example: https://github.com/YOUR_USERNAME/st33-astro-wordpress.git" -ForegroundColor Gray
$repoUrl = Read-Host

# Add remote
git remote add origin $repoUrl
Write-Host "✅ Remote 'origin' added: $repoUrl" -ForegroundColor Green
Write-Host ""

# Step 7: Verify setup
Write-Host "Step 7: Verifying setup" -ForegroundColor Yellow
Write-Host ""
Write-Host "Git Configuration:" -ForegroundColor Cyan
git config --local user.name
git config --local user.email
Write-Host ""
Write-Host "Git Remote:" -ForegroundColor Cyan
git remote -v
Write-Host ""
Write-Host "Git Status:" -ForegroundColor Cyan
git status
Write-Host ""

# Step 8: Ready to push
Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Make sure you've created the repository on GitHub"
Write-Host "2. Run: git push -u origin main"
Write-Host ""
Write-Host "Need help with authentication?" -ForegroundColor Cyan
Write-Host "- GitHub recommends using Personal Access Tokens (PAT)"
Write-Host "- Or use GitHub CLI: winget install GitHub.cli"
