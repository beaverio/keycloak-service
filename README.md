# Keycloak Multi-Environment Configuration Management

## Overview
This directory contains environment-specific Keycloak configurations that build separate Docker images for each environment using GitHub Actions CI/CD. Each environment gets its own Keycloak instance with only the relevant realm configuration.

## Multi-Environment Architecture

### Separate AWS Accounts Strategy + GitHub Actions
- **Dev Account**: Keycloak instance with only `dev` realm (deployed from `develop` branch)
- **Staging Account**: Keycloak instance with only `staging` realm (deployed from `staging` branch)
- **Production Account**: Keycloak instance with only `prod` realm (deployed from `main` branch)

### Automated CI/CD Pipeline
- **Branch-based deployments**: Each branch automatically deploys to its corresponding AWS account
- **Environment-specific images**: GitHub Actions builds separate Docker images for each environment
- **ECR integration**: Images are automatically pushed to AWS ECR in the appropriate account

## Environment Configurations

### Development (`beaver-dev-realm.json`)
- **Realm**: `dev`
- **SSL**: Disabled for local development
- **URLs**: `localhost:8080` and `localhost:3000`
- **Test Users**: Includes `testuser` and `admin` with simple passwords
- **Deployment**: Push to `develop` branch → auto-deploy to dev AWS account

### Staging (`beaver-staging-realm.json`)
- **Realm**: `staging`
- **SSL**: Required for external requests
- **URLs**: `https://staging.yourapp.com`
- **Test Users**: None (clean environment)
- **Deployment**: Push to `staging` branch → auto-deploy to staging AWS account

### Production (`beaver-prod-realm.json`)
- **Realm**: `prod`
- **SSL**: Required for all requests
- **URLs**: `https://app.yourcompany.com`
- **Test Users**: None (production-ready)
- **Deployment**: Push to `main` branch → auto-deploy to production AWS account

## Local Development

### Running with IntelliJ Docker Services
1. Open your project in IntelliJ IDEA
2. Navigate to the `docker-compose.yml` file in `services/keycloak-service/`
3. Click the green arrow next to `services:` or right-click and select "Run"
4. IntelliJ will automatically:
   - Create the `beaver-network` if needed
   - Build the `keycloak-service:dev` image
   - Start both `keycloak-db` and `keycloak-service` containers
   - Show logs in the Services tool window

### Access Development Environment
- **Admin Console**: http://localhost:8090/admin/
- **Username**: `admin`
- **Password**: `admin_password`
- **Realm**: `dev`

### Test Users (Development Only)
- **Regular User**: `testuser` / `password123`
- **Admin User**: `admin` / `admin123`

### Exporting Realm Configuration
If you make changes in the Keycloak Admin UI and want to save them:
```bash
./export-realm.sh
```
This exports your current realm configuration to a timestamped JSON file that you can review and use to update `realm-config/beaver-dev-realm.json`.

## GitHub Actions CI/CD Deployment

### Deployment Workflow
1. **Make changes** to realm configurations or Dockerfile
2. **Commit changes** to git
3. **Push to appropriate branch**:
   - `develop` → triggers dev deployment
   - `staging` → triggers staging deployment  
   - `main` → triggers production deployment
4. **GitHub Actions automatically**:
   - Builds environment-specific Docker image
   - Pushes to AWS ECR in the correct account
   - Triggers your deployment pipeline (ECS/EKS/etc.)

### GitHub Secrets Setup
Configure these secrets in your GitHub repository:
- `AWS_ACCESS_KEY_ID` - For each AWS account
- `AWS_SECRET_ACCESS_KEY` - For each AWS account

Use GitHub Environments (development, staging, production) to configure separate AWS credentials for each account.

### Environment Variables in AWS
Production environment variables are managed by your AWS deployment system:
- **ECS**: Task definition environment variables
- **EKS**: ConfigMaps and Secrets
- **Systems Manager**: Parameter Store for sensitive values

No local .env files needed - all managed in AWS.

### Deployment Examples

#### Deploy to Development
```bash
git checkout develop
# Make your changes to realm configs
git add services/keycloak-service/realm-config/beaver-dev-realm.json  
git commit -m "Update dev realm configuration"
git push origin develop  # 🚀 Auto-deploys to dev AWS account
```

#### Deploy to Staging
```bash
git checkout staging
git merge develop  # Or cherry-pick specific commits
git push origin staging  # 🚀 Auto-deploys to staging AWS account
```

#### Deploy to Production
```bash
git checkout main
git merge staging  # Deploy tested changes
git push origin main  # 🚀 Auto-deploys to production AWS account
```

## Configuration Management

### Method 1: Edit JSON Files (Recommended)
1. Edit the appropriate `beaver-{env}-realm.json` file
2. Commit and push to the appropriate branch
3. GitHub Actions automatically rebuilds and deploys

### Method 2: Export from UI (For Complex Changes)
1. Make changes in Keycloak Admin UI locally
2. Export realm: `./export-realm.sh`
3. Replace the JSON file with exported content
4. Commit and push to deploy

## Key Benefits

✅ **Automated Deployments** - No manual deployment commands needed
✅ **Environment Isolation** - Each AWS account only gets its relevant configuration
✅ **Branch-based Strategy** - Clear deployment workflow via Git branches
✅ **Smaller Images** - Each image contains only one realm configuration  
✅ **Security** - No local AWS credentials needed for deployments
✅ **Audit Trail** - All deployments tracked through Git commits
✅ **No Environment File Management** - AWS handles all production environment variables

## File Structure
```
.github/workflows/
└── keycloak-deploy.yml                 # GitHub Actions CI/CD pipeline

keycloak-service/
├── Dockerfile                          # Multi-environment Dockerfile with build args
├── docker-compose.yml                  # Single file for local development only
├── export-realm.sh                     # Export realm configuration from running container
└── realm-config/
    ├── beaver-dev-realm.json           # Development realm
    ├── beaver-staging-realm.json       # Staging realm
    └── beaver-prod-realm.json          # Production realm
```

## Troubleshooting

### GitHub Actions Fails
- Check AWS credentials are configured in GitHub Secrets
- Verify ECR repository exists in target AWS account
- Check workflow logs for specific error messages

### Local Development Issues
- Run Docker Compose through IntelliJ Docker Services
- Production deployments should only happen via GitHub Actions
- Use `./export-realm.sh` to save UI changes back to JSON files
