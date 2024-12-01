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