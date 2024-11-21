# Terraform Project Setup and AWS Vault Configuration

This repository contains a Terraform project for managing AWS infrastructure, including creating a DynamoDB table and an S3 bucket for Terraform state management, IAM roles, and policies. This `README.md` will guide you through the initial setup and the process of using `aws-vault` to securely manage your AWS credentials.

## Prerequisites

Before starting, make sure you have the following installed:

- **Terraform**: [Download Terraform](https://www.terraform.io/downloads.html)
- **AWS CLI**: [Download AWS CLI](https://aws.amazon.com/cli/)
- **aws-vault**: [aws-vault Installation](https://github.com/99designs/aws-vault#installing)

### Setup Steps

#### 1. Clone the Repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/your-username/terraform-aws-project.git
cd terraform-aws-project
