locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Environment = terraform.workspace
    ManagedBy   = "Terraform"
  }
}


module "network" {
  source = "./modules/network"
  prefix = local.prefix
  tags   = local.common_tags
}

module "certificates" {
  source = "./modules/acm"

  domain_name = var.domain_name

  providers = {
    aws.eu_west_region = aws
    aws.us_east_region = aws.us_east_region
  }
}

module "dns" {
  source = "./modules/dns"

  domain_name = var.domain_name
  prefix      = local.prefix

  records = [
    {
      name        = "${local.prefix}-grafana-workspace"
      dns_name    = "${terraform.workspace}.grafana.${var.domain_name}"
      hosted_zone = "public"
      records     = ["https://${module.aws_grafana.grafana_workspace_url}"]
      type        = "CNAME"
    },
    {
      name        = "${local.prefix}-cloudfront"
      dns_name    = module.cloudfront.aliases[0]
      hosted_zone = "public"
      type        = "A"
      alias_name  = module.cloudfront.cloudfront_distribution_domain
      alias_zone  = module.cloudfront.cloudfront_distribution_zone_id
    }
  ]

  tags = local.common_tags
}