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


module "sns_slack_topic" {
  count             = var.notifications_channel_slack_webhook != null ? 1 : 0
  source            = "./modules/sns"
  prefix            = local.prefix
  tags              = local.common_tags
  slack_webhook_url = var.notifications_channel_slack_webhook
}