# Terraform Infrastructure Repository

## Overview

This repository contains the configuration and scripts for managing infrastructure deployments using Terraform. It includes the setup for all AWS resources, deployment processes, monitoring configurations, and related automation.

## Prerequisites

Before you start, ensure you have the following installed and configured:

1. **AWS User Credentials**  
   - You need AWS access and secret keys with sufficient permissions to manage infrastructure.
   - Configure your credentials using the AWS CLI:
     ```bash
     aws configure
     ```
   - Alternatively, set the following environment variables:
     ```bash
     export AWS_ACCESS_KEY_ID=your-access-key-id
     export AWS_SECRET_ACCESS_KEY=your-secret-access-key
     ```

2. **Installed Tools**
   - **Terraform**: Download and install from [Terraform's official website](https://www.terraform.io/downloads.html).
   - **AWS CLI**: Download and install from [AWS CLI's official website](https://aws.amazon.com/cli/).

3. **Backend Initialization Script**  
   - The script `setup-terraform-backend.sh` sets up the Terraform backend for remote state management, including the creation of an S3 bucket and a DynamoDB table.

## Initial Setup

Follow these steps to initialize the Terraform backend:

1. Clone the repository:

   ```bash
   git clone https://github.com/eros-assessment/devops.git
   cd eros-assessment/devops
   chmod +x setup-terraform-backend.sh
   ./setup-terraform-backend.sh

## Repository Secrets Setup

To ensure secure and automated operations, you need to configure the following repository secrets in your GitHub repository. These secrets are required for CI/CD pipelines and infrastructure management.

### Required Secrets

1. **SNYK_TOKEN**  
   - A token for [Snyk](https://snyk.io/) to enable vulnerability scanning and reporting.
   - Obtain the token from your Snyk account and add it to the repository secrets.

2. **ORG_TOKEN**  
   - A GitHub fine-grained personal access token with administrative rights on the repository.
   - You can create this token via the GitHub Developer Settings:
     - Go to **Settings > Developer settings > Personal access tokens > Fine-grained tokens**.
     - Grant the token access to the repository with the necessary scopes.

3. **AWS_ACCESS_KEY_ID** and **AWS_SECRET_ACCESS_KEY**  
   - Credentials for an AWS user with sufficient permissions to manage resources.
   - Configure an AWS IAM user with programmatic access and the required permissions.

### Setting Secrets in GitHub

1. Navigate to your repository on GitHub.
2. Go to **Settings > Secrets and variables > Actions > New repository secret**.
3. Add each of the following secrets:
   - `SNYK_TOKEN` (org secret)
   - `ORG_TOKEN` (org secret)
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

---

Once the secrets are set up, you can trigger your workflows and Terraform deployments securely.