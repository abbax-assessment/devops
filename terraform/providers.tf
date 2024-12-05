provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "us_east_region"
  region = "us-east-1"
}