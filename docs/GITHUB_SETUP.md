# GitHub Setup Guide

This guide walks you through setting up your GitHub repository and configuring it for automated deployments.

## 1. Create GitHub Repository

### Option A: Via GitHub Website

1. Go to [GitHub](https://github.com) and sign in
2. Click the **+** icon in top right → **New repository**
3. Fill in repository details:
   - **Repository name**: `st33-astro-wordpress` (or your preferred name)
   - **Description**: "Astro frontend with WordPress backend"
   - **Visibility**: Public or Private
   - **DO NOT** initialize with README (we have one already)
4. Click **Create repository**

### Option B: Via GitHub CLI

```bash
gh repo create st33-astro-wordpress --public --source=. --remote=origin --push
```

## 2. Push Your Code to GitHub

If you haven't initialized git yet:

```bash
# Initialize git repository
git init

# Add all files
git add .

# Create first commit
git commit -m "Initial commit: Astro + WordPress + Cloudflare setup"

# Rename branch to main (if needed)
git branch -M main

# Add remote origin (replace with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/st33-astro-wordpress.git

# Push to GitHub
git push -u origin main
```

## 3. Configure GitHub Secrets

GitHub Secrets store sensitive information securely for your CI/CD pipeline.

### Navigate to Secrets

1. Go to your repository on GitHub
2. Click **Settings** (top menu)
3. In left sidebar, click **Secrets and variables** → **Actions**
4. Click **New repository secret**

### Add Required Secrets

#### Secret 1: CLOUDFLARE_API_TOKEN

1. Log into [Cloudflare Dashboard](https://dash.cloudflare.com)
2. Click on your profile icon → **My Profile**
3. Select **API Tokens** from left menu
4. Click **Create Token**
5. Use template **Edit Cloudflare Workers** or create custom token with:
   - Permissions:
     - Account - Cloudflare Pages - Edit
   - Account Resources:
     - Include - Your account
6. Click **Continue to summary** → **Create Token**
7. **IMPORTANT**: Copy the token immediately (you won't see it again)
8. In GitHub, create secret:
   - **Name**: `CLOUDFLARE_API_TOKEN`
   - **Value**: Paste your token
   - Click **Add secret**

#### Secret 2: CLOUDFLARE_ACCOUNT_ID

1. In Cloudflare Dashboard, click **Workers & Pages**
2. Your Account ID is displayed on the right sidebar
3. Or find it in the URL: `dash.cloudflare.com/[ACCOUNT_ID]/workers-and-pages`
4. Copy the 32-character hex string
5. In GitHub, create secret:
   - **Name**: `CLOUDFLARE_ACCOUNT_ID`
   - **Value**: Paste your account ID
   - Click **Add secret**

#### Secret 3: WORDPRESS_API_URL

1. This is your WordPress REST API endpoint URL
2. Format: `https://your-domain.com/wp-json/wp/v2`
3. Example: `https://myblog.hostinger.com/wp-json/wp/v2`
4. In GitHub, create secret:
   - **Name**: `WORDPRESS_API_URL`
   - **Value**: Your WordPress API URL
   - Click **Add secret**

### Verify Secrets

After adding all secrets, you should see:
- CLOUDFLARE_API_TOKEN
- CLOUDFLARE_ACCOUNT_ID
- WORDPRESS_API_URL

## 4. Configure Branch Protection (Optional)

Protect your main branch from direct pushes:

1. Go to **Settings** → **Branches**
2. Click **Add rule** under "Branch protection rules"
3. Branch name pattern: `main`
4. Enable:
   - ✅ Require a pull request before merging
   - ✅ Require status checks to pass before merging
   - Select: Your deployment workflow
5. Click **Create** or **Save changes**

## 5. Test GitHub Actions Workflow

### Automatic Trigger

The workflow runs automatically when you push to main:

```bash
# Make a change
echo "# Test" >> README.md

# Commit and push
git add README.md
git commit -m "Test deployment"
git push origin main
```

### Monitor Deployment

1. Go to your repository on GitHub
2. Click **Actions** tab
3. You'll see your workflow running
4. Click on the workflow to see detailed logs
5. If successful, you'll see green checkmarks ✅

### Manual Trigger (Optional)

Add this to your workflow file to enable manual runs:

```yaml
on:
  push:
    branches: [main]
  workflow_dispatch:  # Add this line
```

Then trigger manually:
1. Go to **Actions** tab
2. Select your workflow
3. Click **Run workflow** button

## 6. Set Up GitHub Pages (Optional)

If you want documentation on GitHub Pages:

1. Go to **Settings** → **Pages**
2. Under "Source", select **Deploy from a branch**
3. Branch: `main`, Folder: `/docs`
4. Click **Save**

## Common Git Commands

### Daily Workflow

```bash
# Check status
git status

# Add changes
git add .

# Commit with message
git commit -m "Description of changes"

# Push to GitHub
git push origin main
```

### Create a Feature Branch

```bash
# Create and switch to new branch
git checkout -b feature/my-feature

# Make changes, then commit
git add .
git commit -m "Add new feature"

# Push branch to GitHub
git push origin feature/my-feature

# Create Pull Request on GitHub
# After merge, switch back to main
git checkout main
git pull origin main
```

### Undo Changes

```bash
# Discard unstaged changes
git checkout -- file.txt

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1
```

### View History

```bash
# View commit history
git log --oneline

# View changes in a file
git log -p file.txt

# View remote info
git remote -v
```

## Troubleshooting

### Authentication Issues

If you have authentication problems:

#### Use Personal Access Token (PAT)

1. Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click **Generate new token** → **Generate new token (classic)**
3. Name: "Git CLI Access"
4. Scopes: Select `repo`
5. Click **Generate token**
6. Copy the token
7. When pushing, use token as password:
   ```bash
   git push https://github.com/YOUR_USERNAME/REPO.git
   # Username: your-username
   # Password: paste-your-token
   ```

#### Cache Credentials

```bash
# Cache for 1 hour
git config --global credential.helper 'cache --timeout=3600'

# Or use credential manager
git config --global credential.helper manager
```

### Workflow Not Running

1. Check **Actions** tab is enabled:
   - Settings → Actions → General
   - Ensure "Allow all actions and reusable workflows" is selected
2. Verify workflow file path: `.github/workflows/deploy.yml`
3. Check YAML syntax is correct
4. Verify branch name matches (main vs master)

### Secrets Not Working

1. Verify secret names match exactly (case-sensitive)
2. Secrets are only available in workflows, not in logs
3. Re-create secret if value is incorrect
4. Check workflow has permissions to access secrets

### Push Rejected

```bash
# Pull latest changes first
git pull origin main --rebase

# Then push
git push origin main
```

## Best Practices

1. **Commit Messages**: Use clear, descriptive commit messages
2. **Small Commits**: Commit logical units of work
3. **Pull Before Push**: Always pull latest changes before pushing
4. **Branch Strategy**: Use feature branches for new features
5. **Code Review**: Use pull requests for code review
6. **Protect Main**: Enable branch protection on main branch
7. **Backup**: GitHub is your backup, but keep local copies

## Next Steps

1. ✅ Repository created and code pushed
2. ✅ GitHub Secrets configured
3. ✅ GitHub Actions workflow tested
4. → Move to [Cloudflare setup](CLOUDFLARE_SETUP.md)
5. → Complete [WordPress configuration](WORDPRESS_SETUP.md)

## Additional Resources

- [GitHub Docs](https://docs.github.com)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [GitHub Skills](https://skills.github.com/)
