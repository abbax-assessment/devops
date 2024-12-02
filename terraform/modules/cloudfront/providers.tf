provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "us_east"
  region = "us-east-1"
}