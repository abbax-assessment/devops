# setup admin cli access keys first and mfa to add to vault
#!/bin/bash

# Variables (modify as necessary)
S3_BUCKET="tsk-terraform-state-bucket"
DYNAMODB_TABLE="terraform-lock-table"
IAM_ROLE_NAME="terraform-role"
POLICY_NAME="terraform-policy"
REGION="eu-west-1"
JSON_FILE="terraform-role-policy.json"
ASSUME_JSON_FILE="terraform-role-assume-policy.json"

# Check if the policy JSON file exists
if [[ ! -f "$JSON_FILE" ]]; then
  echo "Error: Policy JSON file '$JSON_FILE' not found!"
  exit 1
fi

# Read the JSON content from the file
POLICY_DOCUMENT=$(cat "$JSON_FILE")
# Step 1: Create S3 bucket for Terraform state storage
echo "Creating S3 bucket for Terraform state..."
aws s3api create-bucket --bucket $S3_BUCKET --region $REGION --create-bucket-configuration LocationConstraint=$REGION
if [ $? -ne 0 ]; then
    echo "Failed to create S3 bucket"
    exit 1
else
    echo "S3 bucket created successfully"
fi

# # Step 2: Enable versioning on the S3 bucket (recommended for Terraform state)
echo "Enabling versioning on S3 bucket..."
aws s3api put-bucket-versioning --bucket $S3_BUCKET --versioning-configuration Status=Enabled
if [ $? -ne 0 ]; then
    echo "Failed to enable versioning on S3 bucket"
    exit 1
else
    echo "Versioning enabled successfully on S3 bucket"
fi

# # Step 3: Create DynamoDB table for state locking
echo "Creating DynamoDB table for state locking..."
aws dynamodb create-table \
    --table-name $DYNAMODB_TABLE \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region $REGION
if [ $? -ne 0 ]; then
    echo "Failed to create DynamoDB table"
    exit 1
else
    echo "DynamoDB table created successfully"
fi

# Step 4: Create IAM policy for Terraform (basic EC2, S3, IAM access)
echo "Creating IAM policy for Terraform..."
aws iam create-policy \
    --policy-name $POLICY_NAME \
    --policy-document "$POLICY_DOCUMENT"
if [ $? -ne 0 ]; then
    echo "Failed to create IAM policy"
    exit 1
else
    echo "IAM policy created successfully"
fi

# Step 5: Create IAM role for Terraform
echo "Creating IAM role for Terraform..."
aws iam create-role \
    --role-name $IAM_ROLE_NAME \
    --assume-role-policy-document file://$ASSUME_JSON_FILE
if [ $? -ne 0 ]; then
    echo "Failed to create IAM role"
    exit 1
else
    echo "IAM role created successfully"
fi

# Step 6: Attach the policy to the IAM role
echo "Attaching policy to IAM role..."
aws iam attach-role-policy \
    --role-name $IAM_ROLE_NAME \
    --policy-arn arn:aws:iam::aws:policy/$POLICY_NAME
if [ $? -ne 0 ]; then
    echo "Failed to attach policy to IAM role"
    exit 1
else
    echo "Policy attached to IAM role successfully"
fi

# Summary of resources created
echo "--------------------------------------"
echo "Resources created:"
echo "S3 Bucket: $S3_BUCKET"
echo "DynamoDB Table: $DYNAMODB_TABLE"
echo "IAM Role: $IAM_ROLE_NAME"
echo "IAM Policy: $POLICY_NAME"
echo "--------------------------------------"
