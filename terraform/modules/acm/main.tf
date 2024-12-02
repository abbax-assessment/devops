
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.2.0"
      configuration_aliases = [
        aws.eu_west_region,
        aws.us_east_region
      ]
    }
  }
}

data "aws_acm_certificate" "eu_west_region" {
  provider    = aws.eu_west_region
  domain      = "*.${var.domain_name}"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

data "aws_acm_certificate" "us_east_region" {
  provider    = aws.us_east_region
  domain      = "*.${var.domain_name}"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}
