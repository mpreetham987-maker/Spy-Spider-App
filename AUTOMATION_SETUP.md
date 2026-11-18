# Automated Codemagic build trigger

This repository has a GitHub Actions workflow that triggers a Codemagic Android build on qualifying pushes and manual dispatch.

## Required GitHub repository secrets

Set these under **Settings → Secrets and variables → Actions → New repository secret**:

- `CODEMAGIC_API_TOKEN`: Codemagic personal API token (Account settings → API token).
- `CODEMAGIC_APP_ID`: App ID from the Codemagic app URL (the value after `/app/`).

The workflow calls the Codemagic Builds API with workflow ID `android-release` and the branch that triggered the GitHub workflow.

## Trigger manually

GitHub repository → Actions → **Trigger Codemagic Android build** → Run workflow.

## Security and limitations

- Secrets are stored in GitHub Actions secrets, not committed into source.
- The workflow only triggers a build and publishes a build link in its GitHub Actions summary.
- This does not yet implement autonomous AI code repair. Automatic source rewriting is deliberately not enabled until an AI repair service and tightly scoped GitHub credentials are configured, tested, and protected with limits and review.
- Build logs and artifacts remain available in Codemagic.
