# Terraform Infrastructure Repository

## Overview

This project demonstrates an event-driven, highly scalable, highly available, fault tolerant infrastructure with fully automated CI/CD pipelines and monitoring.
- **Event driven**: Tasks are pushed to an AWS SQS Queue and consumers execute them
- **Highly scalable**: Scaling up to more workers increases the amount of tasks being completed every minute
- **Highly available**: It's spread across multi availability zones
- **Fault tolerant**: Each task which is not successfully completed gets retried

This repository contains the configuration and scripts for managing the infrastructure and configuration using Terraform. It includes the setup for all AWS resources, deployment processes, monitoring configurations, and related automation.

## Organisation Strcture 
```
/org
├──/devops (this repo)   # Entrypoint
├──/api                  # Simple NodeJS express API server
├──/task-runner          # Microservice that runs the app's tasks
└──/frontend             # Frontend app
```

Each repository has it's own Workflow CI file. The deployment process is being handled by this repo.

## Architecture
The project structure is divided into 3 main sections. 
1. AWS Infrastructure.

![alt text](icons/image-1.png)

2. Github Environments

![alt text](icons/image-2.png)

3. Monitoring

![alt text](icons/image-3.png)


## Prerequisites

Before you start, ensure you have the following installed and configured:

1. **AWS User Credentials**  
   - You need AWS access and secret keys with admin access to manage infrastructure.
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
Set the required secrets, variables to the organization and DevOps repo

1. **SNYK_TOKEN**  (secret)
   - A token for [Snyk](https://snyk.io/) to enable vulnerability scanning and reporting.
   - Obtain the token from your Snyk account and add it to the repository secrets.

2. **ORG_TOKEN**  (secret)
   - A GitHub fine-grained personal access token with administrative rights on the repository.
   - You can create this token via the GitHub Developer Settings:
     - Go to **Settings > Developer settings > Personal access tokens > Fine-grained tokens**.
     - Grant the token access to the repository with the necessary scopes.

3. **AWS_ACCESS_KEY_ID** and **AWS_SECRET_ACCESS_KEY**  (secret)
   - Credentials for an AWS user with sufficient permissions to manage resources.
   - Configure an AWS IAM user with programmatic access and the required permissions.
4. **AWS_DEFAULT_REGION**  (variable)
   - Default AWS Region.

### Setting Secrets/Variables in GitHub

1. Navigate to your repository on GitHub.
2. Go to **Settings > Secrets and variables > Actions > New repository secret/variable**.
3. Add each of the following secrets:
   - `SNYK_TOKEN` (org secret)
   - `ORG_TOKEN` (org secret)
   - `AWS_ACCESS_KEY_ID` (devops secret)
   - `AWS_SECRET_ACCESS_KEY`(devops secret)
   - `AWS_DEFAULT_REGION`(devops variable)

---
### DNS Name and Certificate setup
The project by default requires a domain name to enforce HTTPS. You will need to register your domain at [aws console](https://us-east-1.console.aws.amazon.com/route53/v2/hostedzones?region=eu-west-1)

![alt text](icons/image-13.png)

Create and validate your certificates your default region and `us-east-1` at [aws console](https://eu-west-1.console.aws.amazon.com/acm/home?region=eu-west-1#/welcome)

![alt text](icons/image-14.png).

Once the secrets and DNS name are set up, you can trigger your workflows and Terraform deployments securely.

## Deploy the app
You can setup as many environments as you want simply by creating a new terraform `workspace` . Each environment has it's own VPC, tagging and terraform state
```
terraform init
terraform workspace create dev
# create {workspace}.tfvars file at ./variables
terraform apply -var-file=./variables/dev.tfvars
```
After creating the resources you can go to your AWS console at Load Balancer section and visit `/` to fetch the frontend as forward some workload to the workers.

![alt text](icons/image-9.png)

Next, you may access the AWS Grafana dashboard that was created on your AWS console to get insights about the app status and DevOps metrics.

![alt text](icons/image-5.png)

![alt text](icons/image-6.png)

After finishing up you can tear down the infrastructure by running
```
terraform destroy -var-file=./variables/dev.tfvars
```

## Setup slack notifications (Optional)
You can use the [GitHub slack](https://slack.github.com/) bot to receive notifications about your workflow executions. You can find more information [here](https://github.com/integrations/slack)

![alt text](icons/image.png)

Additionally, `terraform apply` also creates an SNS topic which you can subscribe with [Incoming Webhooks](https://slack.com/marketplace/A0F7XDUAZ-incoming-webhooks) in order to receive alarm notifications for CPU/RAM scaling or other events.

![alt text](icons/image-10.png)

![alt text](icons/image-11.png)

Full guide on how to setup can be found [here](https://medium.com/@veeru1076/integrate-sns-with-slack-without-lambda-5bbaf500633a)


## Current Costs and Future Optimization
We can see on this diagram our application will cost around $85 per month (with 2 environments).

![alt text](icons/image-12.png)

### Cost analysis
It's visible from the costs explorer that the most expensive service is the EC2 Compute and the ECS. The future cost really depends on the expected traffic and user load.

1. Do I expect to have constant traffic throughout the day?
- If yes, then sticking to the current solution will be optimal because we will have low `idle` time running our ECS instances.
2. Do I expect to have low traffic with not many spikes?
- If yes, then switching to a serverless solution like AWS Lambda can be a cheaper alternative. It will significantly reduce the `idle` time and can be scaled up to a decent amount. A downside of Lambda functions are `cold-starts` during spikes which can affect user performance.
3. Do I expect to have normal traffic but big sudden spikes?
- If yes, a hybrid solution can be implemented. EC2 spot instances can be used for the daily normal traffic and scale up when needed by adding more EC2 instances, ECS Fargates tasks or AWS Lambda depending on the workload.

## Test Live Environment
The `dev` environment is live. You can navigate to the website to add tasks and then process to the grafana dashboard to monitor metrics, logs, scaling

- Website: https://dev.deveros.click
- Grafana:
   - URL: https://d-9367b65f82.awsapps.com/start
   - Username: dashboard-viewer
   - Password: 654765476547654!Ayfdg