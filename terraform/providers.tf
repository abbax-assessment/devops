provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "us_east_region"
  region = "us-east-1"
}

provider "grafana" {
  url  = "https://${module.aws_grafana.grafana_workspace_url}"
  auth = module.aws_grafana.github_service_token
}