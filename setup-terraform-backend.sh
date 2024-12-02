#!/bin/bash

# Variables
S3_BUCKET_NAME="tsk-terraform-state-bucket"
DYNAMODB_TABLE_NAME="terraform-lock-table"
REGION="eu-west-1"
TF_BACKEND_FILE="./terraform/backend.tf"

# Ensure the script is run with proper permissions (AWS CLI configured)
if ! command -v aws &> /dev/null
then
    echo "AWS CLI is required but not found. Please install AWS CLI."
    exit 1
fi

if ! command -v terraform &> /dev/null
then
    echo "Terraform is required but not found. Please install Terraform."
    exit 1
fi

# Step 1: Create the DynamoDB table for state locking
echo "Creating DynamoDB table for state locking..."

aws dynamodb create-table \
    --table-name $DYNAMODB_TABLE_NAME \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region $REGION

if [ $? -ne 0 ]; then
    echo "Error: Failed to create DynamoDB table."
    exit 1
fi

echo "DynamoDB table created: $DYNAMODB_TABLE_NAME"

# Step 2: Create the S3 bucket for storing Terraform state
echo "Creating S3 bucket for Terraform state..."

aws s3api create-bucket \
    --bucket $S3_BUCKET_NAME \
    --region $REGION \
    --create-bucket-configuration LocationConstraint=$REGION \
    --profile $PROFILE

if [ $? -ne 0 ]; then
    echo "Error: Failed to create S3 bucket."
    exit 1
fi

echo "S3 bucket created: $S3_BUCKET_NAME"

# Step 3: Create Terraform backend configuration file (backend.tf)
echo "Creating Terraform backend configuration..."

cat > $TF_BACKEND_FILE <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
  }

  backend "s3" {
    bucket         = "$S3_BUCKET_NAME"
    key            = "aws.tfstate"
    region         = "$REGION"
    dynamodb_table = "$DYNAMODB_TABLE_NAME"
    encrypt        = true
  }
}
EOF

echo "Terraform backend configuration file created: $TF_BACKEND_FILE"

# Step 4: Initialize Terraform with the new backend
echo "Initializing Terraform backend..."

terraform init

if [ $? -ne 0 ]; then
    echo "Error: Failed to initialize Terraform backend."
    exit 1
fi

echo "Terraform backend initialized successfully!"
echo "Terraform is initializing dev, stage, production workspaces"
terraform workspace create dev
terraform workspace create stage
terraform workspace create production
terraform workspace delete default
# Final output with instructions to the user
echo "
------------------------------------------------------------------------------
Setup Complete!
- DynamoDB Table: $DYNAMODB_TABLE_NAME (Used for state locking)
- S3 Bucket: $S3_BUCKET_NAME (Used for storing the Terraform state file)
- Terraform backend configuration created in $TF_BACKEND_FILE
- Terraform backend has been initialized.
- Terraform workspaces have been initialized.

You can now proceed with your Terraform workflow. 
------------------------------------------------------------------------------
"