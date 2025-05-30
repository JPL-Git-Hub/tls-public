#!/bin/bash
# Sync gcloud secrets to GitHub repository secrets

set -e

echo "Syncing secrets from Google Secret Manager to GitHub..."

# Check if gh CLI is authenticated
if ! gh auth status >/dev/null 2>&1; then
    echo "Error: GitHub CLI not authenticated. Run 'gh auth login' first."
    exit 1
fi

# Get the GitHub token from gcloud secrets
export GH_TOKEN=$(gcloud secrets versions access latest --secret="github-token" 2>/dev/null || echo "")
if [ -z "$GH_TOKEN" ]; then
    echo "Error: Could not retrieve github-token from Secret Manager"
    exit 1
fi

# Repository
REPO="JPL-Git-Hub/tls-public"

echo "Setting up Firebase service account secret..."

# Get Firebase service account and set as GitHub secret
FIREBASE_SA=$(gcloud secrets versions access latest --secret="firebase-service-account")
if [ -n "$FIREBASE_SA" ]; then
    echo "$FIREBASE_SA" | gh secret set FIREBASE_SERVICE_ACCOUNT_THE_LAW_SHOP_457607 --repo="$REPO"
    echo "✓ Firebase service account secret set"
else
    echo "✗ Failed to retrieve Firebase service account"
fi

# Get GCP service account for workflow authentication
GCP_SA=$(gcloud secrets versions access latest --secret="gcp-service-account")
if [ -n "$GCP_SA" ]; then
    echo "$GCP_SA" | gh secret set GCP_SA_KEY --repo="$REPO"
    echo "✓ GCP service account secret set"
else
    echo "✗ Failed to retrieve GCP service account"
fi

echo "Done! GitHub Actions should now be able to deploy."