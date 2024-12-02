terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.76.0"
    }
    grafana = {
      source  = "grafana/grafana"
      version = "3.13.2"
    }
  }

  backend "s3" {
    bucket         = "tsk-terraform-state-bucket"
    key            = "aws.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}