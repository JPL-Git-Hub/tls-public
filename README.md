# The Law Shop Public Website

This repository hosts the public-facing website for thelawshop.com, including the client intake form.

## Setup

### Prerequisites
- Firebase CLI installed (`npm install -g firebase-tools`)
- Access to the `root-tls` Firebase project

### Local Development

1. Clone this repository
2. Run `firebase serve` to preview locally
3. The site will be available at http://localhost:5000

### Deployment

The site automatically deploys to Firebase Hosting when changes are pushed to the `main` branch via GitHub Actions.

#### Manual Deployment
```bash
firebase deploy --only hosting
```

### GitHub Actions Setup

To enable automatic deployment, you need to:

1. Create a Firebase service account:
   ```bash
   firebase init hosting:github
   ```

2. Add the service account key as a GitHub secret named `FIREBASE_SERVICE_ACCOUNT_ROOT_TLS`

### DNS Configuration

The domain thelawshop.com is configured with the following DNS records:
- CNAME: thelawshop.com → root-tls.web.app
- SSL certificates are automatically provisioned by Firebase Hosting

## Project Structure

```
├── public/             # Static files served by Firebase Hosting
│   └── index.html     # Client intake form
├── firebase.json      # Firebase configuration
├── .firebaserc       # Firebase project configuration
└── .github/          # GitHub Actions workflows
    └── workflows/
        ├── firebase-hosting-merge.yml
        └── firebase-hosting-pull-request.yml
```# Deployment test
