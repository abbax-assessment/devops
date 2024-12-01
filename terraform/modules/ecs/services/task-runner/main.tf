data "aws_region" "current" {}

locals {
  service_prefix    = "${var.prefix}-${var.app_name}"
  initial_image_uri = "scratch"
  ecr_repo_name     = "${local.service_prefix}-ecr"
}

resource "aws_ecr_repository" "this" {
  name                 = local.ecr_repo_name
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "this" {
  name = "${local.service_prefix}-logs"
  tags = var.tags
}

resource "aws_cloudwatch_log_group" "xray" {
  name = "${local.service_prefix}-xray-logs"
  tags = var.tags
}